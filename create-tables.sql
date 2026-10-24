
CREATE DATABASE IF NOT EXISTS superstore_dw;

USE superstore_dw;

SHOW DATABASES;

USE superstore_dw;

CREATE TABLE IF NOT EXISTS dim_client (
    client_key INT AUTO_INCREMENT PRIMARY KEY,
    customer_id VARCHAR(20) NOT NULL UNIQUE,
    customer_name VARCHAR(100),
    segment VARCHAR(30)
);

CREATE TABLE IF NOT EXISTS dim_produit (
    product_key INT AUTO_INCREMENT PRIMARY KEY,
    product_id VARCHAR(30) NOT NULL UNIQUE,
    product_name VARCHAR(255),
    category VARCHAR(50),
    sub_category VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS dim_localisation (
    location_key INT AUTO_INCREMENT PRIMARY KEY,
    country VARCHAR(100),
    city VARCHAR(100),
    state VARCHAR(100),
    postal_code VARCHAR(20),
    region VARCHAR(30),
    UNIQUE KEY uq_location (
        country, city, state, postal_code, region
    )
);

CREATE TABLE IF NOT EXISTS dim_date (
    date_key INT PRIMARY KEY,
    full_date DATE NOT NULL UNIQUE,
    year_num SMALLINT,
    quarter_num TINYINT,
    month_num TINYINT,
    month_name VARCHAR(20),
    day_num TINYINT,
    weekday_name VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS fact_ventes (
    sales_key BIGINT AUTO_INCREMENT PRIMARY KEY,
    row_id INT NOT NULL UNIQUE,
    order_id VARCHAR(30),
    order_date_key INT,
    ship_date_key INT,
    client_key INT,
    product_key INT,
    location_key INT,
    ship_mode VARCHAR(30),
    sales DECIMAL(12,2),
    quantity INT,
    discount DECIMAL(8,4),
    profit DECIMAL(12,4),

    FOREIGN KEY (order_date_key)
        REFERENCES dim_date(date_key),
    FOREIGN KEY (ship_date_key)
        REFERENCES dim_date(date_key),
    FOREIGN KEY (client_key)
        REFERENCES dim_client(client_key),
    FOREIGN KEY (product_key)
        REFERENCES dim_produit(product_key),
    FOREIGN KEY (location_key)
        REFERENCES dim_localisation(location_key)
);
SHOW TABLES;
