DROP VIEW IF EXISTS CL.VW_AttritionImpact
GO

CREATE VIEW CL.VW_AttritionImpact
AS 

WITH
Locations AS (
    SELECT
        L.LocationKey,
        L.LocationID AS AFNumber,
        L.CloseDate
    FROM DW.Location AS L
    WHERE 
		Brand = N'Anytime Fitness' 
		AND IsDomestic = 1
),
AttritionImpact AS (
    SELECT
        DD.FirstDayOfMonth,
        DD.LastDayOfMonth,
        A.LocationKey,
        NewAccounts             = ISNULL(A.NewAccounts , 0),
        RenewedAccounts         = ISNULL(A.RenewedAccounts, 0),
        RewrittenAccounts       = ISNULL(A.RewrittenAccounts, 0),
        ReinstatedFromInactive  = ISNULL(A.ReinstatedFromInactive, 0),
        TransferredIn           = ISNULL(A.TransferredIn, 0),
        OtherEntry              = ISNULL(A.Other, 0),
        CancelledAccounts       = ISNULL(A.CancelledAccounts, 0),
        ExpiredAccounts         = ISNULL(A.ExpiredAccounts, 0),
        TransferredOut          = ISNULL(A.TransferredOut, 0),
        ReturnedForCollections  = ISNULL(A.ReturnedForCollections, 0),
        OtherExit               = ISNULL(A.Other2, 0)
    FROM DW.Attrition AS A
		LEFT OUTER JOIN Master.DateDetail AS DD
			ON A.FileDate = DD.Date
)
SELECT
    FirstDayOfMonth,
    LastDayOfMonth,
    AFNumber,
    NewAccounts,
    RenewedAccounts,
    RewrittenAccounts,
    ReinstatedFromInactive,
    TransferredIn,
    OtherEntry,
    CancelledAccounts,
    ExpiredAccounts,
    TransferredOut,
    ReturnedForCollections,
    OtherExit,
    PositiveImpact	= (A.NewAccounts + A.RenewedAccounts + A.RewrittenAccounts + A.ReinstatedFromInactive + A.TransferredIn + A.OtherEntry),
    NegativeImpact	= (A.CancelledAccounts + A.ExpiredAccounts + A.TransferredOut + A.ReturnedForCollections + A.OtherExit),    
    NetImpact		= (A.NewAccounts + A.RenewedAccounts + A.RewrittenAccounts + A.ReinstatedFromInactive + A.TransferredIn + A.OtherEntry) - (A.CancelledAccounts + A.ExpiredAccounts + A.TransferredOut + A.ReturnedForCollections + A.OtherExit)
FROM Locations AS L
LEFT OUTER JOIN AttritionImpact AS A
    ON L.LocationKey = A.LocationKey
	AND A.FirstDayOfMonth<= L.CloseDate;