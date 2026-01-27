CREATE TABLE SCHEMA_ANALYSIS(
	report_id INT PRIMARY KEY,
    entity_name VARCHAR(50) NOT NULL,
    violation_count INT NOT NULL
);
INSERT INTO SCHEMA_ANALYSIS VALUES
(1, 'User_Schema', 0),
(2, 'Order_Schema', 2),
(3, 'Payment_Schema', 4),
(4, 'Inventory_Schema', 2),
(5, 'Audit_Schema', 15);

SELECT*FROM SCHEMA_ANALYSIS;

------------------------------------------------------
-- EXAMPLE 1 : CLASSIFYING DATA USING CASE EXPRESSION
SELECT *,
CASE 
    WHEN violation_count = 0 THEN 'NO VIOLATION'
    WHEN violation_count BETWEEN 1 AND 2 THEN 'MINOR VIOLATION'
    ELSE 'CRITICAL VIOLATION'
END AS VIOLATION_CATEGORY
FROM SCHEMA_ANALYSIS;


-------------------------------------------------------
-- Example 2: Applying CASE Logic in Data Updates

ALTER TABLE SCHEMA_ANALYSIS
ADD COLUMN approval_status VARCHAR(20);

SELECT*FROM SCHEMA_ANALYSIS;

UPDATE SCHEMA_ANALYSIS
SET approval_status =
CASE
    WHEN violation_count = 0 THEN 'Approved'
    WHEN violation_count BETWEEN 1 AND 2 THEN 'Review'
    ELSE 'Rejected'
END;
SELECT*FROM SCHEMA_ANALYSIS;
---------------------------------------------------------

-- Example 3: Implementing IF–ELSE Logic Using PL/pgSQL
DO $$
DECLARE
violation_count INT := 0;   -- change value to test
BEGIN
    IF violation_count = 0 THEN
       RAISE NOTICE 'Status: Approved ';
    ELSIF violation_count BETWEEN 1 AND 2 THEN
    RAISE NOTICE 'Status: Review';
    ELSE
        RAISE NOTICE 'Status: Rejected ';
    END IF;
END $$;

SELECT * FROM SCHEMA_ANALYSIS;