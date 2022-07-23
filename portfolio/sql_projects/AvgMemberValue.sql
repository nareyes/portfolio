DROP VIEW IF EXISTS CL.VW_AFDomesticAverageMemberValue
GO

CREATE VIEW CL.VW_AFDomesticAverageMemberValue
AS

WITH
Revenue AS (
    SELECT
        FirstDayOfMonth,
        LastDayOfMonth,
        AFNumber,
        MembershipRevenue,
        MembershipRevenueUSD,
        PPVRevenue,
        PPVRevenueUSD,
        PTRevenue,
        PTRevenueUSD,
        ClubReadyPTRevenue,
        ClubReadyPTRevenueUSD,
        TotalRevenue,
        TotalRevenueUSD,
        TotalRevenueWithClubReady,
        TotalRevenueWithClubReadyUSD
    FROM CL.VW_MonthlyRevenue
),
Member AS (
    SELECT
        M.FirstDayOfMonth,
        M.AFNumber,
        M.AbcBaseMemberCount,
        M.PPVBaseMemberCount,
        M.BaseMemberPlus,
        PT.PTMember AS PTMemberCount
    FROM CL.VW_MonthlyBaseMember AS M
        LEFT OUTER JOIN CL.VW_MonthlyPTMember AS PT
            ON M.AFNumber = PT.AFNumber AND M.FirstDayOfMonth = PT.FirstDayOfMonth
)
SELECT
    R.FirstDayOfMonth,
    R.LastDayOfMonth,
    R.AFNumber,
    MembershipRevenue               = ISNULL (R.MembershipRevenue, 0.00),
    MembershipRevenueUSD            = ISNULL (R.MembershipRevenueUSD, 0.00),
    PPVRevenue                      = ISNULL (R.PPVRevenue, 0.00),
    PPVRevenueUSD                   = ISNULL (R.PPVRevenueUSD, 0.00),
    PTRevenue                       = ISNULL (R.PTRevenue, 0.00),
    PTRevenueUSD                    = ISNULL (R.PTRevenueUSD, 0.00),
    ClubReadyPTRevenue              = ISNULL (R.ClubReadyPTRevenue, 0.00),
    ClubReadyPTRevenueUSD           = ISNULL (R.ClubReadyPTRevenueUSD, 0.00),
    TotalRevenue                    = ISNULL (R.TotalRevenue, 0.00),
    TotalRevenueUSD                 = ISNULL (R.TotalRevenueUSD, 0.00),
    TotalRevenueWithClubReady       = ISNULL (R.TotalRevenueWithClubReady, 0.00),
    TotalRevenueWithClubReadyUSD    = ISNULL (R.TotalRevenueWithClubReadyUSD, 0.00),
    AbcBaseMemberCount              = ISNULL (M.AbcBaseMemberCount, 0),
    PPVBaseMemberCount              = ISNULL (M.PPVBaseMemberCount, 0 ),
    BaseMemberPlus                  = ISNULL (M.BaseMemberPlus, 0 ),
    PTMemberCount                   = ISNULL (M.PTMemberCount, 0 ),
    AverageBaseMembershipValue      = TRY_CAST (R.MembershipRevenue / NULLIF (M.AbcBaseMemberCount, 0) AS NUMERIC (7, 2))
    AverageBaseMembershipValueUSD   = TRY_CAST (R.MembershipRevenueUSD / NULLIF (M.AbcBaseMemberCount, 0) AS NUMERIC (7, 2))
    AveragePPVMembershipValue       = TRY_CAST (R.PPVRevenue / NULLIF (M.PPVBaseMemberCount, 0) AS NUMERIC (7, 2))
    AveragePPVMembershipValueUSD    = TRY_CAST (R.PPVRevenueUSD / NULLIF (M.PPVBaseMemberCount, 0) AS NUMERIC (7, 2))
    AveragePTValuePerMember         = TRY_CAST ( (ISNULL(R.PTRevenue,0) + ISNULL(R.ClubReadyPTRevenue,0) )/ NULLIF (M.BaseMemberPlus, 0) AS NUMERIC (7, 2))
    AveragePTValuePerMemberUSD      = TRY_CAST (( ISNULL(R.PTRevenueUSD,0) + ISNULL(R.ClubReadyPTRevenueUSD,0) )/ NULLIF (M.BaseMemberPlus, 0) AS NUMERIC (7, 2))
    AveragePTValuePerClient         = TRY_CAST (R.PTRevenue / NULLIF (M.PTMemberCount, 0) AS NUMERIC (7, 2))
    AveragePTValuePerClientUSD      = TRY_CAST (R.PTRevenueUSD / NULLIF (M.PTMemberCount, 0) AS NUMERIC (7, 2))
    AverageBaseMemberValue          = TRY_CAST ((ISNULL(R.MembershipRevenue,0) + ISNULL(R.PTRevenue,0) + ISNULL(R.ClubReadyPTRevenue,0)) / NULLIF (M.AbcBaseMemberCount, 0) AS NUMERIC (7, 2))
    AverageBaseMemberValueUSD       = TRY_CAST ((ISNULL(R.MembershipRevenue,0) + ISNULL(R.PTRevenueUSD,0) + ISNULL(ClubReadyPTRevenueUSD,0)) / NULLIF (M.AbcBaseMemberCount, 0) AS NUMERIC (7, 2))
    AverageBaseMemberPlusValue      = TRY_CAST (R.TotalRevenueWithClubReady / NULLIF (M.BaseMemberPlus, 0) AS NUMERIC (7, 2))
    AverageBaseMemberPlusValueUSD   = TRY_CAST (R.TotalRevenueWithClubReadyUSD / NULLIF (M.BaseMemberPlus, 0) AS NUMERIC (7, 2))
FROM Revenue AS R
    LEFT OUTER JOIN Member AS M
        ON R.AFNumber = M.AFNumber AND R.FirstDayOfMonth = M.FirstDayOfMonth;