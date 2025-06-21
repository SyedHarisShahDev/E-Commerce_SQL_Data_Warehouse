USE ECommerceDW;
GO

-- Create cleaned view based on raw staging table
CREATE VIEW vw_Stg_Ecommerce_Cleaned AS
SELECT
    InvoiceNo,
    StockCode,
    Description,
    Quantity,
    InvoiceDate,
    UnitPrice,
    CustomerID,
    Country
FROM Stg_EcommerceRaw
WHERE
    InvoiceNo NOT LIKE 'C%'               -- Remove cancelled invoices
    AND CustomerID IS NOT NULL            -- Remove missing customers
    AND InvoiceNo IS NOT NULL
    AND Quantity > 0                      -- Remove bad quantities
    AND UnitPrice > 0;                    -- Remove bad prices
GO

-- Preview the cleaned data
SELECT TOP 100 * FROM vw_Stg_Ecommerce_Cleaned;

-- Compare the row counts.
SELECT COUNT(*) FROM vw_Stg_Ecommerce_Cleaned;   -- 397880 rows
SELECT COUNT(*) FROM Stg_EcommerceRaw;           -- 541909 rows