-- Creating the database.
CREATE DATABASE ECommerceDW;
GO

USE ECommerceDW;
GO

-- Create Staging Table (Raw Data).
CREATE TABLE Stg_EcommerceRaw (
    InvoiceNo    NVARCHAR(20),
    StockCode    NVARCHAR(20),
    Description  NVARCHAR(100),
    Quantity     INT,
    InvoiceDate  DATETIME,
    UnitPrice    DECIMAL(10,2),
    CustomerID   NVARCHAR(20),
    Country      NVARCHAR(50)
);

