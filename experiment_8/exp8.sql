CREATE TABLE staff (
    staff_id INT PRIMARY KEY,
    staff_name VARCHAR(50),
    salary NUMERIC(20,3)
);
INSERT INTO staff VALUES
(1, 'Rahul', 20000),
(2, 'Neha', 30000),
(3, 'Amit', 25000);

select * from staff;
-- Step 1: Create Procedure for Salary Increment
CREATE OR REPLACE PROCEDURE increment_salary_proc(
    IN P_STAFF_ID INT,
    INOUT P_INCREMENT NUMERIC(20,3),
    OUT RESULT_STATUS VARCHAR(25)
)
AS
$$
DECLARE
    NEW_SAL NUMERIC(20,3);
BEGIN

    -- Calculate new salary
    SELECT salary + P_INCREMENT 
    INTO NEW_SAL 
    FROM staff 
    WHERE staff_id = P_STAFF_ID;

    -- If not found
    IF NOT FOUND THEN
        RAISE EXCEPTION 'STAFF NOT FOUND';
    END IF;

    -- Update salary
    UPDATE staff
    SET salary = NEW_SAL
    WHERE staff_id = P_STAFF_ID;

    -- Return values
    P_INCREMENT := NEW_SAL;
    RESULT_STATUS := 'UPDATED SUCCESSFULLY';

EXCEPTION
WHEN OTHERS THEN
    IF SQLERRM LIKE '%STAFF NOT FOUND%' THEN
        RESULT_STATUS := 'STAFF NOT FOUND';
    ELSE
        RESULT_STATUS := 'ERROR OCCURRED';
    END IF;

END;
$$ LANGUAGE plpgsql;

-- Step 2: Calling of Stored Procedure
DO
$$
DECLARE
    V_STAFF_ID INT := 2;
    V_STATUS VARCHAR(25);
    V_INCREMENT NUMERIC(20,3) := 1000;
BEGIN

    CALL increment_salary_proc(V_STAFF_ID, V_INCREMENT, V_STATUS);

    RAISE NOTICE 
    'STATUS: % | UPDATED SALARY: %',
    V_STATUS, V_INCREMENT;

END;
$$;