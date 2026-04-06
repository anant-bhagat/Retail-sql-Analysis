CREATE DATABASE retail_analysis;
use retail_analysis;

CREATE TABLE orders (
    row_id INT,
    order_id VARCHAR(50),
    order_date VARCHAR(20),
    ship_date VARCHAR(20),
    ship_mode VARCHAR(50),
    customer_id VARCHAR(50),
    customer_name VARCHAR(100),
    segment VARCHAR(50),
    country VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    postal_code VARCHAR(20),
    region VARCHAR(50),
    product_id VARCHAR(50),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name VARCHAR(255),
    sales DECIMAL(10,2),
    quantity INT,
    discount DECIMAL(4,2),
    profit DECIMAL(10,2)
);

UPDATE orders
SET order_date = STR_TO_DATE(order_date, '%m/%d/%Y');

UPDATE orders
SET ship_date = STR_TO_DATE(ship_date, '%m/%d/%Y');

SELECT * FROM orders LIMIT 10;

-- Total Sales and Total profit 
SELECT 
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM orders;


-- Sales by Region
SELECT region,
       SUM(sales) AS total_sales
FROM orders
GROUP BY region
ORDER BY total_sales DESC;

-- Profit by Category
SELECT category,
       SUM(profit) AS total_profit
FROM orders
GROUP BY category
ORDER BY total_profit DESC;

-- Top 10 customers
SELECT customer_name,
       SUM(sales) AS total_sales
FROM orders
GROUP BY customer_name
ORDER BY total_sales DESC
LIMIT 10;

-- Loss making sub- categories
SELECT sub_category,
       SUM(profit) AS total_profit
FROM orders
GROUP BY sub_category
HAVING total_profit < 0
ORDER BY total_profit;

-- Monthly sales trend

SELECT DATE_FORMAT(order_date, '%Y-%m') AS month,
       SUM(sales) AS monthly_sales
FROM orders
GROUP BY month
ORDER BY month; 
 
-- Yearly sales

SELECT YEAR(order_date) AS year,
       SUM(sales) AS total_sales
FROM orders
GROUP BY year;

-- Avg order value

SELECT AVG(sales) AS avg_order_value
FROM orders;

-- Profit margin by region

SELECT region,
       ROUND(SUM(profit)/SUM(sales), 2) AS profit_margin
FROM orders
GROUP BY region;   