DROP VIEW IF EXISTS CL.VW_MedalliaBySurveyType
GO

CREATE VIEW CL.VW_MedalliaBySurveyType
AS

WITH
Locations AS (
    SELECT DISTINCT
        DD.FirstDayOfMonth AS FirstDayOfMonth,
        DD.LastDayOfMonth AS LastDayOfMonth,
        Location,
        AFNumber = TRY_CAST (SUBSTRING (Location, CHARINDEX ('0', Location) + 1, 4) AS SMALLINT),
        DomesticInternational
    FROM Medallia.CalculationsPushReportBySurveyTypeRaw_Archive A
        LEFT JOIN Master.DateDetail DD
            ON DD.Date=TRY_CAST(A.CalculationsPushReportDate AS DATE)
    WHERE 
        DomesticInternational = N'Domestic' 
	    AND TRY_CAST (SUBSTRING (Location, CHARINDEX ('0', Location) + 1, 4) AS INT) IS NOT NULL
),
GU_OSAT AS (
    SELECT
        DD.FirstDayOfMonth AS FirstDayOfMonth,
        Location,
        GeneralUsageOSAT = TRY_CAST (OSAT AS SMALLINT) / 100.0
    FROM Medallia.CalculationsPushReportBySurveyTypeRaw_Archive A
        LEFT JOIN Master.DateDetail DD
            ON DD.Date=TRY_CAST(A.CalculationsPushReportDate AS DATE)
    WHERE SurveyType = 'General Usage'
    GROUP BY DD.FirstDayOfMonth, Location, OSAT
),
FC_OSAT AS (
    SELECT
        DD.FirstDayOfMonth AS FirstDayOfMonth,
        Location,
        FitnessConsultationOSAT = TRY_CAST (OSAT AS SMALLINT) / 100.0
    FROM Medallia.CalculationsPushReportBySurveyTypeRaw_Archive A
        LEFT JOIN Master.DateDetail DD
            ON DD.Date=TRY_CAST(A.CalculationsPushReportDate AS DATE)
    WHERE SurveyType = 'Fitness Consultation'
    GROUP BY DD.FirstDayOfMonth, Location, OSAT
),
Comb_OSAT AS (
    SELECT
        DD.FirstDayOfMonth AS FirstDayOfMonth,
        Location,
        CombinedOSAT = TRY_CAST (OSAT AS SMALLINT) / 100.0
    FROM Medallia.CalculationsPushReportBySurveyTypeRaw_Archive A
        LEFT JOIN Master.DateDetail DD
            ON DD.Date=TRY_CAST(A.CalculationsPushReportDate AS DATE)
    WHERE SurveyType = 'Combined Survey Scores'
    GROUP BY DD.FirstDayOfMonth, Location, OSAT
),
PercentResponded AS (
    SELECT
        DD.FirstDayOfMonth AS FirstDayOfMonth,
        Location,
        AlertsRespondedToWithin48Hours = TRY_CAST (AlertsRespondedToWithin48Hours AS SMALLINT) / 100.0
    FROM Medallia.CalculationsPushReportBySurveyTypeRaw_Archive A
        LEFT JOIN Master.DateDetail DD
            ON DD.Date=TRY_CAST(A.CalculationsPushReportDate AS DATE)
    WHERE SurveyType = 'Combined Survey Scores'
    GROUP BY DD.FirstDayOfMonth, Location, AlertsRespondedToWithin48Hours
)
SELECT
    L.FirstDayOfMonth,
    L.LastDayOfMonth,
    AFNumber = TRY_CAST (L.AFNumber AS NVARCHAR(30)),
    L.Location,
    L.DomesticInternational,
    GeneralUsageOSAT,
    FitnessConsultationOSAT,
    CombinedOSAT,
    AlertsRespondedToWithin48Hours
FROM Locations AS L
    LEFT OUTER JOIN GU_OSAT AS GU
        ON L.Location = GU.Location AND L.FirstDayOfMonth = GU.FirstDayOfMonth
    LEFT OUTER JOIN FC_OSAT AS FC
        ON L.Location = FC.Location AND L.FirstDayOfMonth = FC.FirstDayOfMonth
    LEFT OUTER JOIN Comb_OSAT AS C
        ON L.Location = C.Location AND L.FirstDayOfMonth = C.FirstDayOfMonth
    LEFT OUTER JOIN PercentResponded AS P
        ON L.Location = P.Location AND L.FirstDayOfMonth = P.FirstDayOfMonth;