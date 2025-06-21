-- Create DimInvoice Table

USE ECommerceDW;
GO

IF OBJECT_ID('DimInvoice') IS NOT NULL
    DROP TABLE DimInvoice;
GO

CREATE TABLE DimInvoice (
    InvoiceNo NVARCHAR(20) PRIMARY KEY,
    InvoiceDate DATETIME,
    IsCancelled BIT
);

-- Load distinct invoice data
INSERT INTO DimInvoice (InvoiceNo, InvoiceDate, IsCancelled)
SELECT
    InvoiceNo,
    MIN(InvoiceDate) AS InvoiceDate, -- Avoid multiple invoice dates per invoice
    CASE
        WHEN InvoiceNo LIKE 'C%' THEN 1 ELSE 0
    END AS IsCancelled
FROM vw_Stg_Ecommerce_Cleaned
GROUP BY InvoiceNo;

-- Preview
SELECT TOP 10 * FROM DimInvoice;


