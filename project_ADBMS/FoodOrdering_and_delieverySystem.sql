CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) UNIQUE,
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
---------------------------------------
CREATE TABLE restaurants (
    restaurant_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(150),
    rating DECIMAL(2,1) CHECK (rating >= 0 AND rating <= 5),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-------------------------------------------
CREATE TABLE menu_items (
    item_id SERIAL PRIMARY KEY,
    restaurant_id INT REFERENCES restaurants(restaurant_id) ON DELETE CASCADE,
    item_name VARCHAR(100) NOT NULL,
    price DECIMAL(6,2) CHECK (price > 0),
    is_available BOOLEAN DEFAULT TRUE
);
------------------------------------------

/*
TABLE: order_items

Purpose:
- Stores each item inside an order (1 order → many items)

Key Concepts:
- order_id → links to orders (parent-child relationship)
- item_id → links to menu_items (what food was ordered)
- quantity > 0 → ensures valid order
- price → stored at time of order (avoids future price change issues)
- subtotal → quantity * price (will be automated using trigger later)

ADBMS Concepts:
- Foreign Keys (Referential Integrity)
- CHECK constraints (Data validation)
*/

CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id) ON DELETE CASCADE,
    item_id INT REFERENCES menu_items(item_id),
    quantity INT CHECK (quantity > 0),
    price DECIMAL(6,2) CHECK (price > 0),
    subtotal DECIMAL(8,2)
);
--------------------------------------------------

/*
TABLE: payments

Purpose:
- Stores payment details for each order

Key Concepts:
- order_id → links payment to a specific order
- payment_method → restricts to valid types
- payment_status → tracks transaction state
- amount ≥ 0 → prevents invalid entries

ADBMS Concepts:
- Foreign Key (orders)
- CHECK constraints (controlled values)
*/

CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id) ON DELETE CASCADE,
    payment_method VARCHAR(20) CHECK (payment_method IN ('Cash','Card','UPI')),
    payment_status VARCHAR(20) CHECK (payment_status IN ('Pending','Completed','Failed')),
    amount DECIMAL(8,2) CHECK (amount >= 0),
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

---------------------------------------------
/*
TABLE: delivery_tracking

Purpose:
- Tracks delivery status of each order

Key Concepts:
- order_id → one order = one delivery record
- delivery_status → tracks lifecycle of delivery
- delivery_time → when order was delivered

ADBMS Concepts:
- Foreign Key (orders)
- CHECK constraint (valid delivery states)
*/

CREATE TABLE delivery_tracking (
    delivery_id SERIAL PRIMARY KEY,
    order_id INT UNIQUE REFERENCES orders(order_id) ON DELETE CASCADE,
    delivery_status VARCHAR(20) CHECK (
        delivery_status IN ('Preparing','Out for Delivery','Delivered')
    ),
    delivery_time TIMESTAMP
);
-----------------------------------------------
/*
TABLE: reviews

Purpose:
- Stores user reviews & ratings for restaurants

Key Concepts:
- user_id → who gave the review
- restaurant_id → which restaurant is reviewed
- rating (1–5) → controlled input
- review_text → optional feedback

ADBMS Concepts:
- Foreign Keys (users, restaurants)
- CHECK constraint (rating validation)
*/

CREATE TABLE reviews (
    review_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id) ON DELETE CASCADE,
    restaurant_id INT REFERENCES restaurants(restaurant_id) ON DELETE CASCADE,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    review_text TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-------------------------------------------------------

/*
DATA INSERTION

Purpose:
- Populate tables so queries actually return results

Order of insertion matters (due to FK):
users → restaurants → menu_items → orders → order_items → payments → delivery → reviews
*/

-- USERS
INSERT INTO users (name, email, phone, address) VALUES
('Aman', 'aman@gmail.com', '9991110001', 'Delhi'),
('Riya', 'riya@gmail.com', '9991110002', 'Mumbai'),
('Karan', 'karan@gmail.com', '9991110003', 'Bangalore');

-- RESTAURANTS
INSERT INTO restaurants (name, location, rating) VALUES
('Dominos', 'Delhi', 4.2),
('KFC', 'Mumbai', 4.0),
('Burger King', 'Bangalore', 4.3);

-- MENU ITEMS
INSERT INTO menu_items (restaurant_id, item_name, price) VALUES
(1, 'Pizza', 299),
(1, 'Garlic Bread', 149),
(2, 'Fried Chicken', 199),
(3, 'Burger', 129);

-- ORDERS
INSERT INTO orders (user_id, status, total_amount) VALUES
(1, 'Pending', 0),
(2, 'Confirmed', 0);

-- ORDER ITEMS
INSERT INTO order_items (order_id, item_id, quantity, price) VALUES
(1, 1, 2, 299),
(1, 2, 1, 149),
(2, 3, 2, 199);

-- PAYMENTS
INSERT INTO payments (order_id, payment_method, payment_status, amount) VALUES
(1, 'UPI', 'Completed', 747),
(2, 'Card', 'Pending', 398);

-- DELIVERY
INSERT INTO delivery_tracking (order_id, delivery_status) VALUES
(1, 'Preparing'),
(2, 'Out for Delivery');

-- REVIEWS
INSERT INTO reviews (user_id, restaurant_id, rating, review_text) VALUES
(1, 1, 5, 'Great food'),
(2, 2, 4, 'Nice taste'),
(3, 3, 5, 'Excellent');

-------------------------------------------------------

SELECT * FROM users;
SELECT * FROM restaurants;
SELECT * FROM menu_items;
SELECT * FROM orders;
SELECT * FROM order_items;
SELECT * FROM payments;
SELECT * FROM delivery_tracking;
SELECT * FROM reviews;
SELECT * FROM restaurant_summary;
-------------------------------------------------------

