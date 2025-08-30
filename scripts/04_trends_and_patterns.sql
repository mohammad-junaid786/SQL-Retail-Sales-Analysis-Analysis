/*
===============================================================================
Trends & Patterns
===============================================================================
Purpose:
    - Identify time-based and demographic purchase trends.
    - Answer key business questions:
        1. Monthly sales trend over the year
        2. Relationship between customer age and spending
        3. Category preferences across younger vs older customers

Table Used:
    - retail_sales
Relevant Columns:
    - Date, TotalAmount, Age, ProductCategory, Quantity
===============================================================================
*/

-- Monthly Sales Trend

SELECT
    FORMAT(Date,'yyyy-MM') AS year_month,
    SUM(TotalAmount) AS monthly_sales
FROM retail_sales
GROUP BY FORMAT(Date,'yyyy-MM')
ORDER BY year_month;


-- Relationship Between Customer Age and Spending

SELECT
    Age_category,
    SUM(spendings) AS Spendings
FROM (
    SELECT
        Age,
        CASE 
            WHEN Age < 18 THEN '0-17'
            WHEN Age BETWEEN 18 AND 25 THEN '18-25'
            WHEN Age BETWEEN 26 AND 35 THEN '26-35'
            WHEN Age BETWEEN 36 AND 45 THEN '36-45'
            ELSE '46+'
        END AS Age_category,
        TotalAmount AS spendings
    FROM retail_sales
) t
GROUP BY Age_category
ORDER BY Spendings DESC;


-- Do Younger vs Older Customers Prefer Different Categories?

WITH AgeCategoryPurchases AS (
    SELECT
        CASE 
            WHEN Age < 18 THEN '0-17'
            WHEN Age BETWEEN 18 AND 25 THEN '18-25'
            WHEN Age BETWEEN 26 AND 35 THEN '26-35'
            WHEN Age BETWEEN 36 AND 45 THEN '36-45'
            ELSE '46+'
        END AS Age_category,
        ProductCategory AS Category,
        SUM(Quantity) AS quantity
    FROM retail_sales
    GROUP BY
        CASE 
            WHEN Age < 18 THEN '0-17'
            WHEN Age BETWEEN 18 AND 25 THEN '18-25'
            WHEN Age BETWEEN 26 AND 35 THEN '26-35'
            WHEN Age BETWEEN 36 AND 45 THEN '36-45'
            ELSE '46+'
        END,
        ProductCategory
)
SELECT Age_category, Category, quantity
FROM (
    SELECT 
        Age_category,
        Category,
        quantity,
        ROW_NUMBER() OVER (PARTITION BY Age_category ORDER BY quantity DESC) AS rn
    FROM AgeCategoryPurchases
) ranked
WHERE rn = 1
ORDER BY Age_category;
