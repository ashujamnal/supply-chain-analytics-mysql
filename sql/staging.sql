-- Create database
create database supply_chain_analytics;

-- Use database
use supply_chain_analytics;

DROP TABLE IF EXISTS stg_supply_chain;

-- Create table
create table stg_supply_chain(

-- IDENTIFIERS
order_item_id INT,
order_id INT,
customer_id INT,
product_id INT,

-- DATES
order_date DATETIME,
shipping_date DATETIME,

-- FINANCIAL METRICS
sales_amount DECIMAL(12,2),
unit_price DECIMAL(12,2),
quantity INT,
discount_amount DECIMAL(12,2),
discount_rate DECIMAL(6,4),
profit_amount DECIMAL(12,2),

-- SHIPPING METRICS
shipping_days_actual INT,
shipping_days_scheduled INT,
late_delivery_flag TINYINT,

-- ORDER DIMENSION FIELDS
order_status VARCHAR(50),
delivery_status VARCHAR(50),
market VARCHAR(50),
order_region VARCHAR(50),
order_city VARCHAR(100),
order_state VARCHAR(100),
order_country VARCHAR(100),
order_zipcode VARCHAR(20),
shipping_mode VARCHAR(50),

-- CUSTOMER DIMENSION FIELDS
customer_first_name VARCHAR(100),
customer_last_name VARCHAR(100),
customer_segment VARCHAR(50),
customer_city VARCHAR(100),
customer_state VARCHAR(100),
customer_country VARCHAR(100),
customer_zipcode VARCHAR(20),
customer_latitude DECIMAL(10,6),
customer_longitude DECIMAL(10,6),

-- PRODUCT DIMENSION FIELDS
product_name VARCHAR(255),
product_price DECIMAL(12,2),
product_status TINYINT,
category_id INT,
category_name VARCHAR(100),
department_id INT,
department_name VARCHAR(100),

-- PAYMENT
payment_type VARCHAR(50)

);

-- Load data into staging
LOAD DATA INFILE 
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/supply_chain_cleaned.csv'
INTO TABLE stg_supply_chain
CHARACTER SET latin1
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;




SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;

SHOW VARIABLES LIKE 'secure_file_priv';

;

-- Validation queries (DATA quality check)
-- 1. Row count check 
SELECT COUNT(*) AS total_rows
FROM stg_supply_chain;

-- 2. Null check on criticals IDs
SELECT COUNT(*) AS null_order_item
FROM stg_supply_chain
WHERE order_item_id IS NULL;

-- 3. Duplicate check 
SELECT order_item_id,COUNT(*) as duplicate_count
FROM stg_supply_chain
GROUP BY order_item_id
HAVING count(*) > 1;

-- 4. Date Validation
SELECT MIN(order_date), MAX(order_date)
FROM stg_supply_chain;

-- 5. Profit Validation
SELECT *
FROM stg_supply_chain
WHERE profit_amount IS NULL;

-- 6. Shipping Delay Logic
SELECT *
FROM stg_supply_chain
WHERE shipping_days_actual < 0;

 -- 7. Late Delivewry Flag Validation
SELECT late_delivery_flag, COUNT(*)
FROM stg_supply_chain
GROUP BY late_delivery_flag;

-- SQL Cleaning inside staging

-- 1. Removing Trailing Spaces
UPDATE stg_supply_chain
SET order_status = TRIM(order_status),
    delivery_status = TRIM(delivery_status),
    payment_type = TRIM(payment_type);

-- 2. Standardize Case
UPDATE stg_supply_chain
SET order_status = UPPER(order_status);

-- ADD INDEXES
CREATE INDEX idx_order_id ON stg_supply_chain(order_id);
CREATE INDEX idx_customer_id ON stg_supply_chain(customer_id);
CREATE INDEX idx_product_id ON stg_supply_chain(product_id);
CREATE INDEX idx_order_date ON stg_supply_chain(order_date); 


 



       





