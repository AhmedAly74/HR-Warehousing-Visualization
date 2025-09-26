  CREATE TABLE DimBalances (
    BalancesSK INT IDENTITY(1,1) PRIMARY KEY,
    BalancesBK INT NOT NULL,
    EmployeeBK INT,
    LoadDate DATETIME DEFAULT GETDATE()
  );
  CREATE UNIQUE INDEX UX_DimBalances_BK ON dbo.DimBalances(BalancesBK);


INSERT INTO DimBalances (BalancesBK, EmployeeBK)
SELECT DISTINCT
  b.BalanceID,
  b.EmployeeID
FROM Balances b
LEFT JOIN DimBalances db ON db.BalancesBK = b.BalanceID
WHERE db.BalancesBK IS NULL;
GO

select * from DimBalances

