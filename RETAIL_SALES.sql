-- Sql Retail Sales Analysis --
CREATE DATABASE sql_project;
USE sql_project;

-- Create TABLE --
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales(
							transactions_id INT PRIMARY KEY,
							sale_date DATE,
							sale_time TIME,
							customer_id INT,
							gender	VARCHAR(20),
							age	INT,
							category VARCHAR(20),
							quantiy	INT,
							price_per_unit FLOAT,
							cogs FLOAT,
							total_sale FLOAT
);

--
SELECT COUNT(*) FROM 
retail_sales
WHERE transactions_id IS NULL;

--
SELECT COUNT(*) FROM 
retail_sales
WHERE sale_date IS NULL;

--
SELECT * FROM retail_sales
WHERE 
	transactions_id IS NULL
    OR
    sale_date IS NULL
    OR
    sale_time IS NULL
    OR 
    customer_id IS NULL
    OR 
    gender IS NULL
    OR 
    age IS NULL 
    OR 
    category IS NULL
    OR 
    quantiy IS NULL
    OR 
    price_per_unit IS NULL
    OR 
    cogs IS NULL 
    OR 
    total_sale IS NULL;

-- DATA EXPLORATION --

-- How Many Sales Do We Have ? --
SELECT COUNT(*) AS total_sales FROM 
retail_sales;

-- How Many Unique Customers Do We Have? --
SELECT COUNT(DISTINCT(customer_id)) AS TOTAL_CUSTOMERS FROM 
retail_sales;

-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings.
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05.
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022.
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)



-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05. --
SELECT * 
FROM  retail_sales
WHERE sale_date ="2022-11-05";

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022. --
SELECT *
FROM retail_sales
WHERE category ="Clothing"
AND quantiy >= 4
AND sale_date BETWEEN "2022-11-01" AND "2022-11-30";

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT 
category,
SUM(total_sale) AS TOTAL_SALES
FROM sql_project.retail_sales
GROUP BY category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category. --
SELECT
category,
ROUND(AVG(age),2) AS AVG_AGE
FROM sql_project.retail_sales
WHERE category = "Beauty"
GROUP BY category;

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000. --
SELECT *
FROM sql_project.retail_sales
WHERE total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category. --
SELECT
category,
gender,
COUNT(transactions_id) AS TOTAL_NUMBER
FROM sql_project.retail_sales
GROUP BY gender, category
ORDER BY 1;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year --
SELECT *
FROM (
    SELECT
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        ROUND(AVG(total_sale), 2) AS avg_sales,
        RANK() OVER (PARTITION BY EXTRACT(YEAR FROM sale_date)
            ORDER BY AVG(total_sale) DESC
        ) AS rnk
    FROM sql_project.retail_sales
    GROUP BY
        EXTRACT(YEAR FROM sale_date),
        EXTRACT(MONTH FROM sale_date)
) t
WHERE rnk = 1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales --
SELECT
customer_id,
SUM(total_sale) AS TOTAL_SALES
FROM sql_project.retail_sales
GROUP BY customer_id
ORDER BY TOTAL_SALES DESC
LIMIT 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category. --
SELECT
	COUNT(DISTINCT customer_id) AS UNIUQE_CUSTOMER,
    category
FROM sql_project.retail_sales
GROUP BY category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17) --
WITH hourly_sales
AS
(SELECT *,
		CASE
			WHEN EXTRACT(HOUR FROM sale_time) <12 THEN 'MORNING'
			WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'AFTERNOON'
			ELSE 'EVENING'
		END AS shift 
FROM retail_sales )
SELECT
shift,
COUNT(*) AS TOTAL_ORDER
FROM hourly_sales
GROUP BY shift;


SELECT
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) <= 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 13 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(*) AS total_orders
FROM retail_sales
GROUP BY shift;

-- END OF PROJECT --


