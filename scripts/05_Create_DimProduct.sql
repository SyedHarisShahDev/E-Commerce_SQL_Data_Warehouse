-- Create DimProduct Table.

USE ECommerceDW;
GO

-- Drop table if it exists (optional)
IF OBJECT_ID('DimProduct') IS NOT NULL
    DROP TABLE DimProduct;
GO

-- Create DimProduct Table
CREATE TABLE DimProduct (
    ProductKey INT IDENTITY(1,1) PRIMARY KEY,
    StockCode NVARCHAR(50),
    Description NVARCHAR(255)
);

-- Load Distinct Products into DimProduct.
INSERT INTO DimProduct (StockCode, Description)
SELECT DISTINCT
    StockCode,
    Description
FROM vw_Stg_Ecommerce_Cleaned
WHERE
    StockCode IS NOT NULL
    AND Description IS NOT NULL
    AND LTRIM(RTRIM(Description)) <> ''; -- Remove empty strings

-- Preview Result.
SELECT TOP 10 * FROM DimProduct;