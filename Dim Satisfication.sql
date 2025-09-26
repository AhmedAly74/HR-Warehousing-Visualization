CREATE TABLE DimSatisfaction (
    SatisfactionSK INT IDENTITY(1,1) PRIMARY KEY,
    SurveyBK INT NOT NULL,
    EmployeeBK INT,
    Comment VARCHAR(MAX),
    LoadDate DATETIME DEFAULT GETDATE()
  );
  CREATE UNIQUE INDEX UX_DimSatisfaction_BK ON dbo.DimSatisfaction(SurveyBK);


INSERT INTO DimSatisfaction (SurveyBK, EmployeeBK, Comment)
SELECT DISTINCT
  s.SurveyID,
  s.EmployeeID,
  NULLIF(LTRIM(RTRIM(s.Comments)), '')
FROM Satisfaction s
LEFT JOIN DimSatisfaction ds ON ds.SurveyBK = s.SurveyID
WHERE ds.SurveyBK IS NULL;
GO


select * from DimSatisfaction
