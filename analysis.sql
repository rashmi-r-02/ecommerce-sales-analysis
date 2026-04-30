-- Create Customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50)
);

-- Create Products table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(50),
    price INT
);

-- Create Orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insert data into customers
INSERT INTO customers VALUES
(1, 'Ravi', 'Bangalore'),
(2, 'Anita', 'Mumbai'),
(3, 'Rahul', 'Delhi'),
(4, 'Sneha', 'Chennai');

-- Insert data into products
INSERT INTO products VALUES
(101, 'Laptop', 'Electronics', 60000),
(102, 'Phone', 'Electronics', 20000),
(103, 'Headphones', 'Accessories', 2000),
(104, 'Tablet', 'Electronics', 30000);

-- Insert data into orders
INSERT INTO orders VALUES
(1, 1, 101, 1, '2024-01-10'),
(2, 2, 102, 2, '2024-01-12'),
(3, 1, 103, 3, '2024-01-15'),
(4, 3, 104, 1, '2024-01-20'),
(5, 4, 102, 1, '2024-01-22'),
(6, 2, 101, 1, '2024-01-25');

-- Total revenue
SELECT SUM(p.price * o.quantity) AS total_revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id;

-- Revenue by product
SELECT p.product_name, SUM(o.quantity * p.price) AS revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY revenue DESC;

-- Top customers by spending
SELECT c.name, SUM(o.quantity * p.price) AS total_spent
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
GROUP BY c.name
ORDER BY total_spent DESC;

-- Orders by city
SELECT c.city, COUNT(o.order_id) AS total_orders
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.city;

-- Most sold product
SELECT p.product_name, SUM(o.quantity) AS total_sold
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC
LIMIT 1;
