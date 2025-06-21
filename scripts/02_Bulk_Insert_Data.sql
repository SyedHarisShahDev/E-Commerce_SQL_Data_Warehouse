USE ECommerceDW;
GO

-- Load data from CSV into your staging table, skipping the header
BULK INSERT Stg_EcommerceRaw
FROM 'C:\Users\hp\Desktop\Work\E-Commerce SQL Data Warehouse\data.csv'
WITH (
    FIRSTROW = 2,                 -- Skip header (starts from 2nd row)
    FIELDTERMINATOR = ',',        -- CSV column separator
    ROWTERMINATOR = '\n',         -- End of line
    TABLOCK,
    CODEPAGE = '65001',           -- For UTF-8 files
    FORMAT = 'CSV'
);

-- Test After Import.
select top 100 * from Stg_EcommerceRaw;