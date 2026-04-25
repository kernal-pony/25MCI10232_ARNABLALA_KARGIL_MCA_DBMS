-- DROP TABLES (optional, to avoid errors if re-running)
DROP TABLE IF EXISTS Tbl_Supply_logs;
DROP TABLE IF EXISTS Tbl_Orders;
DROP TABLE IF EXISTS Tbl_Suppliers;
DROP TABLE IF EXISTS Tbl_Products;

-- =========================
-- CREATE TABLES
-- =========================

CREATE TABLE Tbl_Products (
    prod_id INT PRIMARY KEY,
    prod_name VARCHAR(100),
    category VARCHAR(50),
    price INT,
    stock_qty INT
);

CREATE TABLE Tbl_Suppliers (
    sup_id INT PRIMARY KEY,
    sup_name VARCHAR(100),
    city VARCHAR(50),
    rating INT
);

CREATE TABLE Tbl_Orders (
    order_id INT PRIMARY KEY,
    prod_id INT,
    cust_id INT,
    order_date DATE,
    qty INT,
    FOREIGN KEY (prod_id) REFERENCES Tbl_Products(prod_id)
);

CREATE TABLE Tbl_Supply_logs (
    log_id INT PRIMARY KEY,
    action_type VARCHAR(20),
    prod_id INT,
    old_qty INT,
    new_qty INT,
    log_time TIMESTAMP,
    FOREIGN KEY (prod_id) REFERENCES Tbl_Products(prod_id)
);

-- =========================
-- INSERT DATA
-- =========================

-- Products
INSERT INTO Tbl_Products VALUES
(501, 'Laptop Pro', 'Electronics', 75000, 15),
(502, 'Ergo Chair', 'Furniture', 15000, 8);

-- Suppliers
INSERT INTO Tbl_Suppliers VALUES
(701, 'NextGen Tech', 'Bangalore', 5),
(702, 'Comfort Hub', 'Mumbai', 4);

-- Orders
INSERT INTO Tbl_Orders VALUES
(9001, 501, 101, '2026-04-20', 1),
(9002, 502, 102, '2026-04-21', 2);

-- Supply Logs
INSERT INTO Tbl_Supply_logs VALUES
(1, 'UPDATE', 501, 20, 15, '2026-04-20 10:00:00');

-- =========================
-- VERIFY
-- =========================

SELECT * FROM Tbl_Products;
SELECT * FROM Tbl_Suppliers;
SELECT * FROM Tbl_Orders;
SELECT * FROM Tbl_Supply_logs;


select s.sup_name,p.prod_name,o.qty
from Tbl_Orders o
join Tbl_Products p 
on o.prod_id = p.prod_id
cross join Tbl_Suppliers s;




create OR replace FUNCTION update_stock_qty()
returns Trigger AS $$
BEGIN
    update Tbl_Products
    set stock_qty = stock_qty - NEW.qty
    where prod_id = NEW.prod_id;

    return new;
end;
$$ language plpgsql;

create trigger trg_update_stock
after insert on Tbl_Orders
for each row
execute function update_stock_qty();

SELECT * FROM Tbl_Products;

INSERT INTO Tbl_Orders VALUES (9003, 501, 103, '2026-04-25', 3);

select * FROM Tbl_Products WHERE prod_id = 501;

INSERT INTO Tbl_Orders VALUES (9004, 501, 103, '2026-04-25', 3);
