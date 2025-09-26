
  CREATE TABLE DimSickLeaves (
    SickLeaveSK INT IDENTITY(1,1) PRIMARY KEY,
    SickLeaveBK INT NOT NULL,
    EmployeeBK INT,
    Reason VARCHAR(100),
    LoadDate DATETIME DEFAULT GETDATE()
  );
  CREATE UNIQUE INDEX UX_DimSickLeaves_BK ON DimSickLeaves(SickLeaveBK);


INSERT INTO DimSickLeaves (SickLeaveBK, EmployeeBK, Reason)
SELECT DISTINCT
  sl.SickLeaveID,
  sl.EmployeeID,
  NULLIF(LTRIM(RTRIM(sl.Reason)), '')
FROM SickLeaves sl
LEFT JOIN dbo.DimSickLeaves dsl ON dsl.SickLeaveBK = sl.SickLeaveID
WHERE dsl.SickLeaveBK IS NULL;
GO

select * from DimSickLeaves

