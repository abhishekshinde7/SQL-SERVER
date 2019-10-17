--DATABASE CREATED 
CREATE DATABASE BIKESTORE

--USING BIKESTORE
USE BIKESTORE

---SALES SCHEMA CREATED
CREATE SCHEMA SALES

---PRODUCTION CREATED
CREATE SCHEMA PRODUCTION

---CREATING CUSTOMER TABLE
CREATE TABLE SALES.CUSTOMERS(
customer_id		INT PRIMARY KEY ,
first_name		VARCHAR(50) NOT NULL,
last_name		VARCHAR(50) NOT NULL,
phone			VARCHAR(10) NOT NULL,
email			VARCHAR(40) UNIQUE NOT NULL,
street			VARCHAR(50) NOT NULL,
city			VARCHAR(50) NOT NULL,
state			VARCHAR(50) NOT NULL,
zip_code		VARCHAR(30) NOT NULL
);

--drop table SALES.CUSTOMERS

---creating ORDERS table
CREATE TABLE SALES.ORDERS(
order_id		INT PRIMARY KEY,
customer_id		INT  NOT NULL,
order_status	VARCHAR(50)  NOT NULL,
order_date		VARCHAR(20)  NOT NULL,
required_date	VARCHAR(20)  NOT NULL,
shipped_date	VARCHAR(20)  NOT NULL,
store_id		INT  NOT NULL,
staff_id		INT  NOT NULL,
CONSTRAINT fk_store_id FOREIGN KEY (customer_id)
REFERENCES SALES.CUSTOMERS
);

--drop table SALES.ORDERS
---creating STAFFS table
CREATE TABLE SALES.STAFFS(
staff_id		INT PRIMARY KEY,
first_name		VARCHAR(30) NOT NULL,
last_name		VARCHAR(30) NOT NULL,
email			VARCHAR(30) UNIQUE NOT NULL,
phone			VARCHAR(30) UNIQUE NOT NULL,
active			VARCHAR(30) NOT NULL,
store_id		INT NOT NULL,
manager_id		INT NOT NULL
);
---creating STORES table
CREATE TABLE SALES.STORES(
store_id		INT PRIMARY KEY,
store_name		VARCHAR(30) NOT NULL,
phone			VARCHAR(30) NOT NULL,
email			VARCHAR(30) NOT NULL,
street			VARCHAR(30) NOT NULL,
city			VARCHAR(30) NOT NULL,
state			VARCHAR(30) NOT NULL,
zip_code		VARCHAR(30) NOT NULL
);

--creating ORDER_ITEMS TABLE
CREATE TABLE SALES.ORDER_ITEMS(
item_id    INT PRIMARY KEY,
order_id   INT NOT NULL,
product_id INT NOT NULL,
quantity   INT CHECK(quantity>0),
list_price DECIMAL(6,4)  NOT NULL,
discount   DECIMAL(6,4)  NOT NULL
CONSTRAINT fk_order_id FOREIGN KEY (order_id)
REFERENCES SALES.ORDERS
);

--creating production tables

---creating CATEGORIES table
CREATE TABLE PRODUCTION.CATEGORIES(
category_id INT PRIMARY KEY,
category_name VARCHAR(30)
);
---creating PRODUCTS table
CREATE TABLE PRODUCTION.PRODUCTS(
product_id		INT PRIMARY KEY,
product_name	VARCHAR(30) NOT NULL,
brand_id		INT NOT NULL,
category_id		INT NOT NULL,
model_year		VARCHAR(30) NOT NULL,
list_price		DECIMAL(6,4) NOT NULL
);
---CREATING STOCKS
CREATE TABLE PRODUCTION.STOCKS(
store_id		INT NOT NULL,
product_id      INT NOT NULL,
quantity		INT NOT NULL 
CONSTRAINT fk_store_id FOREIGN KEY (store_id)
REFERENCES  SALES.STORES(store_id),
CONSTRAINT fk_product_id FOREIGN KEY(product_id)
REFERENCES PRODUCTION.PRODUCTS(product_id) 
);
---CREATING BRANDS TABLE
CREATE TABLE PRODUCTION.BRANDS(
brand_id	INT PRIMARY KEY,
brand_name	VARCHAR(30)
);

----setting forign keys in order table
ALTER TABLE SALES.ORDERS
ADD CONSTRAINT fk_store_id1 FOREIGN KEY (store_id)
REFERENCES SALES.STORES (store_id)

ALTER TABLE SALES.ORDERS
ADD CONSTRAINT fk_staff_id FOREIGN KEY (staff_id)
REFERENCES SALES.STAFFS (staff_id)

---SETTING FORIEGN KEYS IN PRODUCTS TABLE
ALTER TABLE PRODUCTION.PRODUCTS 
ADD CONSTRAINT fk_brandid_products FOREIGN KEY (brand_id)
REFERENCES PRODUCTION.BRANDS (brand_id)

ALTER TABLE PRODUCTION.PRODUCTS 
ADD CONSTRAINT fk_categoryid_products FOREIGN KEY (category_id)
REFERENCES PRODUCTION.CATEGORIES (category_id)

---setting forien keys in sales.order_items
ALTER TABLE SALES.ORDER_ITEMS 
ADD CONSTRAINT fk_productid_orderitems FOREIGN KEY (product_id)
REFERENCES PRODUCTION.PRODUCTS (product_id)

----setting forien keys in sales.staffs
ALTER TABLE SALES.STAFFS
ADD CONSTRAINT fk_storeid_staffs FOREIGN KEY (store_id)
REFERENCES SALES.STORES (store_id)

 