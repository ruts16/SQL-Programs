create database sqlpract;

use sqlpract;

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2),
    tax DECIMAL(10, 2)
);

INSERT INTO Products (product_id, product_name, price, tax) VALUES
(1, 'Smartphone', 699.99, 50.00),
(2, 'Laptop', 999.99, 75.00),
(3, 'Headphones', 199.99, 15.00),
(4, 'Smartwatch', 299.99, 20.00),
(5, 'Tablet', 499.99, 35.00);

-- Write an SQL query to calculate the total price by adding the price and tax columns for each product in the Products table.
SELECT product_id,product_name,price,tax,(price+tax) AS total_price FROM Products;

-- write a query to calculate the discounted_price for each product where a fixed discount of  $20 is applied.alter

SELECT product_id ,product_name , price,
(price-20) AS discounted_price
FROM Products;

-- Identify even and odd product ids in the products table using modulas operator
SELECT product_id, product_name, 
       CASE 
           WHEN product_id % 2 = 0 THEN 'Even'
           ELSE 'Odd'
       END AS id_type
FROM Products;

-- write sn sql query to find the half price of each product in the products table

SELECT product_id , product_name ,price, (price/2) AS half_price FROM Products; 

-- write query to find all products in the products table where the price is greater than 100

SELECT product_id,product_name,price
FROM Products
WHERE  price>300;

-- write a query to find all the products in the products table where price is between 50 and 250

SELECT product_id,product_name,price FROM Products WHERE  price BETWEEN 50 AND 250;

-- write a query to find all products in the products table where the product_name starts with the letter "M"

SELECT product_id,product_name,price FROM products WHERE product_name LIKE 'S%';

-- Write a query to find all products in the products table where the price is greater than 100 AND the in_stock status is true

ALTER TABLE products
ADD COLUMN in_stock BOOLEAN;

UPDATE Products
SET in_stock = false
WHERE in_stock IS NULL;

SET SQL_SAFE_UPDATES = 0; -- disable safe update mode
SET SQL_SAFE_UPDATES = 1; -- enable safe update mode

UPDATE Products
SET in_stock = true
WHERE product_id IN (1, 3, 4);

UPDATE Products
SET in_stock = false
WHERE  product_id = 2;

SELECT product_id,product_name,price,in_stock FROM Products WHERE price >50 AND in_stock = true;

-- write a query to find all products where the price is less than 100 OR the in_stock status is false.

SELECT product_id,product_name,price, in_stock FROM Products WHERE price < 100  OR in_stock = false; 

-- write a query to find all products that are NOT out of stock

SELECT product_id , product_name , price, in_stock FROM Products WHERE NOT in_stock=false;

-- write a queery to find all products where the price is greater than 50 , in_stock is true AND th eproduct  name contains the letter "0".alter

SELECT product_id , product_name ,price , in_stock
 FROM Products 
 WHERE price > 50 AND in_stock = true 
 AND  product_name LIKE '%o%';
 
-- write a query to find all products where the price is greater 50  AND either  the in_stock status is true OR the product_name starts with P"

SELECT product_id ,product_name ,price ,in_stock  
FROM Products
WHERE price >50 AND (in_stock =true OR product_name LIKE 'P%');

--  write a query to find products where price is greater than 150 orrr price is between 50 and 100.

SELECT product_id ,product_name ,price FROM Products WHERE price >150 OR (price BETWEEN 50 AND 100);
-- -------------------------------------------------------------------

CREATE TABLE Marks (
    student_id INT PRIMARY KEY,
    obtained_marks INT,
    total_marks INT
);

INSERT INTO Marks (student_id, obtained_marks, total_marks) VALUES
(1, 85, 100),
(2, 75, 100),
(3, 92, 100),
(4, 68, 100),
(5, 80, 100);

-- Calaculate  the percentage of marks obtained by a student in the marks table , where the total_marks is the total and obtained_marks is what they scored

SELECT student_id , (obtained_marks * 100.0 / total_marks) AS percentage From Marks;

-- ---------------------------------------------------------------------------------------
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    BirthDate DATE
);

INSERT INTO Employees (employee_id, employee_name, BirthDate) VALUES
(1, 'John Doe', '1985-07-15'),
(2, 'Jane Smith', '1990-03-22'),
(3, 'Michael Brown', '2000-11-10'),
(4, 'Emily Davis', '1995-06-05'),
(5, 'Chris Johnson', '1988-01-30');

-- use the birthdate colun from the table Employees to calculate the age of each employee.

