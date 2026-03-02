# Create README.md for Worksheet 6 (Views Implementation)

# **DBMS Lab – Worksheet 6**  
## **Implementation of Views for Data Abstraction and Reporting in PostgreSQL**

---

## 👨‍🎓 **Student Details**  
**Name:** Arnab Lala  
**UID:** 25MCI10232  
**Branch:** MCA (AI & ML)  
**Semester:** SEM II  
**Section/Group:** MAM-1 A  
**Subject:** Technical Skills  
**Subject Code:** 25CAP-652_25MAM_KAR-1(A)  
**Date of Performance:** 24/02/2026  

---

## 🎯 **Aim of the Session**  
To learn how to create, query, and manage views in SQL to simplify database queries and provide a layer of abstraction for end-users.

---

## 💻 **Software Requirements**
- Oracle Database Express Edition  
- PostgreSQL  
- pgAdmin  

---

## 📌 **Objectives**  
- To understand how to hide complex joins using views  
- To restrict user access to sensitive columns  
- To simplify reporting queries for non-technical users  
- To learn syntax for creating, replacing, and managing views  

---

## 🛠️ **Practical / Experiment Steps**  
- Create Categories table  
- Create Products table with foreign key  
- Create filter-based view  
- Create join view  
- Create aggregate view  
- Create Sales table  
- Create revenue and top-selling product views  

---

# ⚙️ **Procedure of the Practical**

## **Step 1: Create Categories Table**
```sql
CREATE TABLE Categories (
 category_id SERIAL PRIMARY KEY,
 category_name VARCHAR(100)
);

INSERT INTO Categories (category_name) VALUES
('Electronics'),
('Clothing'),
('Groceries'),
('Home Decor');

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


CREATE OR REPLACE VIEW low_stock_products AS
SELECT product_id, product_name, stock_quantity
FROM Products
WHERE stock_quantity < 10;

SELECT * FROM low_stock_products;
```
<img width="530" height="123" alt="image" src="https://github.com/user-attachments/assets/863080c3-1ab3-44cd-8b09-e4ee8a984fe1" /><br><br>
```sql

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
```
<img width="698" height="170" alt="image" src="https://github.com/user-attachments/assets/640334ca-ae7e-473d-822f-85e574416b4d" /><br><br>
``` sql
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
```
<img width="850" height="155" alt="image" src="https://github.com/user-attachments/assets/7dbdf248-a797-46cb-a927-1cb78e3b986c" /><br><br>

```sql

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
```
<img width="491" height="192" alt="image" src="https://github.com/user-attachments/assets/ecd6afaa-4651-43e5-802d-76e5ce75da35" /><br><br>
```sql
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
```
<img width="409" height="218" alt="image" src="https://github.com/user-attachments/assets/7324b63c-887d-4fa2-af1c-ec9f1c1a5983" /><br><br>

📘 Learning Outcomes

1.Ability to create and manage SQL views

2.Understanding abstraction and security using views

3.Simplifying complex joins for reporting

4.Implementing aggregate reporting logic using views

5.Applying real-world reporting concepts in database systems