/*
STEP 11 — TRIGGER 1 (AUTO SUBTOTAL)
TRIGGER 1: Auto calculate subtotal

Purpose:
- Automatically sets subtotal = quantity * price before insert/update

ADBMS Concepts:
- Trigger + Function (automation)
*/

CREATE OR REPLACE FUNCTION calc_subtotal()
RETURNS TRIGGER AS $$
BEGIN
    NEW.subtotal := NEW.quantity * NEW.price;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_calc_subtotal
BEFORE INSERT OR UPDATE ON order_items
FOR EACH ROW
EXECUTE FUNCTION calc_subtotal();

---------------------------------------------------------
/*
STEP 12 — TRIGGER 2 (AUTO UPDATE ORDER TOTAL)
TRIGGER 2: Auto update total_amount in orders

Purpose:
- Updates total_amount whenever order_items change

Logic:
- Sum all subtotals for that order

ADBMS Concepts:
- Trigger + Aggregation + Data consistency
*/

CREATE OR REPLACE FUNCTION update_order_total()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE orders
    SET total_amount = (
        SELECT COALESCE(SUM(subtotal), 0)
        FROM order_items
        WHERE order_id = NEW.order_id
    )
    WHERE order_id = NEW.order_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_total
AFTER INSERT OR UPDATE OR DELETE ON order_items
FOR EACH ROW
EXECUTE FUNCTION update_order_total();
---------------------------------------------------
/*
STEP 13 — VIEW (restaurant summary)
VIEW: restaurant_summary

Purpose:
- Shows restaurant with average rating & total reviews

ADBMS Concepts:
- View (virtual table)
- Aggregation (AVG, COUNT)
*/

CREATE VIEW restaurant_summary AS
SELECT 
    r.restaurant_id,
    r.name,
    r.location,
    COALESCE(AVG(rv.rating), 0) AS avg_rating,
    COUNT(rv.review_id) AS total_reviews
FROM restaurants r
LEFT JOIN reviews rv ON r.restaurant_id = rv.restaurant_id
GROUP BY r.restaurant_id, r.name, r.location;
---------------------------------------------------------

/*
STEP 14 — FUNCTION (user order history)
FUNCTION: get_user_orders(uid INT)

Purpose:
- Returns all orders of a specific user

ADBMS Concepts:
- Stored Function (PL/pgSQL)
- Parameterized query
*/

CREATE OR REPLACE FUNCTION get_user_orders(uid INT)
RETURNS TABLE (
    order_id INT,
    order_date TIMESTAMP,
    status VARCHAR,
    total_amount DECIMAL
) AS $$
BEGIN
    RETURN QUERY
    SELECT o.order_id, o.order_date, o.status, o.total_amount
    FROM orders o
    WHERE o.user_id = uid
    ORDER BY o.order_date DESC;
END;
$$ LANGUAGE plpgsql;
----------------------------------------------------------
/*
STEP 15 — INDEXING (performance boost)
INDEXING

Purpose:
- Speeds up frequent queries

Indexes Created:
- users(email) → fast login/search
- orders(user_id) → fast order history lookup
- menu_items(restaurant_id) → fast menu fetch
- reviews(restaurant_id) → fast rating aggregation

ADBMS Concepts:
- Indexing (query optimization)
*/

CREATE INDEX idx_users_email ON users(email);

CREATE INDEX idx_orders_user_id ON orders(user_id);

CREATE INDEX idx_menu_restaurant ON menu_items(restaurant_id);

CREATE INDEX idx_reviews_restaurant ON reviews(restaurant_id);

--------------------------------------------------------------

/*
STEP 16 — QUERIES (FINAL SECTION)
FINAL QUERIES

Purpose:
- Demonstrates SELECT, UPDATE, DELETE, JOIN, AGGREGATION

ADBMS Concepts:
- Joins
- Aggregation
- Filtering
- Data manipulation
*/

-- 1. Get all orders of a user (example user_id = 1)
SELECT * FROM orders WHERE user_id = 1;


-- 2. Get all items in an order (example order_id = 1)
SELECT oi.order_item_id, m.item_name, oi.quantity, oi.subtotal
FROM order_items oi
JOIN menu_items m ON oi.item_id = m.item_id
WHERE oi.order_id = 1;


-- 3. Get restaurant average ratings
SELECT 
    restaurant_id,
    name,
    ROUND(avg_rating, 2) AS avg_rating,
    total_reviews
FROM restaurant_summary;


-- 4. Get top 3 restaurants by rating
SELECT name, round(avg_rating,2)as avg_rating
FROM restaurant_summary
ORDER BY avg_rating DESC
LIMIT 3; 


-- 5. Get total revenue
SELECT SUM(total_amount) AS total_revenue FROM orders;


-- 6. Update order status
UPDATE orders
SET status = 'Delivered'
WHERE order_id = 1;
SELECT * FROM orders WHERE order_id = 1;

UPDATE orders
SET status = 'Confirmed'
WHERE status = 'Pending';

SELECT * FROM orders;
-- 7. Delete a cancelled order
DELETE FROM orders
WHERE status = 'Cancelled';


-- 8. Advanced: Order-wise item list
SELECT 
    o.order_id,
    STRING_AGG(m.item_name, ', ') AS items
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN menu_items m ON oi.item_id = m.item_id
GROUP BY o.order_id
ORDER BY o.order_id;

---Extra ------------------

INSERT INTO order_items (order_id, item_id, quantity, price)
VALUES (1, 1, 1, 299);
SELECT total_amount FROM orders WHERE order_id = 1;