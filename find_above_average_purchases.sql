-- Question 3: Find customers with purchases above average

SELECT 
    CustomerID,
    Name,
    City,
    PurchaseAmount,
    ROUND((SELECT AVG(PurchaseAmount) FROM SalesData), 2) AS AveragePurchaseAmount,
    ROUND(PurchaseAmount - (SELECT AVG(PurchaseAmount) FROM SalesData), 2) AS AmountAboveAverage
FROM SalesData
WHERE PurchaseAmount > (SELECT AVG(PurchaseAmount) FROM SalesData)
ORDER BY PurchaseAmount DESC;