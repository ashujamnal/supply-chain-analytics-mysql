# Supply Chain Analytics (MySQL Project)

## Overview

This project focuses on analyzing supply chain data using MySQL to generate actionable business insights related to delivery performance, profitability, and operational efficiency. It demonstrates an end-to-end data analysis workflow, including data cleaning, data modeling, and advanced SQL analysis.

---

## Business Problem

The organization is facing multiple operational challenges:

* High rate of late deliveries
* Inconsistent profitability across orders
* Regional inefficiencies in supply chain operations
* Risk of fraudulent transactions

The objective of this project is to build a data-driven analytical solution using SQL to identify inefficiencies and support better decision-making.

---

## Data Source

This project uses the DataCo Smart Supply Chain dataset, which represents a simulated global e-commerce company designed to reflect real-world supply chain scenarios.

Dataset link:
https://www.kaggle.com/datasets/shashwatwork/dataco-smart-supply-chain-for-big-data-analysis

---

## Data Cleaning Approach

Data cleaning was performed using a hybrid approach:

* Initial preprocessing and formatting (column renaming, date standardization) were done using Excel
* Advanced data cleaning, validation, and transformation were performed using SQL

This approach ensures both efficiency and scalability while maintaining data quality.

---

## Data Modeling

A star schema design was implemented to support efficient querying and analysis:

* Fact Table: `fact_order_items`
* Dimension Tables:

  * `dim_customer`
  * `dim_product`
  * `dim_order`
  * `dim_payment`

This structure enables optimized joins and scalable analytics.

---

## SQL Concepts Used

The project demonstrates both fundamental and advanced SQL capabilities:

* Joins and aggregations
* CASE statements for business logic
* Window functions (RANK, NTILE, running totals)
* Common Table Expressions (CTE)
* Subqueries
* User Defined Functions (UDF)
* Indexing and query optimization

---

## Key Analysis Performed

### Delivery Performance

* Late delivery rate
* Average delay for late orders
* Region-wise delivery performance

### Profitability Analysis

* Profit margin
* Impact of discounting on profit
* Identification of loss-making orders

### Product Performance

* Top and bottom performing products
* Revenue contribution analysis

### Customer Analysis

* Customer segmentation based on spending
* Customer revenue ranking

### Risk Analysis

* Fraud detection
* Cross-border order analysis

---

## Performance Optimization

To improve query performance:

* Indexes were created on frequently used join and filter columns
* Query performance was analyzed using execution plans (EXPLAIN)

---

## Key Insights

* Certain regions exhibit consistently high late delivery rates, indicating logistics inefficiencies
* Higher discount rates negatively impact overall profitability
* A small set of products contributes a significant portion of total revenue
* Fraudulent transactions lead to measurable financial losses

---

## Tools Used

* MySQL (data modeling, querying, and optimization)
* Excel (data preprocessing and initial cleaning)

---

## Project Structure

* data/ — cleaned dataset
* sql/ — staging, schema, analysis, and optimization scripts

---

## Conclusion

This project demonstrates the application of SQL in solving real-world supply chain problems by transforming raw data into meaningful business insights. It highlights strong analytical thinking, structured data modeling, and performance optimization techniques.

---

## Repository Link

https://github.com/ashujamnal/supply-chain-analytics-mysql.git
