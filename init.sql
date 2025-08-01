CREATE TABLE customers (
    customer_id varchar(10) PRIMARY KEY,
    name VARCHAR(30) not null
);

COPY customers
FROM '/docker-entrypoint-initdb.d/data/customer.csv'
DELIMITER ','
CSV HEADER;

CREATE TABLE sellers (
    seller_id varchar(10) PRIMARY KEY,
    name VARCHAR(30) not null,
    city VARCHAR(25) not null
);

COPY sellers
FROM '/docker-entrypoint-initdb.d/data/seller.csv'
DELIMITER ','
CSV HEADER;

CREATE TABLE riders (
    rider_id varchar(10) PRIMARY KEY,
    name VARCHAR(25) not null
);

COPY riders
FROM '/docker-entrypoint-initdb.d/data/rider.csv'
DELIMITER ','
CSV HEADER;

CREATE TABLE orders (
    order_id varchar(10) PRIMARY KEY,
    customer_id VARCHAR(10) not null,
    seller_id varchar(10) not null,
    order_item varchar (25) not null,
    order_date date DEFAULT CURRENT_DATE,
    order_time time DEFAULT CURRENT_TIME,
    status varchar(15) DEFAULT 'processing',
    total_amount numeric(7,2) not null,
    discount numeric(7,2) DEFAULT 0.0,
    CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES customers (customer_id),
    CONSTRAINT fk_seller FOREIGN KEY (seller_id) REFERENCES sellers (seller_id)
);

COPY orders
FROM '/docker-entrypoint-initdb.d/data/order.csv'
DELIMITER ','
CSV HEADER;

CREATE TABLE delivery (
    delivery_id varchar(10) PRIMARY KEY,
    order_id VARCHAR(10) not null,
    delivery_status varchar (25) DEFAULT 'Out for Delivery',
    delivery_time TIMESTAMP,
    rider_id VARCHAR(10) not null,
    CONSTRAINT fk_order FOREIGN KEY (order_id) REFERENCES orders (order_id),
    CONSTRAINT fk_rider FOREIGN KEY (rider_id) REFERENCES riders (rider_id)
);

COPY delivery
FROM '/docker-entrypoint-initdb.d/data/delivery.csv'
DELIMITER ','
CSV HEADER;