CREATE DATABASE ai_business_dashboard;
USE ai_business_dashboard;
SELECT *
FROM cleaned_superstore;

-- ============================================
-- PROJECT: AI BUSINESS INSIGHTS DASHBOARD
-- SQL BUSINESS ANALYSIS
-- ============================================

-- 1. Total Sales
SELECT ROUND(SUM(Sales),2) AS Total_Sales
FROM cleaned_superstore;

-- 2. Total Profit
SELECT ROUND(SUM(Profit),2) AS Total_Profit
FROM cleaned_superstore;

-- 3. Total Orders
SELECT COUNT(DISTINCT `Order ID`) AS Total_Orders
FROM cleaned_superstore;

-- 4. Total Customers
SELECT COUNT(DISTINCT `Customer ID`) AS Total_Customers
FROM cleaned_superstore;

-- 5. Average Sales
SELECT ROUND(AVG(Sales),2) AS Average_Sales
FROM cleaned_superstore;

-- ============================================
-- CATEGORY ANALYSIS
-- ============================================

-- 6. Sales by Category
SELECT Category,
ROUND(SUM(Sales),2) AS Total_Sales
FROM cleaned_superstore
GROUP BY Category
ORDER BY Total_Sales DESC;

-- 7. Profit by Category
SELECT Category,
ROUND(SUM(Profit),2) AS Total_Profit
FROM cleaned_superstore
GROUP BY Category
ORDER BY Total_Profit DESC;

-- 8. Average Discount by Category
SELECT Category,
ROUND(AVG(Discount),2) AS Avg_Discount
FROM cleaned_superstore
GROUP BY Category;

-- ============================================
-- CUSTOMER ANALYSIS
-- ============================================

-- 9. Top 10 Customers by Sales
SELECT `Customer Name`,
ROUND(SUM(Sales),2) AS Total_Sales
FROM cleaned_superstore
GROUP BY `Customer Name`
ORDER BY Total_Sales DESC
LIMIT 10;

-- 10. Top 10 Customers by Profit
SELECT `Customer Name`,
ROUND(SUM(Profit),2) AS Total_Profit
FROM cleaned_superstore
GROUP BY `Customer Name`
ORDER BY Total_Profit DESC
LIMIT 10;

-- ============================================
-- PRODUCT ANALYSIS
-- ============================================

-- 11. Top 10 Products by Sales
SELECT `Product Name`,
ROUND(SUM(Sales),2) AS Sales
FROM cleaned_superstore
GROUP BY `Product Name`
ORDER BY Sales DESC
LIMIT 10;

-- 12. Top 10 Products by Profit
SELECT `Product Name`,
ROUND(SUM(Profit),2) AS Profit
FROM cleaned_superstore
GROUP BY `Product Name`
ORDER BY Profit DESC
LIMIT 10;

-- ============================================
-- REGION ANALYSIS
-- ============================================

-- 13. Sales by Region
SELECT Region,
ROUND(SUM(Sales),2) AS Sales
FROM cleaned_superstore
GROUP BY Region
ORDER BY Sales DESC;

-- 14. Profit by Region
SELECT Region,
ROUND(SUM(Profit),2) AS Profit
FROM cleaned_superstore
GROUP BY Region
ORDER BY Profit DESC;

-- 15. Sales by Country
SELECT Country,
ROUND(SUM(Sales),2) AS Sales
FROM cleaned_superstore
GROUP BY Country
ORDER BY Sales DESC;

-- ============================================
-- TIME ANALYSIS
-- ============================================

-- 16. Sales by Year
SELECT `Order Year`,
ROUND(SUM(Sales),2) AS Sales
FROM cleaned_superstore
GROUP BY `Order Year`
ORDER BY `Order Year`;

-- 17. Monthly Sales
SELECT `Order Month`,
ROUND(SUM(Sales),2) AS Sales
FROM cleaned_superstore
GROUP BY `Order Month`;

-- 18. Monthly Profit
SELECT `Order Month`,
ROUND(SUM(Profit),2) AS Profit
FROM cleaned_superstore
GROUP BY `Order Month`;

-- ============================================
-- SHIPPING ANALYSIS
-- ============================================

-- 19. Average Delivery Days
SELECT ROUND(AVG(`Delivery Days`),2) AS Avg_Delivery_Days
FROM cleaned_superstore;

-- 20. Average Delivery Days by Ship Mode
SELECT `Ship Mode`,
ROUND(AVG(`Delivery Days`),2) AS Avg_Delivery_Days
FROM cleaned_superstore
GROUP BY `Ship Mode`;

-- ============================================
-- ADVANCED ANALYSIS
-- ============================================

-- 21. Products with Negative Profit
SELECT `Product Name`,
ROUND(SUM(Profit),2) AS Profit
FROM cleaned_superstore
GROUP BY `Product Name`
HAVING Profit < 0
ORDER BY Profit;

-- 22. Regions with Negative Profit
SELECT Region,
ROUND(SUM(Profit),2) AS Profit
FROM cleaned_superstore
GROUP BY Region
HAVING Profit < 0;

-- 23. Top 5 Most Profitable Cities
SELECT City,
ROUND(SUM(Profit),2) AS Profit
FROM cleaned_superstore
GROUP BY City
ORDER BY Profit DESC
LIMIT 5;

-- 24. Most Sold Category
SELECT Category,
SUM(Quantity) AS Total_Quantity
FROM cleaned_superstore
GROUP BY Category
ORDER BY Total_Quantity DESC;

-- 25. Highest Average Discount Category
SELECT Category,
ROUND(AVG(Discount),2) AS Avg_Discount
FROM cleaned_superstore
GROUP BY Category
ORDER BY Avg_Discount DESC;
