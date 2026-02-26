-- CREATE CUSTOMER DIMENSION

DROP TABLE IF EXISTS dim_customer;

CREATE TABLE dim_customer(
-- Business Key
customer_id INT PRIMARY KEY,
-- Customer Attributes
customer_first_name VARCHAR(100),
customer_last_name VARCHAR(100),
customer_segment VARCHAR(50),
customer_city VARCHAR(100),
customer_state VARCHAR(100),
customer_country VARCHAR(100),
customer_zipcode VARCHAR(20),
customer_latitude DECIMAL(10,6),
customer_longitude DECIMAL(10,6)

-- Unique constraint to avoid duplicates


);

INSERT INTO dim_customer (
	SELECT DISTINCT
    customer_id,
    customer_first_name,
    customer_last_name,
    customer_segment,
    customer_city,
    customer_state,
    customer_country,
    customer_zipcode,
    customer_latitude,
    customer_longitude
    FROM stg_supply_chain
);






-- CREATE PRODUCT DIMENSION

DROP TABLE IF EXISTS dim_product;

CREATE TABLE dim_product (
-- Business Key
    product_id INT PRIMARY KEY,
-- Product Attributes
    product_name VARCHAR(255),
    product_price DECIMAL(12,2),
    product_status TINYINT,
    category_id INT,
    category_name VARCHAR(100),
    department_id INT,
    department_name VARCHAR(100)
    
);


INSERT INTO dim_product
SELECT DISTINCT
    product_id,
    product_name,
    product_price,
    product_status,
    category_id,
    category_name,
    department_id,
    department_name

FROM stg_supply_chain;



-- CREATE ORDER DIMENSION

DROP TABLE IF EXISTS dim_order;

CREATE TABLE dim_order (
-- Business Key
    order_id INT PRIMARY KEY,
-- Order Attributes
    order_status VARCHAR(50),
    delivery_status VARCHAR(50),
    market VARCHAR(50),
    order_region VARCHAR(50),
    order_city VARCHAR(100),
    order_state VARCHAR(100),
    order_country VARCHAR(100),
    order_zipcode VARCHAR(20),
    shipping_mode VARCHAR(50)

);

INSERT INTO dim_order (
    SELECT DISTINCT 
    order_id,
    order_status,
    delivery_status,
    market,
    order_region,
    order_city,
    order_state,
    order_country,
    order_zipcode,
    shipping_mode
FROM stg_supply_chain)
;



-- CREATE PAYMENT DIMENSION

DROP TABLE IF EXISTS dim_payment;

CREATE TABLE dim_payment (

-- Business Key
    payment_type VARCHAR(50) UNIQUE
);

INSERT INTO dim_payment
SELECT DISTINCT payment_type
FROM stg_supply_chain;


-- CREATE FACT TABLE

DROP TABLE IF EXISTS fact_order_items;

CREATE TABLE fact_order_items (

    -- Primary Key
    order_item_id INT PRIMARY KEY,

    -- Foreign Keys
    order_id INT,
    customer_id INT,
    product_id INT,
    payment_type VARCHAR(50),

    -- Dates
    order_date DATETIME,
    shipping_date DATETIME,

    -- Measures
    sales_amount DECIMAL(12,2),
    unit_price DECIMAL(12,2),
    quantity INT,
    discount_amount DECIMAL(12,2),
    discount_rate DECIMAL(6,4),
    profit_amount DECIMAL(12,2),
    shipping_days_actual INT,
    shipping_days_scheduled INT,
    late_delivery_flag TINYINT,

    -- Foreign Key Constraints
    FOREIGN KEY (order_id) REFERENCES dim_order(order_id),
    FOREIGN KEY (customer_id) REFERENCES dim_customer(customer_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id),
    FOREIGN KEY (payment_type) REFERENCES dim_payment(payment_type)
);

INSERT INTO fact_order_items (
    SELECT
    order_item_id,
    order_id,
    customer_id,
    product_id,
    payment_type,
    order_date,
    shipping_date,
    sales_amount,
    unit_price,
    quantity,
    discount_amount,
    discount_rate,
    profit_amount,
    shipping_days_actual,
    shipping_days_scheduled,
    late_delivery_flag
    FROM stg_supply_chain
);

-- Final Validation
SELECT COUNT(*) FROM fact_order_items;
SELECT COUNT(*) FROM dim_customer;
SELECT COUNT(*) FROM dim_product;
SELECT COUNT(*) FROM dim_order;
SELECT COUNT(*) FROM dim_payment;



