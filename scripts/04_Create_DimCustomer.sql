-- Create DimCustomer Table.
USE ECommerceDW;
GO

-- Drop if already exists (optional)
IF OBJECT_ID('DimCustomer') IS NOT NULL
    DROP TABLE DimCustomer;
GO

-- Create Dimension Table
CREATE TABLE DimCustomer (
    CustomerKey INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT,
    Country NVARCHAR(50)
);

-- Load Unique Customers into DimCustomer.
INSERT INTO DimCustomer (CustomerID, Country)
SELECT DISTINCT
    CustomerID,
    Country
FROM vw_Stg_Ecommerce_Cleaned;

-- Preview top 10 customers
SELECT TOP 10 * FROM DimCustomer;
