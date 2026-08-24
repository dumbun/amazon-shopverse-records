USE AmazonShopverseRecords;

-- Row Count
SELECT COUNT(*) AS total_orders
FROM   shopverse_records;

-- Column-level NULL check
SELECT *
FROM   shopverse_records
WHERE  OrderID IS NULL
       OR OrderDate IS NULL
       OR CustomerID IS NULL
       OR CustomerName IS NULL
       OR ProductID IS NULL
       OR ProductName IS NULL
       OR Category IS NULL
       OR Brand IS NULL
       OR Quantity IS NULL
       OR UnitPrice IS NULL
       OR Discount IS NULL
       OR Tax IS NULL
       OR ShippingCost IS NULL
       OR TotalAmount IS NULL
       OR PaymentMethod IS NULL
       OR OrderStatus IS NULL
       OR City IS NULL
       OR State IS NULL
       OR Country IS NULL
       OR SellerID IS NULL;

-- Sample Data
SELECT *
FROM   shopverse_records;

-- Cheking the dates are not excedding current date
SELECT *
FROM   shopverse_records
WHERE  OrderDate > CURRENT_DATE;

-- Checking the product name have any extra spacing
SELECT *
FROM   shopverse_records
WHERE  ProductName != TRIM(ProductName);

--  Cheking for empty cells in catergory & spacing
SELECT DISTINCT Category
FROM   shopverse_records;

SELECT *
FROM   shopverse_records
WHERE  Category != TRIM(Category);

-- Cheking for data standradisation in countrys
SELECT DISTINCT country
FROM   shopverse_records;

-- Cheking for data standradisation in Payment Method
SELECT DISTINCT PaymentMethod
FROM   shopverse_records;

-- Cheking for duplicate orders
SELECT *
FROM   (SELECT *,
               ROW_NUMBER() OVER (PARTITION BY OrderID) AS flag
        FROM   shopverse_records) AS t
WHERE  flag > 1;