/*
===============================================================================
Product & Quantity Analysis
===============================================================================
Purpose:
    - Analyze product demand and revenue contribution.
    - Answer key business questions:
        1. Most purchased product category (by quantity)
        2. Average order value (AOV)
        3. Product category with highest revenue per transaction

Table Used:
    - retail_sales
Relevant Columns:
    - ProductCategory, Quantity, TotalAmount, TransactionID
===============================================================================
*/

-- Most purchased product category (by quantity)
SELECT TOP 1
    ProductCategory,
    SUM(Quantity) AS total_quantity
FROM retail_sales
GROUP BY ProductCategory
ORDER BY total_quantity DESC;


-- Average Order Value (AOV)
SELECT
    total_revenue / no_of_orders AS AOV
FROM (
    SELECT
        SUM(TotalAmount) AS total_revenue,
        COUNT(DISTINCT TransactionID) AS no_of_orders
    FROM retail_sales
) t;


-- Product category with highest revenue per transaction
SELECT TOP 1
    ProductCategory,
    ROUND(SUM(TotalAmount) * 1.0 / COUNT(DISTINCT TransactionID), 2) AS RevenuePerTransaction
FROM retail_sales
GROUP BY ProductCategory
ORDER BY RevenuePerTransaction DESC;
