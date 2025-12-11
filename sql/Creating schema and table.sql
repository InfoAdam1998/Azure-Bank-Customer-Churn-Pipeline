-------------------------------------------------------
-- Drop table dbo.Bank_Churn if it exists
-------------------------------------------------------
IF OBJECT_ID('dbo.Bank_Churn', 'U') IS NOT NULL
    DROP TABLE dbo.Bank_Churn;
GO

-------------------------------------------------------
-- Drop table source.Bank_Churn if it exists
-------------------------------------------------------
IF OBJECT_ID('source.Bank_Churn', 'U') IS NOT NULL
    DROP TABLE source.Bank_Churn;
GO

-------------------------------------------------------
-- Drop schema 'source' if it exists (only if empty)
-------------------------------------------------------
IF EXISTS (SELECT * FROM sys.schemas WHERE name = 'source')
    EXEC('DROP SCHEMA source');
GO

-------------------------------------------------------
-- Create schema 'source'
-------------------------------------------------------
CREATE SCHEMA source;
GO

-- Step 4: Create the new table
CREATE TABLE source.Bank_Churn (
    CustomerId INT,
    Surname VARCHAR(50),
    CreditScore INT,
    Geography VARCHAR(50),
    Gender VARCHAR(10),
    Age INT,
    Tenure INT,
    Balance FLOAT,
    NumOfProducts INT,
    HasCrCard INT,
    IsActiveMember INT,
    EstimatedSalary FLOAT,
    Exited INT,
    last_updated DATETIME DEFAULT GETDATE()
);