-- Create FactSales Table

USE ECommerceDW;
GO

IF OBJECT_ID('FactSales') IS NOT NULL
    DROP TABLE FactSales;
GO

CREATE TABLE FactSales (
    SalesKey INT IDENTITY(1,1) PRIMARY KEY,
    InvoiceNo NVARCHAR(20),
    CustomerKey INT,
    ProductKey INT,
    DateKey INT,
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    TotalPrice AS (Quantity * UnitPrice) PERSISTED
);

-- Insert Transformed Sales Data into FactSales

INSERT INTO FactSales (InvoiceNo, CustomerKey, ProductKey, DateKey, Quantity, UnitPrice)
SELECT
    stg.InvoiceNo,
    dc.CustomerKey,
    dp.ProductKey,
    dd.DateKey,
    stg.Quantity,
    stg.UnitPrice
FROM vw_Stg_Ecommerce_Cleaned stg

-- Join Customer Dimension
INNER JOIN DimCustomer dc
    ON stg.CustomerID = dc.CustomerID

-- Join Product Dimension
INNER JOIN DimProduct dp
    ON stg.StockCode = dp.StockCode AND stg.Description = dp.Description

-- Join Date Dimension
INNER JOIN DimDate dd
    ON CONVERT(INT, CONVERT(VARCHAR, stg.InvoiceDate, 112)) = dd.DateKey;


-- Preview Loaded Data
SELECT TOP 10 * FROM FactSales;
