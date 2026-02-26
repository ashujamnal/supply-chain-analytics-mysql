-- Indexes for performance optimization

CREATE INDEX idx_fact_order_id ON fact_order_items(order_id);
CREATE INDEX idx_fact_customer_id ON fact_order_items(customer_id);
CREATE INDEX idx_fact_product_id ON fact_order_items(product_id);
CREATE INDEX idx_order_date ON fact_order_items(order_date);

CREATE INDEX idx_order_region ON dim_order(order_region);
CREATE INDEX idx_shipping_mode ON dim_order(shipping_mode);
CREATE INDEX idx_order_status ON dim_order(order_status);
