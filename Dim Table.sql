-- انشئ جدول DimDate اذا مش موجود
IF OBJECT_ID('DimDate') IS NULL
BEGIN
  CREATE TABLE DimDate (
    DateSK INT PRIMARY KEY,   -- YYYYMMDD
    FullDate DATE NOT NULL,
    Day INT,
    DayName NVARCHAR(20),
    Month INT,
    MonthName NVARCHAR(20),
    Quarter INT,
    Year INT
  );
END
GO

-- احسب نطاق التواريخ من الـ staging
DECLARE @minDate DATE = NULL, @maxDate DATE = NULL;

SELECT @minDate = MIN(d) FROM (
  SELECT TRY_CONVERT(date, HiringDate, 23) AS d FROM Hiring WHERE LEN(ISNULL(HiringDate,''))>0
  UNION ALL
  SELECT TRY_CONVERT(date, LeaveDate, 23) AS d FROM SickLeaves WHERE LEN(ISNULL(LeaveDate,''))>0
  UNION ALL
  SELECT TRY_CONVERT(date, SurveyDate, 23) AS d FROM Satisfaction WHERE LEN(ISNULL(SurveyDate,''))>0
  UNION ALL
  SELECT TRY_CONVERT(date, LastUpdated, 23) AS d FROM Balances WHERE LEN(ISNULL(LastUpdated,''))>0
) t;

SELECT @maxDate = MAX(d) FROM (
  SELECT TRY_CONVERT(date, HiringDate, 23) AS d FROM Hiring WHERE LEN(ISNULL(HiringDate,''))>0
  UNION ALL
  SELECT TRY_CONVERT(date, LeaveDate, 23) AS d FROM SickLeaves WHERE LEN(ISNULL(LeaveDate,''))>0
  UNION ALL
  SELECT TRY_CONVERT(date, SurveyDate, 23) AS d FROM Satisfaction WHERE LEN(ISNULL(SurveyDate,''))>0
  UNION ALL
  SELECT TRY_CONVERT(date, LastUpdated, 23) AS d FROM Balances WHERE LEN(ISNULL(LastUpdated,''))>0
) t;

IF @minDate IS NULL SET @minDate = DATEADD(year, -2, CAST(GETDATE() AS date)); -- fallback
IF @maxDate IS NULL SET @maxDate = CAST(GETDATE() AS date);

;WITH Dates AS (
  SELECT @minDate AS d
  UNION ALL
  SELECT DATEADD(day,1,d) FROM Dates WHERE d < @maxDate
)
INSERT INTO dbo.DimDate(DateSK, FullDate, Day, DayName, Month, MonthName, Quarter, Year)
SELECT
  CAST(CONVERT(varchar(8), d, 112) AS INT),
  d,
  DATEPART(day,d),
  DATENAME(weekday,d),
  DATEPART(month,d),
  DATENAME(month,d),
  DATEPART(quarter,d),
  DATEPART(year,d)
FROM Dates D
WHERE NOT EXISTS (SELECT 1 FROM dbo.DimDate dd WHERE dd.DateSK = CAST(CONVERT(varchar(8), d, 112) AS INT))
OPTION (MAXRECURSION 0);
GO


SELECT * From DimDate