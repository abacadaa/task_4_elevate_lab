--1. database task_4_elevate_lab
create database task_4_elevate_lab;
use task_4_elevate_lab;


--2. TABLE customers
CREATE TABLE customers (
    C_ID INT PRIMARY KEY NOT NULL,
    C_Name VARCHAR(50) NOT NULL,
    C_Address VARCHAR(255)
);
ALTER TABLE customers
    -> MODIFY COLUMN C_ID INT NOT NULL AUTO_INCREMENT;

INSERT INTO customers (C_Name, C_Address) VALUES
    -> ('Axyz', '123 addxyz'  ),
    -> ('Bxyz', '456 addxyz'  ),
    -> ('Cxyz', '789 addxyz'  ),
    -> ('Dxyz', '101 addxyz'  ),
    -> ('Exyz', NULL          );


--3. TABLE products
CREATE TABLE products (
    ->     P_ID INT PRIMARY KEY AUTO_INCREMENT,
    ->     P_Name VARCHAR(255) NOT NULL,
    ->     Price DECIMAL(10, 2) NOT NULL,
    ->     Quantity INT NOT NULL
);

INSERT INTO Products (P_Name,Price, Quantity)
    -> VALUES
    -> ('Laptop',    1200.00, 50),
    -> ('Keyboard',  150.00, 200),
    -> ('Charger',   350.00, 100),
    -> ('Mouse',     45.00, 300),
    -> ('Desk Lamp', 75.00, 150);


--4. TABLE orders
CREATE TABLE orders (
    ->     O_ID INT PRIMARY KEY AUTO_INCREMENT,
    ->     C_ID INT NOT NULL,
    ->     P_ID INT NOT NULL,
    ->     OrderDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ->     TotalAmount DECIMAL(10, 2) NOT NULL,
    ->
    ->     FOREIGN KEY (C_ID) REFERENCES customers(C_ID),
    ->     FOREIGN KEY (P_ID) REFERENCES products(P_ID)
    -> );

INSERT INTO Orders (C_ID, P_ID, OrderDate, TotalAmount)
    -> VALUES
    -> (1, '1', '2025-06-01 10:00:00', 1200.00),
    -> (2, '2', '2025-06-02 11:30:00', 150.00),
    -> (1, '3', '2025-06-05 14:15:00', 350.00),
    -> (3, '5', '2025-06-07 09:00:00', 75.00),
    -> (2, '4', '2025-06-10 16:45:00', 45.00),
    -> (4, '2', '2025-06-12 18:00:00', 150.00),
    -> (1, '3', '2025-06-15 09:30:00', 350.00);


SELECT * FROM customers;
SELECT * FROM products;
select * from orders;


--5. SELECT, WHERE, ORDER BY, GROUP BY, 
--SUBQUERIES
SELECT P_Name, Price FROM products;
SELECT * FROM orders WHERE C_ID = 1;
SELECT * FROM products WHERE Price > 100.00;
SELECT * FROM orders ORDER BY OrderDate DESC;
SELECT * FROM orders ORDER BY TotalAmount DESC;
SELECT C_ID, COUNT(O_ID) AS NumberOfOrders
    -> FROM orders
    -> GROUP BY C_ID;
SELECT C_Name, C_Address
    -> FROM customers
    -> WHERE C_ID IN (
    ->     SELECT C_ID
    ->     FROM orders
    ->     WHERE TotalAmount > 100.00
    -> );

--6. JOIN
SELECT
    ->     orders.O_ID,
    ->     C.C_Name,
    ->     C.C_Address,
    ->     orders.OrderDate,
    ->     orders.TotalAmount
    -> FROM
    ->     orders
    -> INNER JOIN
    ->     customers AS C ON orders.C_ID = C.C_ID;

SELECT
    ->          orders.O_ID,
    ->          C.C_Name,
    ->          C.C_Address,
    ->          orders.OrderDate,
    ->          orders.TotalAmount
    ->      FROM
    ->          orders
    ->      LEFT JOIN
    ->          customers AS C ON orders.C_ID = C.C_ID;

SELECT
    ->          orders.O_ID,
    ->          C.C_Name,
    ->          C.C_Address,
    ->          orders.OrderDate,
    ->          orders.TotalAmount
    ->      FROM
    ->          orders
    ->      RIGHT JOIN
    ->          customers AS C ON orders.C_ID = C.C_ID;


--7.  AGGREGATE FUNCTIONS
SELECT SUM(TotalAmount)
    -> FROM orders;
SELECT AVG(Price) AS AverageProductPrice FROM products;
SELECT MAX(Quantity), MIN(Quantity)
    -> FROM products;
SELECT COUNT(P_ID) AS TotalProductsInStock
    -> FROM products
    -> WHERE Quantity>0;


--8. VIEW
CREATE VIEW CustomerOrderSummary AS --
    -> SELECT
    ->     C.C_ID,
    ->     C.C_Name,
    ->     O.O_ID AS OrderID,
    ->     O.OrderDate,
    ->     P.P_Name AS ProductName,
    ->     O.TotalAmount
    -> FROM
    ->     orders AS O
    -> JOIN
    ->     customers AS C ON O.C_ID = C.C_ID
    -> JOIN
    ->     products AS P ON O.P_ID = P.P_ID
    -> ORDER BY
    ->     O.OrderDate DESC;

SELECT * FROM CustomerOrderSummary;


--9. INDEXING
CREATE INDEX idx_order_date ON orders (OrderDate);