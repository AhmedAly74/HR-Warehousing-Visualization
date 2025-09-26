CREATE TABLE DimHiring (
    HiringSK INT IDENTITY(1,1) PRIMARY KEY,
    HiringBK INT NOT NULL,
    EmployeeBK INT,
    HiringSource VARCHAR(50),
    LoadDate DATETIME DEFAULT GETDATE()
  );
  CREATE UNIQUE INDEX UX_DimHiring_BK ON DimHiring(HiringBK);

INSERT INTO DimHiring (HiringBK, EmployeeBK, HiringSource)
SELECT DISTINCT
  h.HiringID,
  h.EmployeeID,
  NULLIF(LTRIM(RTRIM(h.HiringSource)), '')
FROM Hiring h
LEFT JOIN dbo.DimHiring dh ON dh.HiringBK = h.HiringID
WHERE dh.HiringBK IS NULL;


select * from DimHiring
