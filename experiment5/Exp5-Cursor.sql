/* -----------------------------------------------------------
   Create Staff Table
   ----------------------------------------------------------- */

CREATE TABLE Staff (
    staff_id SERIAL PRIMARY KEY,
    staff_name VARCHAR(60),
    base_pay NUMERIC(10,2),
    years_of_service INT,
    client_rating INT    -- Rating out of 5
);

INSERT INTO Staff (staff_name, base_pay, years_of_service, client_rating) VALUES
('Arjun', 50000, 3, 4),
('Meera', 82000, 9, 5),
('Dev', 45000, 2, 3),
('Sneha', 92000, 12, 5),
('Ishaan', 28000, 1, 2);

SELECT * FROM Staff;
/* -----------------------------------------------------------
   STEP 1: Cursor to Display Staff Details
   ----------------------------------------------------------- */

DO $$
DECLARE
    staff_rec RECORD;
    staff_cursor CURSOR FOR
        SELECT staff_id, staff_name, base_pay
        FROM Staff;
BEGIN

    OPEN staff_cursor;

    LOOP
        FETCH staff_cursor INTO staff_rec;
        EXIT WHEN NOT FOUND;

        RAISE NOTICE 
        'Staff ID: %, Name: %, Base Pay: %',
        staff_rec.staff_id,
        staff_rec.staff_name,
        staff_rec.base_pay;

    END LOOP;

    CLOSE staff_cursor;

END $$;

/*
STEP 2 — Bonus Calculation Logic (Different Formula)

Now we change the business rule completely.

New Bonus Formula:
bonus_percent = (years_of_service * 2) + (client_rating * 3)

Then:

updated_pay = base_pay + (base_pay * bonus_percent / 100)*/

/* -----------------------------------------------------------
   STEP 2: Bonus Calculation and Pay Update
   ----------------------------------------------------------- */
DO $$
DECLARE
    staff_rec RECORD;

    staff_cursor CURSOR FOR
        SELECT staff_id, base_pay, years_of_service, client_rating
        FROM Staff;

    bonus_percent NUMERIC;
    updated_pay NUMERIC;

BEGIN

    OPEN staff_cursor;

    LOOP
        FETCH staff_cursor INTO staff_rec;
        EXIT WHEN NOT FOUND;

        /* Correct ROUND usage */
        bonus_percent :=
            ROUND(
                (staff_rec.years_of_service * 2) +
                (staff_rec.client_rating * 3),
            2);

        updated_pay :=
            ROUND(
                staff_rec.base_pay +
                (staff_rec.base_pay * bonus_percent / 100),
            2);

        UPDATE Staff
        SET base_pay = updated_pay
        WHERE staff_id = staff_rec.staff_id;

        RAISE NOTICE
        'Staff ID: %, Bonus: %%%, Updated Pay: %',
        staff_rec.staff_id,
        bonus_percent,
        updated_pay;

    END LOOP;

    CLOSE staff_cursor;

END $$;
/*
STEP 3 — Exception Handling (Different Condition)

Now instead of low salary,
we’ll throw exception if:

Client rating is less than 2 (poor service performance)
*/

/* -----------------------------------------------------------
   STEP 3: Exception Handling Example
   ----------------------------------------------------------- */

DO $$
DECLARE
    staff_rec RECORD;

    staff_cursor CURSOR FOR
        SELECT staff_id, client_rating
        FROM Staff;

BEGIN

    OPEN staff_cursor;

    LOOP
        FETCH staff_cursor INTO staff_rec;
        EXIT WHEN NOT FOUND;

        -- Raise exception if rating is extremely poor
        IF staff_rec.client_rating < 2 THEN
            RAISE EXCEPTION
            'Unacceptable performance for Staff ID: %',
            staff_rec.staff_id;
        END IF;

        RAISE NOTICE
        'Checked Staff ID: %, Rating: %',
        staff_rec.staff_id,
        staff_rec.client_rating;

    END LOOP;

    CLOSE staff_cursor;

EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Error handled successfully.';
        RAISE NOTICE 'Reason: %', SQLERRM;
        RAISE NOTICE 'Process terminated safely.';

END $$;