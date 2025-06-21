-- Total Sales by Country
SELECT 
    c.Country,
    SUM(f.TotalPrice) AS TotalSales
FROM FactSales f
JOIN DimCustomer c ON f.CustomerKey = c.CustomerKey
GROUP BY c.Country
ORDER BY TotalSales DESC;

-- Monthly Sales Trend
SELECT 
    d.Year,
    d.Month,
    d.MonthName,
    SUM(f.TotalPrice) AS MonthlySales
FROM FactSales f
JOIN DimDate d ON f.DateKey = d.DateKey
GROUP BY d.Year, d.Month, d.MonthName
ORDER BY d.Year, d.Month;

-- Top 10 Products by Total Sales
SELECT TOP 10
    p.Description,
    SUM(f.Quantity) AS TotalQuantity,
    SUM(f.TotalPrice) AS TotalSales
FROM FactSales f
JOIN DimProduct p ON f.ProductKey = p.ProductKey
GROUP BY p.Description
ORDER BY TotalSales DESC;

-- Average Order Value (AOV) per Month
SELECT 
    d.Year,
    d.Month,
    COUNT(DISTINCT f.InvoiceNo) AS TotalOrders,
    SUM(f.TotalPrice) AS TotalSales,
    ROUND(SUM(f.TotalPrice) * 1.0 / COUNT(DISTINCT f.InvoiceNo), 2) AS AOV
FROM FactSales f
JOIN DimDate d ON f.DateKey = d.DateKey
GROUP BY d.Year, d.Month
ORDER BY d.Year, d.Month;

-- Customer Lifetime Value (CLTV)
SELECT 
    c.CustomerID,
    COUNT(DISTINCT f.InvoiceNo) AS TotalOrders,
    SUM(f.TotalPrice) AS LifetimeValue
FROM FactSales f
JOIN DimCustomer c ON f.CustomerKey = c.CustomerKey
GROUP BY c.CustomerID
ORDER BY LifetimeValue DESC;

-- Returning vs New Customers (Monthly)
WITH FirstOrders AS (
    SELECT CustomerKey, MIN(DateKey) AS FirstPurchaseDate
    FROM FactSales
    GROUP BY CustomerKey
)
SELECT 
    d.Year,
    d.Month,
    COUNT(CASE WHEN f.DateKey = fo.FirstPurchaseDate THEN 1 END) AS NewCustomers,
    COUNT(CASE WHEN f.DateKey > fo.FirstPurchaseDate THEN 1 END) AS ReturningCustomers
FROM FactSales f
JOIN DimDate d ON f.DateKey = d.DateKey
JOIN FirstOrders fo ON f.CustomerKey = fo.CustomerKey
GROUP BY d.Year, d.Month
ORDER BY d.Year, d.Month;

-- Most Active Customers by Order Count
SELECT 
    c.CustomerID,
    COUNT(DISTINCT f.InvoiceNo) AS OrdersPlaced,
    SUM(f.TotalPrice) AS TotalSpent
FROM FactSales f
JOIN DimCustomer c ON f.CustomerKey = c.CustomerKey
GROUP BY c.CustomerID
ORDER BY OrdersPlaced DESC;

-- Most Active Customers by Order Count
SELECT 
    c.CustomerID,
    COUNT(DISTINCT f.InvoiceNo) AS OrdersPlaced,
    SUM(f.TotalPrice) AS TotalSpent
FROM FactSales f
JOIN DimCustomer c ON f.CustomerKey = c.CustomerKey
GROUP BY c.CustomerID
ORDER BY OrdersPlaced DESC;

-- Daily Sales Trend (7-day sample)
SELECT 
    d.FullDate,
    SUM(f.TotalPrice) AS DailySales
FROM FactSales f
JOIN DimDate d ON f.DateKey = d.DateKey
GROUP BY d.FullDate
ORDER BY d.FullDate
OFFSET 0 ROWS FETCH NEXT 7 ROWS ONLY;

-- Top Countries by Average Order Value
SELECT 
    c.Country,
    COUNT(DISTINCT f.InvoiceNo) AS TotalOrders,
    SUM(f.TotalPrice) AS TotalSales,
    ROUND(SUM(f.TotalPrice) * 1.0 / COUNT(DISTINCT f.InvoiceNo), 2) AS AvgOrderValue
FROM FactSales f
JOIN DimCustomer c ON f.CustomerKey = c.CustomerKey
GROUP BY c.Country
ORDER BY AvgOrderValue DESC;

-- Revenue by Quarter and Year
SELECT 
    d.Year,
    d.Quarter,
    SUM(f.TotalPrice) AS Revenue
FROM FactSales f
JOIN DimDate d ON f.DateKey = d.DateKey
GROUP BY d.Year, d.Quarter
ORDER BY d.Year, d.Quarter;






