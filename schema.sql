-- Safely drop the database if it is already present
DROP DATABASE IF EXISTS AmazonShopverseRecords;

--  CREATEING DATABASE
CREATE DATABASE AmazonShopverseRecords;

--  USING THE DATABASE 
USE AmazonShopverseRecords;

-- Drop existing table if exists
DROP TABLE IF EXISTS shopverse_records;

-- Create Main Transaction Table
CREATE TABLE shopverse_records (
    OrderID       VARCHAR (20)    PRIMARY KEY,
    OrderDate     DATE           ,
    CustomerID    VARCHAR (20)   ,
    CustomerName  VARCHAR (100)  ,
    ProductID     VARCHAR (20)   ,
    ProductName   VARCHAR (100)  ,
    Category      VARCHAR (100)  ,
    Brand         VARCHAR (100)  ,
    Quantity      INT            ,
    UnitPrice     DECIMAL (12, 2),
    Discount      DECIMAL (10, 2),
    Tax           DECIMAL (10, 2),
    ShippingCost  DECIMAL (10, 2),
    TotalAmount   DECIMAL (12, 2),
    PaymentMethod VARCHAR (50)   ,
    OrderStatus   VARCHAR (50)   ,
    City          VARCHAR (100)  ,
    State         VARCHAR (100)  ,
    Country       VARCHAR (100)  ,
    SellerID      VARCHAR (20)   
);

CREATE INDEX idx_order_id
    ON shopverse_records(OrderID);

