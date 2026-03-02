-- STEP 1 — Create Categories Table

CREATE TABLE Categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100)
);

INSERT INTO Categories (category_name) VALUES
('Electronics'),
('Clothing'),
('Groceries'),
('Home Decor');

-- STEP 2 — Create Products Table


CREATE TABLE Products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    price NUMERIC(10,2),
    stock_quantity INT,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);


INSERT INTO Products (product_name, price, stock_quantity, category_id) VALUES
('Smartphone', 25000, 15, 1),
('Jeans', 1800, 40, 2),
('Rice Bag 5kg', 600, 100, 3),
('Table Lamp', 1200, 8, 4),
('Bluetooth Headphones', 3500, 5, 1);


-- STEP 3 — Simple Filter View (Low Stock View)


-- Create a view to show low stock products.

CREATE OR REPLACE VIEW low_stock_products AS
SELECT product_id, product_name, stock_quantity
FROM Products
WHERE stock_quantity < 10;

SELECT * FROM low_stock_products;


-- STEP 4 — Join View (Product + Category)


CREATE OR REPLACE VIEW product_category_view AS
SELECT 
    p.product_id,
    p.product_name,
    p.price,
    p.stock_quantity,
    c.category_name
FROM Products p
JOIN Categories c
ON p.category_id = c.category_id;



SELECT * FROM product_category_view;


-- STEP 5 — Aggregate View (Category Statistics)

CREATE OR REPLACE VIEW category_inventory_summary AS
SELECT 
    c.category_name,
    COUNT(p.product_id) AS total_products,
    SUM(p.stock_quantity) AS total_stock,
    AVG(p.price) AS average_price,
    MAX(p.price) AS highest_price,
    MIN(p.price) AS lowest_price
FROM Categories c
LEFT JOIN Products p
ON c.category_id = p.category_id
GROUP BY c.category_name;

SELECT * FROM category_inventory_summary;


-- STEP 6 — Create Sales Table
CREATE TABLE Sales (
    sale_id SERIAL PRIMARY KEY,
    product_id INT,
    quantity_sold INT,
    sale_date DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
INSERT INTO Sales (product_id, quantity_sold, sale_date) VALUES
(1, 3, '2026-03-01'),
(2, 5, '2026-03-01'),
(1, 2, '2026-03-02'),
(3, 10, '2026-03-02'),
(5, 4, '2026-03-03'),
(4, 1, '2026-03-03');

-- STEP 7 — Revenue View

CREATE OR REPLACE VIEW sales_revenue_summary AS
SELECT 
    p.product_name,
    SUM(s.quantity_sold) AS total_units_sold,
    SUM(s.quantity_sold * p.price) AS total_revenue
FROM Sales s
JOIN Products p
ON s.product_id = p.product_id
GROUP BY p.product_name;

SELECT * FROM sales_revenue_summary;

-- STEP 8 — Top Selling Products View

CREATE OR REPLACE VIEW top_selling_products AS
SELECT 
    p.product_name,
    SUM(s.quantity_sold) AS total_units_sold
FROM Sales s
JOIN Products p
ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_units_sold DESC;


SELECT * FROM top_selling_products;