SELECT employee_id , employee_name ,
FLOOR(DATEDIFF(CURRENT_DATE,BirthDate)/365) 
AS Age
FROM Employees;

-- calculate the weekly salary for the employees using the hourly_rate and hours_weekend columns n the Employees table
ALTER TABLE Employees
ADD hourly_rate DECIMAL(10, 2),
ADD hours_worked INT;

UPDATE Employees SET hourly_rate = 25.00, hours_worked = 40 WHERE employee_id = 1;
UPDATE Employees SET hourly_rate = 30.00, hours_worked = 35 WHERE employee_id = 2;
UPDATE Employees SET hourly_rate = 20.00, hours_worked = 50 WHERE employee_id = 3;
UPDATE Employees SET hourly_rate = 18.00, hours_worked = 45 WHERE employee_id = 4;
UPDATE Employees SET hourly_rate = 22.50, hours_worked = 38 WHERE employee_id = 5;

SELECT employee_id,employee_name,(hourly_rate*hours_worked) AS weekly_salary FRom Employees;

SELECT employee_id, employee_name, hourly_rate, hours_worked
FROM Employees
WHERE hourly_rate IS NULL OR hours_worked IS NULL;

-- -----------------------------------------------

CREATE TABLE Cart (
    item_id INT PRIMARY KEY,
    item_name VARCHAR(100),
    quantity INT,
    price DECIMAL(10, 2)
);

INSERT INTO Cart (item_id, item_name, quantity, price) VALUES
(1, 'Laptop', 1, 800.00),
(2, 'Smartphone', 2, 500.00),
(3, 'Headphones', 3, 50.00),
(4, 'Charger', 4, 20.00),
(5, 'Mouse', 5, 15.00);

-- find the total cost of each item in a cart table (quantity *price) 

SELECT item_id,item_name,quantity ,price,(quantity*price) AS total_cost FROM Cart;

-- -----------------------------------------------------------------------------------

CREATE TABLE Sales (
    product_id INT,
    quantity_sold INT,
    price DECIMAL(10, 2),
    discount_price DECIMAL(10,2)
);

INSERT INTO Sales (product_id, quantity_sold, price,discount_price) VALUES
(1, 10, 20.50 ,10.50),  -- Product 1 sold 10 units at $20.50 each
(2, 5, 15.00,10.00),   -- Product 2 sold 5 units at $15.00 each
(1, 8, 20.50,15.05),   -- Product 1 sold 8 more units at $20.50 each
(3, 12, 10.00,05.00),  -- Product 3 sold 12 units at $10.00 each
(2, 7, 15.00,10.05);   -- Product 2 sold 7 more units at $15.00 each

ALTER TABLE Sales
ADD discount_price DECIMAL(10,2);
-- calculate the total revenue generated by multiplying the quantity_sold  and price in the sales table

SELECT product_id, SUM(quantity_sold*price) AS total_revenue FROM Sales GROUP BY product_id;

-- increase the price  of all products by 15% in the product table

SELECT product_id product_name,price,(price *1.15) AS increased_price FROM Products;

-- write a query to find  rows where the price is greater than the discount_price in the Sales table

SELECT product_id ,price,discount_price FROM Sales WHERE price>discount_price;
-- -----------------------------------------------------------------------------------------------------------------

CREATE TABLE Scores (
    student_id INT PRIMARY KEY,
    score1 INT,
    score2 INT
);
INSERT INTO Scores (student_id, score1, score2) VALUES
(1, 85, 90),   -- Student 1 scored 85 and 90
(2, 78, 88),   -- Student 2 scored 78 and 88
(3, 92, 95),   -- Student 3 scored 92 and 95
(4, 70, 75),   -- Student 4 scored 70 and 75
(5, 88, 85);   -- Student 5 scored 88 and 85

ALTER TABLE Scores
ADD Scores INT;

UPDATE Scores SET Scores =85 WHERE student_id=1;
UPDATE Scores SET Scores =85 WHERE student_id=2;
UPDATE Scores SET Scores =95 WHERE student_id=3;
UPDATE Scores SET Scores =75 WHERE student_id=4;
UPDATE Scores SET Scores =65 WHERE student_id=5;

-- find the remainder when dividing score by 7 in the Scores table

SELECT student_id,Scores,(Scores % 7) AS remainder FROM Scores;



-- Find the average of two scores(score1 and score2) for r=each studdent in the score table

SELECT student_id,(score1+score2)/2 AS Average_score FROM Scores;





