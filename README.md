# 🛒 TheLook eCommerce Data Analysis & Operational Dashboard

## 📌 Project Overview
This project applies the standard Data Analytics 6-step framework (**Ask, Prepare, Process, Analyze, Share, Act**) to evaluate the business performance of **TheLook**, an eCommerce clothing platform. 

The primary goal is to transform fragmented raw data into actionable business insights by answering ad-hoc business questions and designing an automated **Operational Dashboard** to track revenue, customer growth, and product trends.

---

## 🛠️ Tech Stack & Tools
* **Database:** Google BigQuery (Standard SQL)
* **Data Visualization & BI:** Looker Studio
* **Techniques Used:** Data Modeling (CTEs), Window Functions (`LAG`, `DENSE_RANK`), Multi-table JOINs, Data Cleansing, Data Storytelling.

---

## 📊 The Dataset
The dataset utilized is the public **TheLook eCommerce** dataset available on Google BigQuery (`bigquery-public-data.thelook_ecommerce`). It contains detailed information about customers, products, orders, and inventory. 

**Key tables analyzed:**
* `orders` & `order_items`: Transaction history, order status, and sale prices.
* `users`: Customer demographics (age, location).
* `products`: Product categories and cost of goods sold (COGS).

---

## 🎯 Key Business Questions Answered
1. **Customer & Order Growth:** How is the monthly active user (MAU) and order volume fluctuating over a 3-year period?
2. **Average Order Value (AOV):** What is the average value of successful transactions each month?
3. **Customer Demographics:** Which age segment accounts for the highest purchasing volume?
4. **Product Performance:** What are the Top 5 revenue-generating products and the most profitable fashion categories?

---

## 🔗 Live Dashboard
To provide stakeholders with a bird's-eye view of the business, an interactive Operational Dashboard was built to track core retail KPIs (Total Processing Value, Profit Margin, Month-over-Month Growth).

👉 **[Access the Live Looker Studio Dashboard Here](https://datastudio.google.com/reporting/21c4085e-8481-435a-acd5-7314b67537bb)**

*(Note: Detailed SQL logic and screenshots of query results can be found in the `image` folder).*

---

## 🚀 Business Recommendations
Based on the extracted insights, the following strategic actions were proposed:
* **Targeted Marketing Allocation:** Reallocate advertising budgets to focus on the highest-converting demographic age groups and the most profitable fashion categories.
* **Inventory Optimization:** Implement proactive supply alerts for the Top 5 monthly best-selling items to mitigate out-of-stock risks.
* **Customer Retention:** Analyze and improve the customer service process for `Returned` and `Cancelled` orders to minimize refund rates and maximize net profit.

---
*This repository serves as a personal portfolio project showcasing end-to-end data analysis capabilities, from raw SQL data extraction to business-driven BI reporting.*
