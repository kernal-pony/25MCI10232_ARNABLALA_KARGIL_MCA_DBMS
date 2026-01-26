




CREATE TABLE Students (
    student_id INT,
    name VARCHAR(50),
    city VARCHAR(50),
    percentage DECIMAL(5,2)
);
INSERT INTO Students VALUES
(1, 'Amit', 'Delhi', 96.5),
(2, 'Riya', 'Mumbai', 94.2),
(3, 'Rahul', 'Delhi', 97.8),
(4, 'Sneha', 'Mumbai', 98.1),
(5, 'Ankit', 'Chandigarh', 95.6),
(6, 'Pooja', 'Delhi', 93.4),
(7, 'Karan', 'Chandigarh', 96.2);
select * from students;


---Without Case Statement
SELECT CITY , COUNT(*) AS STUDET_COUNT FROM Students 
WHERE percentage> 95
GROUP BY city;

-- WITH CASE STATEMENT


SELECT CITY, SUM(CASE WHEN percentage> 95 THEN 1
ELSE 0 END) AS STUDENT_COUNTS  FROM Students 
GROUP BY city

-- (II)



SELECT CITY,
       CAST(
           AVG(CASE WHEN percentage > 95 THEN percentage ELSE NULL END)
           AS DECIMAL(5,2)
       ) AS STUDENT_AVG
FROM Students
GROUP BY city
ORDER BY STUDENT_AVG DESC;


---customer name, product, quantity, price, and order date.

create table customer_orders(
order_id serial primary key,
customer_name varchar(20),
product varchar(20),
quantity int,
price numeric(10,2),
order_date date
);

insert into customer_orders(customer_name,product,quantity,price,order_date) values
('Arnab', 'Laptop', 1, 55000, '2025-01-05'),
('Deepraj', 'Mouse', 2, 800, '2025-01-06'),
('Riya', 'Mobile', 1, 22000, '2025-01-10'),
('Raima', 'Headphones', 1, 2000, '2025-01-10'),
('Karan', 'Laptop', 1, 60000, '2025-02-02'),
('Subham', 'Keyboard', 1, 1500, '2025-02-05'),
('Nehashis', 'Mobile', 2, 21000, '2025-02-15'),
('Neha', 'Charger', 3, 900, '2025-02-18');

select*from customer_orders;

--Filtering Data Using Conditions Show only those customer who purcahse 20000 above show customer name 
--and product and quantity and price

select order_id,customer_name,product,quantity,price
from customer_orders where price>20000;


---Sorting Query Results
--ascending
select order_id,customer_name,product,quantity,price
from customer_orders where price>20000 order by price ;

--descending
select order_id,customer_name,product,quantity,price
from customer_orders where price>20000 order by price desc;

--Grouping Data for Aggregation
select product ,count(*)as total_product_sale
from customer_orders
group by product;


--Step 5: Applying Conditions on Aggregated Data
select product,
sum(quantity*price) as total_revenue
from customer_orders
group by product
having sum(quantity*price) > 50000;


--step6
select product, sum(quantity*price) as total_revenue
from customer_orders
where order_date >= '2025-01-01'
group by product
having sum(quantity*price) > 50000;


