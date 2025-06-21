-- Create DimDate Table

USE ECommerceDW;
GO

IF OBJECT_ID('DimDate') IS NOT NULL
    DROP TABLE DimDate;
GO

CREATE TABLE DimDate (
    DateKey INT PRIMARY KEY,            -- Format: YYYYMMDD
    FullDate DATE,
    Day TINYINT,
    Month TINYINT,
    MonthName NVARCHAR(20),
    Quarter TINYINT,
    Year SMALLINT,
    WeekdayName NVARCHAR(20)
);

-- Generate Date Dimension from 2009–2012

DECLARE @StartDate DATE = '2009-01-01';
DECLARE @EndDate DATE = '2012-12-31';

WHILE @StartDate <= @EndDate
BEGIN
    INSERT INTO DimDate (
        DateKey, FullDate, Day, Month, MonthName,
        Quarter, Year, WeekdayName
    )
    VALUES (
        CONVERT(INT, CONVERT(VARCHAR, @StartDate, 112)), -- YYYYMMDD
        @StartDate,
        DAY(@StartDate),
        MONTH(@StartDate),
        DATENAME(MONTH, @StartDate),
        DATEPART(QUARTER, @StartDate),
        YEAR(@StartDate),
        DATENAME(WEEKDAY, @StartDate)
    );

    SET @StartDate = DATEADD(DAY, 1, @StartDate);
END;

-- Preview
SELECT TOP 10 * FROM DimDate;

