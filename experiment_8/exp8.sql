CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    salary NUMERIC(10,2)
);

CREATE OR REPLACE PROCEDURE add_employee_proc(
    IN P_EMP_ID INT,
    IN P_NAME VARCHAR(50),
    IN P_SALARY NUMERIC(10,2),
    OUT STATUS VARCHAR(30)
)
AS $$
BEGIN

    IF EXISTS (SELECT 1 FROM employees WHERE emp_id = P_EMP_ID) THEN
        STATUS := 'EMPLOYEE ALREADY EXISTS';
        RETURN;
    END IF;

    INSERT INTO employees(emp_id, name, salary)
    VALUES (P_EMP_ID, P_NAME, P_SALARY);

    STATUS := 'INSERT SUCCESSFUL';

EXCEPTION
    WHEN OTHERS THEN
        STATUS := 'ERROR: ' || SQLERRM;

END;
$$ LANGUAGE plpgsql;

DO $$
DECLARE
    STATUS VARCHAR(30);
BEGIN

    CALL add_employee_proc(1, 'Arnab', 25000, STATUS);

    RAISE NOTICE 'STATUS: %', STATUS;

END;
$$;

SELECT * FROM employees;
DO $$
DECLARE
    EMP_ID INT := 1;
    STATUS VARCHAR(20);
    SALARY NUMERIC(20,3) := 500;
BEGIN
    CALL update_salary_proc(Emp_id, salary, status);

    RAISE NOTICE 
    'YOUR STATUS IS % AND YOUR UPDATED SALARY IS %',
    STATUS, salary;
END;
$$;