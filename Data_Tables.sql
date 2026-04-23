-- Database	 Creation 
CREATE DATABASE E_commerce_store;

-- use database
USE E_commerce_store;

-- Tables Creation 
-- Customer Table
CREATE TABLE customers(
customer_id	VARCHAR(255) PRIMARY key,
customer_unique_id	VARCHAR(255) NOT NULL ,
customer_zip_code_prefix  INT NOT NULL,
customer_city	VARCHAR(100) NOT NULL,
customer_state  VARCHAR(100) NOT NULL
) ;

--  Geolocation Table
CREATE TABLE geolocation1(
geolocation_zip_code_prefix	VARCHAR(10) ,
geolocation_lat	DECIMAL(13,10) NOT NULL,
geolocation_lng	DECIMAL(13,10) NOT NULL,
geolocation_city VARCHAR(50) NOT NULL,
geolocation_state VARCHAR(30) NOT NULL
);

-- Orders Table
CREATE TABLE orders(
order_id VARCHAR(150) PRIMARY KEY,
customer_id VARCHAR(255) NOT NULL,
order_status VARCHAR(20) NOT NULL,
order_purchase_timestamp DATETIME NOT NULL,
order_approved_at DATETIME NULL,
order_delivered_carrier_date DATETIME NULL,
order_delivered_customer_date DATETIME NULL,
order_estimated_delivery_date DATETIME NOT NULL,
FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Product Table
CREATE TABLE product(
product_id VARCHAR(255) PRIMARY KEY,
product_category_name VARCHAR(40),
product_name_lenght INT,
product_description_lenght INT,
product_photos_qty INT,
product_weight_g INT,
product_length_cm INT,
product_height_cm INT,
product_width_cm INT
);

-- Seller Table
CREATE TABLE sellers(
seller_id VARCHAR(150) PRIMARY KEY,
seller_zip_code_prefix VARCHAR(15),
seller_city VARCHAR(50),
seller_state VARCHAR(20)
);

-- Orders_Items Table
CREATE TABLE orders_items(
order_id VARCHAR(150) ,
order_item_id VARCHAR(150)  NOT NULL,
product_id VARCHAR(255),
seller_id VARCHAR(150),
shipping_limit_date DATETIME,
price DECIMAL(10,2) NOT NULL,
freight_value DECIMAL(10,2) NOT NULL,
FOREIGN KEY (order_id) REFERENCES orders(order_id),
FOREIGN KEY (product_id) REFERENCES product(product_id),
FOREIGN KEY (seller_id) REFERENCES sellers(seller_id)
);

-- Order_Payments Table
CREATE TABLE order_payments(
order_id VARCHAR(150) ,
payment_sequential INT NOT NULL,
payment_type VARCHAR(20) NOT NULL,
payment_installments INT NOT NULL, 
payment_value DECIMAL(10,2) NOT NULL,
FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- Order_Reviews
CREATE TABLE order_reviews(
review_id VARCHAR(150) ,
order_id VARCHAR(150) NOT NULL,
review_score INT NOT NULL,
review_comment_title VARCHAR(150) NULL,
review_comment_message TEXT,
review_creation_date DATETIME NOT NULL,
review_answer_timestamp DATETIME NOT NULL,
FOREIGN KEY (order_id) REFERENCES orders(order_id)
);


show tables;