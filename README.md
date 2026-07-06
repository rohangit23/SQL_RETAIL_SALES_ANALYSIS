## 📌 Project Overview

This project demonstrates the use of **SQL** to analyze retail sales data and generate actionable business insights. The project covers database creation, data cleaning, exploratory data analysis (EDA), and business problem-solving using SQL queries.

It showcases the SQL skills commonly required for **Data Analyst** and **Business Analyst** roles, including aggregate functions, window functions, Common Table Expressions (CTEs), filtering, grouping, and ranking.

---

# 🎯 Objectives

* Create and manage a Retail Sales Database.
* Perform Data Cleaning by identifying NULL values.
* Conduct Exploratory Data Analysis (EDA).
* Solve business problems using SQL.
* Generate insights from retail sales data.

---

# 🗄 Database Setup

## Create Database

```sql
CREATE DATABASE sql_project;
USE sql_project;
```

## Create Table

```sql
CREATE TABLE retail_sales(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(20),
    age INT,
    category VARCHAR(20),
    quantiy INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);
```

---

# 🧹 Data Cleaning

The dataset was checked for missing values before analysis.

```sql
SELECT *
FROM retail_sales
WHERE
transactions_id IS NULL
OR sale_date IS NULL
OR sale_time IS NULL
OR customer_id IS NULL
OR gender IS NULL
OR age IS NULL
OR category IS NULL
OR quantiy IS NULL
OR price_per_unit IS NULL
OR cogs IS NULL
OR total_sale IS NULL;
```

---

# 📊 Exploratory Data Analysis

### Total Sales

```sql
SELECT COUNT(*) AS total_sales
FROM retail_sales;
```

### Total Unique Customers

```sql
SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM retail_sales;
```

---

# 📈 Data Analysis & Business Questions

## 1️⃣ Retrieve all sales made on **2022-11-05**

```sql
SELECT *
FROM retail_sales
WHERE sale_date="2022-11-05";
```

---

## 2️⃣ Retrieve Clothing transactions with quantity ≥ 4 during November 2022

```sql
SELECT *
FROM retail_sales
WHERE category="Clothing"
AND quantiy>=4
AND sale_date BETWEEN "2022-11-01" AND "2022-11-30";
```

---

## 3️⃣ Calculate total sales for each category

```sql
SELECT
category,
SUM(total_sale) AS TOTAL_SALES
FROM retail_sales
GROUP BY category;
```

---

## 4️⃣ Find the average age of customers who purchased Beauty products

```sql
SELECT
category,
ROUND(AVG(age),2) AS AVG_AGE
FROM retail_sales
WHERE category="Beauty"
GROUP BY category;
```

---

## 5️⃣ Find transactions where total sales exceeded ₹1000

```sql
SELECT *
FROM retail_sales
WHERE total_sale > 1000;
```

---

## 6️⃣ Count transactions by gender and category

```sql
SELECT
category,
gender,
COUNT(transactions_id) AS TOTAL_NUMBER
FROM retail_sales
GROUP BY gender,category
ORDER BY category;
```

---

## 7️⃣ Find the best-selling month in each year

```sql
SELECT *
FROM(
SELECT
EXTRACT(YEAR FROM sale_date) AS year,
EXTRACT(MONTH FROM sale_date) AS month,
ROUND(AVG(total_sale),2) AS avg_sales,
RANK() OVER(
PARTITION BY EXTRACT(YEAR FROM sale_date)
ORDER BY AVG(total_sale) DESC
) AS rnk
FROM retail_sales
GROUP BY
EXTRACT(YEAR FROM sale_date),
EXTRACT(MONTH FROM sale_date)
)t
WHERE rnk=1;
```

---

## 8️⃣ Find the Top 5 customers based on total sales

```sql
SELECT
customer_id,
SUM(total_sale) AS TOTAL_SALES
FROM retail_sales
GROUP BY customer_id
ORDER BY TOTAL_SALES DESC
LIMIT 5;
```

---

## 9️⃣ Find the number of unique customers in each category

```sql
SELECT
COUNT(DISTINCT customer_id) AS UNIQUE_CUSTOMERS,
category
FROM retail_sales
GROUP BY category;
```

---

## 🔟 Create sales shifts (Morning, Afternoon, Evening)

```sql
WITH hourly_sales AS
(
SELECT *,
CASE
WHEN EXTRACT(HOUR FROM sale_time) <12 THEN 'MORNING'
WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'AFTERNOON'
ELSE 'EVENING'
END AS shift
FROM retail_sales
)

SELECT
shift,
COUNT(*) AS TOTAL_ORDER
FROM hourly_sales
GROUP BY shift;
```

---

# 📊 Key Findings

* Identified the highest-performing product categories based on total sales.
* Discovered high-value transactions exceeding ₹1000.
* Found the best-selling month for each year using SQL Window Functions.
* Identified the top 5 customers based on total revenue.
* Compared customer purchasing behavior across genders.
* Analyzed customer distribution across product categories.
* Classified transactions into Morning, Afternoon, and Evening shifts.

---

# 🛠 SQL Skills Used

* SQL
* MySQL
* Data Cleaning
* Data Exploration
* Aggregate Functions
* Window Functions
* Common Table Expressions (CTEs)
* CASE Statements
* GROUP BY
* ORDER BY
* RANK()
* EXTRACT()
* Filtering & Sorting

---

# 📂 Project Structure

```
SQL_RETAIL_SALES_ANALYSIS/
│
├── README.md
├── RETAIL_SALES.sql
└── SQL - Retail Sales Analysis_utf.csv
```

---

# 🚀 How to Run

1. Clone the repository.

```bash
git clone https://github.com/rohangit23/SQL_RETAIL_SALES_ANALYSIS.git
```

2. Open MySQL Workbench.

3. Create the database.

4. Import the dataset.

5. Execute **RETAIL_SALES.sql**.

6. Run the queries to explore the insights.

---

# 💡 Future Improvements

* Create an interactive Power BI Dashboard.
* Perform Customer Segmentation.
* Build Sales KPI Dashboard.
* Add Revenue Trend Visualization.
* Implement RFM Analysis.

---

# 👨‍💻 Author

## **Rohan Prajapati**

**Aspiring Data Analyst | Business Analyst**

### Technical Skills

* SQL
* Python
* Excel
* Power BI
* Pandas
* NumPy

---

## 🌐 Connect With Me

**GitHub:** [https://github.com/rohangit23](https://github.com/rohangit23)

**LinkedIn:** [https://linkedin.com/in/contactrohan](https://linkedin.com/in/contactrohan)

**Email:** [rohanprajapatiai@gmail.com](mailto:rohanprajapatiai@gmail.com)

---

⭐ **If you found this project helpful, please consider giving it a Star!**
