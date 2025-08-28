/*
===============================================================================
Sales Performance
===============================================================================
Purpose:
    - Analyze overall sales to answer key business questions:
        1. Total revenue generated
        2. Month with the highest sales
        3. Top 3 product categories by revenue

Table Used:
    - retail_sales
Relevant Columns:
    - TotalAmount, ProductCategory, Date
===============================================================================
*/

-- Total Revenue Generated
SELECT
	SUM(TotalAmount) AS total_revenue
FROM retail_sales;


-- Month with Highest Sales
SELECT TOP 1
	MONTH(Date) AS month_date,
	SUM(TotalAmount) AS sales
FROM retail_sales
GROUP BY MONTH(Date)
ORDER BY sales DESC


-- Top 3 Product Categories by Revenue(in rank)
SELECT
	ProductCategory,
	Revenue,
	RANK() OVER(ORDER BY Revenue DESC) AS Rank
FROM(
SELECT
	ProductCategory,
	SUM(TotalAmount) AS Revenue
FROM retail_sales
GROUP BY ProductCategory
)t 
ORDER BY Revenue DESC
