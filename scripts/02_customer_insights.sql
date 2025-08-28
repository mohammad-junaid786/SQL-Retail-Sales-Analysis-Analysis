/*
===============================================================================
Customer Insights
===============================================================================
Purpose:
    - Analyze customer behavior and demographics.
    - Answer key business questions:
        1. Number of unique customers
        2. Average age of customers by product category
        3. Top 10 customers by spending
        4. Spending behavior by gender

Table Used:
    - retail_sales
Relevant Columns:
    - CustomerID, Age, ProductCategory, TotalAmount, Gender
===============================================================================
*/

-- Number of Unique Customers
SELECT
    COUNT(DISTINCT CustomerID) AS unique_customers
FROM retail_sales;


-- Average Age of Customers by Product Category
SELECT
    ProductCategory,
    AVG(Age) AS avg_age
FROM retail_sales
GROUP BY ProductCategory;


-- Top 10 Customers by Spending
SELECT TOP 10
    CustomerID,
    SUM(TotalAmount) AS total_spent
FROM retail_sales
GROUP BY CustomerID
ORDER BY total_spent DESC;


-- Spending Behavior by Gender
SELECT
    Gender,
    SUM(TotalAmount) AS total_spent,
    AVG(TotalAmount) AS avg_spent_per_transaction
FROM retail_sales
GROUP BY Gender;
