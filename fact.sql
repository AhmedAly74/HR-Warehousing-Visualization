CREATE TABLE FactKPIs (
    KPIsSK INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeSK INT NULL,
    HiringSK INT NULL,
    SickLeaveSK INT NULL,
    BalancesSK INT NULL,
    SatisfactionSK INT NULL,
    DateSK INT NULL,
    DaysOff INT NULL,
    AnnualLeaveBalance INT NULL,
    SickLeaveBalance INT NULL,
    SatisfactionScore INT NULL,
    TenureYears INT NULL,
    TenureMonths INT NULL,
    SickLeaveCount INT NULL,
    AvgSatisfaction DECIMAL(5,2) NULL);





INSERT INTO FactKPIs (
    EmployeeSK, HiringSK, SickLeaveSK, BalancesSK, SatisfactionSK, DateSK,

    DaysOff, AnnualLeaveBalance, SickLeaveBalance, SatisfactionScore,

    TenureYears, TenureMonths, SickLeaveCount, AvgSatisfaction 
)
SELECT
    de.EmployeeSK,
    dh.HiringSK,
    dsl.SickLeaveSK,
    db.BalancesSK,
    ds.SatisfactionSK,
    dd.DateSK,

    sl.DaysOff,
    b.AnnualLeaveBalance,
    b.SickLeaveBalance,
    s.SatisfactionScore,

    DATEDIFF(YEAR, h.HiringDate, GETDATE()) AS TenureYears,
    DATEDIFF(MONTH, h.HiringDate, GETDATE()) % 12 AS TenureMonths,

    (SELECT COUNT(*) FROM SickLeaves sl WHERE sl.EmployeeID = e.EmployeeID) AS SickLeaveCount,
    (SELECT AVG(s.SatisfactionScore) FROM Satisfaction s WHERE s.EmployeeID = e.EmployeeID) AS AvgSatisfaction

FROM Employees e
LEFT JOIN DimEmployee de        ON de.EmployeeBK = e.EmployeeID
LEFT JOIN Hiring h          ON h.EmployeeID = e.EmployeeID
LEFT JOIN DimHiring dh          ON dh.HiringBK = h.HiringID
LEFT JOIN SickLeaves sl      ON sl.EmployeeID = e.EmployeeID
LEFT JOIN DimSickLeaves dsl      ON dsl.SickLeaveBK = sl.SickLeaveID
LEFT JOIN Balances b        ON b.EmployeeID = e.EmployeeID
LEFT JOIN DimBalances db        ON db.BalancesBK = b.BalanceID
LEFT JOIN Satisfaction s  ON s.EmployeeID = e.EmployeeID
LEFT JOIN DimSatisfaction ds  ON ds.SurveyBK = s.SurveyID
LEFT JOIN DimDate dd            ON h.HiringDate = dd.FullDate;





select * from FactKPIs

