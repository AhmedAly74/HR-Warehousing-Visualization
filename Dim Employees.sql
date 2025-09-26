IF OBJECT_ID('dbo.DimEmployee') IS NULL
BEGIN
  CREATE TABLE DimEmployee (
    EmployeeSK INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeBK INT NOT NULL,   -- EmployeeID من المصدر
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    JobTitle VARCHAR(50),
    Phone VARCHAR(50),
    Email VARCHAR(100),
    LoadDate DATETIME DEFAULT GETDATE()
  );
  CREATE UNIQUE INDEX UX_DimEmployee_BK ON DimEmployee(EmployeeBK);
END
GO

-- Load distinct employees (skip اذا موجود)
INSERT INTO dbo.DimEmployee (EmployeeBK, FirstName, LastName, Department, JobTitle, Phone, Email)
SELECT DISTINCT
  e.EmployeeID,
  NULLIF(LTRIM(RTRIM(e.FirstName)), ''),
  NULLIF(LTRIM(RTRIM(e.LastName)), ''),
  NULLIF(LTRIM(RTRIM(e.Department)), ''),
  NULLIF(LTRIM(RTRIM(e.JobTitle)), ''),
  NULLIF(LTRIM(RTRIM(e.Phone)), ''),
  NULLIF(LTRIM(RTRIM(e.Email)), '')
FROM Employees e
LEFT JOIN DimEmployee de ON de.EmployeeBK = e.EmployeeID
WHERE de.EmployeeBK IS NULL;
GO

Select * from DimEmployee