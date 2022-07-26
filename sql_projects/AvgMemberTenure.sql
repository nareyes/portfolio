-- Create Members TEMP TABLE
DROP TABLE IF EXISTS #TempMembers;
SELECT DISTINCT
    AG.StartDateKey,
    AG.EndDateKey,
    AG.SaleDateKey,
    L.LocationID,
    C.CustomerID,
    C.CustomerKey,
    C.CustomerGkKey,
    AG.AgreementID,
    AG.ContractID,
    AG.CurrentStatusKey,
    CAST (CAST (AG.StartDateKey AS NVARCHAR(50)) AS DATE) AS StartDate,
    CAST (CAST (AG.EndDateKey AS NVARCHAR(50)) AS DATE) AS EndDate,
    CAST (CAST (AG.SaleDateKey AS NVARCHAR(50)) AS DATE) AS SaleDate
INTO #TempMembers
FROM DW.Customer AS C (NOLOCK)
    INNER JOIN DW.Relationship AS R (NOLOCK)
        ON C.CustomerKey = R.CustomerKey
    INNER JOIN DW.Agreement AS AG (NOLOCK)
        ON R.AgreementKey = AG.AgreementKey
    INNER JOIN FranchiseSourceSync.ContractMember AS CM (NOLOCK)
        ON CM.ContractID = AG.ContractId
        AND CM.MemberID = C.CustomerID
    INNER JOIN DW.Location AS L (NOLOCK)
        ON L.LocationKey = R.LocationKey
        AND Country IN ('US','USA','CAN','Canada')
    INNER JOIN Master.AgreementType AS AT (NOLOCK)
        ON AT.AgreementTypeKey = AG.AgreementTypeKey
        AND AT.AgreementType = 'Member Contract'
        AND AT.AgreementTypeKey NOT IN ( 10, 5, 7 ) 
WHERE 
    ISNULL (IsTestMember, 0) <> 1
    AND AG.SaleDateKey >= 20180101;


-- Create Active Members Temp Table w/ Tenure
DROP TABLE IF EXISTS #TempActive;
SELECT DISTINCT
    StartDate,
    EndDate,
    SaleDate,
    LocationID,
    CustomerID,
    AgreementID,
    ContractID,
    CurrentStatusKey,
    BaseMemberTenure  = DATEDIFF(MONTH, StartDate, GETDATE()),
    RowNumber         = ROW_NUMBER () OVER (PARTITION BY CustomerID ORDER BY COALESCE (SaleDate, StartDate))
INTO #TempActive
FROM #TempMembers
WHERE
    CurrentStatusKey = 1
    AND EndDate IS NULL OR EndDate >= CAST (GETDATE () AS DATE);


-- Create Inactive Members Temp Table w/ Tenure
DROP TABLE IF EXISTS #TempInactive;
SELECT DISTINCT
    StartDate,
    EndDate,
    SaleDate,
    LocationID,
    CustomerID,
    CurrentStatusKey,
    BaseMemberTenure = DATEDIFF (MONTH, StartDate, EndDate)
INTO #TempInactive
FROM #TempMembers
WHERE
    CurrentStatusKey NOT IN (1, 7)
    AND EndDate IS NOT NULL;


-- Create Final Data Temp Table
DROP TABLE IF EXISTS #TempFinalData;
SELECT
    SaleDate,
    LocationID,
    CustomerID,
    BaseMemberTenure
INTO #TempFinalData
FROM #TempActive WHERE RowNumber = 1

UNION

SELECT
    SaleDate,
    LocationID,
    CustomerID,
    BaseMemberTenure
FROM #TempInactive;


-- Create CTE for Final Presentation
DROP TABLE IF EXISTS #TempAvgTenure;

WITH
DateDetail AS (
    SELECT
        Date,
        FirstDayOfMonth
    FROM Master.DateDetail
),
Tenure AS (
    SELECT
        MAX (SaleDate) AS SaleDate,
        LocationID,
        CustomerID,
        SUM (BaseMemberTenure) AS BaseMemberTenure
    FROM #TempFinalData
    GROUP BY LocationID, CustomerID
)
SELECT
    DD.FirstDayOfMonth,
    T.LocationID AS AFNumber,
    AVG (T.BaseMemberTenure) * 1.0 AS AvgBaseMemberTenure
INTO #TempAvgTenure
FROM Tenure AS T
    INNER JOIN DateDetail AS DD
        ON T.SaleDate = DD.Date
GROUP BY FirstDayOfMonth, LocationID;