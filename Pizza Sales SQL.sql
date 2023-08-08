SELECT *
FROM pizza_sales_csv

-- Calculating KPIs

-- TOTAL REVENUE

SELECT SUM(total_price) AS Total_Revenue
from pizza_sales_csv

-- AVERAGE ORDER VALUE

SELECT SUM(total_price)/COUNT(DISTINCT order_id) AS Avg_Order_Value
FROM pizza_sales_csv

-- TOTAL AMOUNT OF PIZZAS SOLD

SELECT SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales_csv

-- TOTAL ORDERS

SELECT COUNT(DISTINCT(order_id)) AS Total_Orders
FROM pizza_sales_csv

-- AVERAGE PIZZAS PER ORDER

SELECT CAST(CAST(SUM(quantity) AS decimal(10, 2)) / CAST(COUNT(DISTINCT order_id) AS decimal(10, 2)) AS decimal(10, 2)) AS Avg_Pizza_Quantity_Per_Order 
FROM pizza_sales_csv


-- INFORMATION NEEDED FOR DATA VISUALIZATION

-- Daily Trend for Orders

SELECT DATENAME(dw, order_date) AS order_weekday, COUNT(DISTINCT(order_id)) AS total_orders_by_weekday
FROM pizza_sales_csv
GROUP BY DATENAME(dw, order_date)

-- Monthly Trend for total Orders

SELECT DATENAME(mm, order_date) AS order_month, COUNT(DISTINCT(order_id)) AS total_orders_by_month
FROM pizza_sales_csv
GROUP BY DATENAME(mm, order_date)
ORDER BY total_orders_by_month DESC

-- % of Sales By Pizza Category

SELECT pizza_category AS Pizza_Categories, ROUND(SUM(total_price), 2) AS Total_Sales, ROUND(SUM(total_price) * 100 / (SELECT SUM(total_price) AS Total_Revenue
from pizza_sales_csv), 2) AS Total_Sales_Pct
FROM pizza_sales_csv
-- WHERE DATEPART(Quarter, order_date) = 1
GROUP BY pizza_category
ORDER BY Total_Sales_Pct DESC

SELECT pizza_category AS Pizza_Categories, ROUND(SUM(total_price), 2) AS Total_Sales, ROUND(SUM(total_price) * 100 / (SELECT SUM(total_price) AS Total_Revenue
from pizza_sales_csv WHERE MONTH(order_date) = 1), 2) AS Total_Sales_Pct
FROM pizza_sales_csv
WHERE MONTH(order_date) = 1
GROUP BY pizza_category
ORDER BY Total_Sales_Pct DESC

-- % of Sales by Pizza Size

SELECT pizza_size, ROUND(SUM(total_price), 2) AS Total_Sales, ROUND(SUM(total_price) * 100 / (SELECT SUM(total_price) AS Total_Revenue
from pizza_sales_csv), 2) AS Total_Sales_Pct
FROM pizza_sales_csv
-- WHERE DATEPART(Quarter, order_date) = 1
GROUP BY pizza_size
ORDER BY Total_Sales_Pct DESC

-- Total Pizzas Sold by Category

SELECT pizza_category, SUM(quantity) AS total_pizzas_sold
FROM pizza_sales_csv
GROUP BY pizza_category
ORDER BY total_pizzas_sold DESC

-- Top 5 Best Sellers (Revenue, Quantity, Orders)

SELECT TOP 5 pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales_csv
GROUP BY pizza_name
ORDER BY Total_Revenue DESC

SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Quantity
FROM pizza_sales_csv
GROUP BY pizza_name
ORDER BY Total_Quantity DESC

SELECT TOP 5 pizza_name, COUNT(DISTINCT(order_id)) AS Total_Orders
FROM pizza_sales_csv
GROUP BY pizza_name
ORDER BY Total_Orders DESC

-- Bottom 5 Worst Sellers (Revenue, Quantity, Orders)

SELECT TOP 5 pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales_csv
GROUP BY pizza_name
ORDER BY Total_Revenue ASC

SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Quantity
FROM pizza_sales_csv
GROUP BY pizza_name
ORDER BY Total_Quantity ASC

SELECT TOP 5 pizza_name, COUNT(DISTINCT(order_id)) AS Total_Orders
FROM pizza_sales_csv
GROUP BY pizza_name
ORDER BY Total_Orders ASC