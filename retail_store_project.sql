-- Retail Store Sales Analysis Project
-- Created by Vishal Sharma
-- Description: SQL-based sales analysis for resume    
CREATE DATABASE retail_store;
USE retail_store;
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    join_date DATE
);
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
CREATE TABLE Order_Details (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
INSERT INTO Customers VALUES
(1, 'Rahul Sharma', 'Delhi', '2023-01-10'),
(2, 'Priya Singh', 'Mumbai', '2023-02-15'),
(3, 'Amit Verma', 'Noida', '2023-03-05'),
(4, 'Sneha Kapoor', 'Delhi', '2023-04-12'),
(5, 'Arjun Mehta', 'Gurgaon', '2023-05-20');
INSERT INTO Products VALUES
(101, 'Laptop', 'Electronics', 55000),
(102, 'Mobile Phone', 'Electronics', 20000),
(103, 'Headphones', 'Accessories', 2000),
(104, 'Office Chair', 'Furniture', 8000),
(105, 'Desk Lamp', 'Furniture', 1500);
INSERT INTO Orders VALUES
(1001, 1, '2023-06-01'),
(1002, 2, '2023-06-05'),
(1003, 1, '2023-07-10'),
(1004, 3, '2023-07-12'),
(1005, 4, '2023-08-01');
INSERT INTO Order_Details VALUES
(1, 1001, 101, 1),
(2, 1001, 103, 2),
(3, 1002, 102, 1),
(4, 1003, 104, 1),
(5, 1004, 105, 3),
(6, 1005, 101, 1);


-- Step 4: Checking JOIN between Order_Details and Products

SELECT * 
FROM Order_Details od
JOIN Products p 
ON od.product_id = p.product_id;


-- Business Question 1: Total Revenue

SELECT SUM(p.price * od.quantity) AS total_revenue
FROM Order_Details od
JOIN Products p 
ON od.product_id = p.product_id;


-- Business Question 2: Revenue by Category

SELECT p.category,
       SUM(p.price * od.quantity) AS revenue
FROM Order_Details od
JOIN Products p 
ON od.product_id = p.product_id
GROUP BY p.category
ORDER BY revenue DESC;


-- Business Question 3: Top Customers by Spending

SELECT c.customer_name,
       SUM(p.price * od.quantity) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Order_Details od ON o.order_id = od.order_id
JOIN Products p ON od.product_id = p.product_id
GROUP BY c.customer_name
ORDER BY total_spent DESC;


-- Business Question 4: Monthly Revenue Trend

SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS month,
       SUM(p.price * od.quantity) AS monthly_revenue
FROM Orders o
JOIN Order_Details od ON o.order_id = od.order_id
JOIN Products p ON od.product_id = p.product_id
GROUP BY month
ORDER BY month;