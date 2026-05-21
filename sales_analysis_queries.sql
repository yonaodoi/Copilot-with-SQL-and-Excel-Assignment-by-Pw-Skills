-- ============================================
-- Sales Analysis Queries
-- ============================================

-- Query 1: Find total sales per city
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

-- Query 2: Top 5 cities by revenue
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

-- ============================================

-- Additional Analysis Queries

-- Query 3: Cities ranked by revenue with percentage of total sales
SELECT 
    City,
    SUM(PurchaseAmount) AS CityRevenue,
    ROUND(SUM(PurchaseAmount) / (SELECT SUM(PurchaseAmount) FROM SalesData) * 100, 2) AS PercentageOfTotal,
    COUNT(*) AS TransactionCount
FROM SalesData
GROUP BY City
ORDER BY CityRevenue DESC;

-- ============================================

-- Query 4: Top 5 cities with detailed breakdown
SELECT 
    RANK() OVER (ORDER BY SUM(PurchaseAmount) DESC) AS Rank,
    City,
    SUM(PurchaseAmount) AS TotalRevenue,
    COUNT(*) AS NumberOfCustomers,
    COUNT(DISTINCT CustomerID) AS UniqueCustomers,
    ROUND(AVG(PurchaseAmount), 2) AS AvgTransactionValue,
    ROUND(MIN(PurchaseAmount), 2) AS MinTransaction,
    ROUND(MAX(PurchaseAmount), 2) AS MaxTransaction,
    ROUND(STDDEV(PurchaseAmount), 2) AS StdDeviation
FROM SalesData
GROUP BY City
ORDER BY TotalRevenue DESC
LIMIT 5;

-- ============================================

-- Query 5: Compare top 5 cities with overall average
WITH CityStats AS (
    SELECT 
        City,
        SUM(PurchaseAmount) AS TotalRevenue,
        COUNT(*) AS TransactionCount,
        AVG(PurchaseAmount) AS AvgPurchaseAmount
    FROM SalesData
    GROUP BY City
    ORDER BY TotalRevenue DESC
    LIMIT 5
),
OverallStats AS (
    SELECT 
        AVG(PurchaseAmount) AS OverallAvg,
        SUM(PurchaseAmount) AS OverallTotal
    FROM SalesData
)
SELECT 
    cs.City,
    cs.TotalRevenue,
    cs.TransactionCount,
    ROUND(cs.AvgPurchaseAmount, 2) AS CityAvg,
    ROUND(os.OverallAvg, 2) AS OverallAvg,
    ROUND(((cs.AvgPurchaseAmount - os.OverallAvg) / os.OverallAvg * 100), 2) AS PercentageDifferenceFromAvg
FROM CityStats cs
CROSS JOIN OverallStats os
ORDER BY cs.TotalRevenue DESC;