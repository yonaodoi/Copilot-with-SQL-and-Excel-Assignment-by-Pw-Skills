-- ============================================
-- Question 2: Sales Analysis Queries
-- ============================================

-- Question 2.1: Find total sales per city
-- This query calculates the total purchase amount for each city
SELECT 
    City,
    COUNT(*) AS TotalTransactions,
    SUM(PurchaseAmount) AS TotalSales,
    AVG(PurchaseAmount) AS AvgPurchaseAmount,
    MIN(PurchaseAmount) AS MinPurchaseAmount,
    MAX(PurchaseAmount) AS MaxPurchaseAmount
FROM SalesData
GROUP BY City
ORDER BY TotalSales DESC;

-- ============================================

-- Question 2.2: Top 5 cities by revenue
-- This query identifies the 5 cities with the highest total revenue
SELECT 
    City,
    SUM(PurchaseAmount) AS TotalRevenue,
    COUNT(*) AS TotalTransactions,
    ROUND(AVG(PurchaseAmount), 2) AS AvgPurchaseAmount
FROM SalesData
GROUP BY City
ORDER BY TotalRevenue DESC
LIMIT 5;