
# Create README.md for Worksheet 5 (Cursor Implementation)
# **DBMS Lab – Worksheet 5**  
## **Implementation of Cursors for Row-by-Row Processing in PostgreSQL**

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
To gain hands-on experience in creating and using cursors for row-by-row processing in a database, enabling sequential access and manipulation of query results for complex business logic.

---

## 💻 **Software Requirements**
- Oracle Database Express Edition  
- PostgreSQL  
- pgAdmin  

---

## 📌 **Objectives**  
- To understand how to fetch rows sequentially using cursors  
- To perform row-level manipulation using procedural logic  
- To understand the cursor lifecycle: Declare, Open, Fetch, Close  
- To handle exceptions during cursor execution  
- To apply cursor-based logic for real-world business scenarios  

---

## 🛠️ **Practical / Experiment Steps**  
- Create Staff table  
- Insert sample staff records  
- Implement a simple forward-only cursor  
- Perform complex row-by-row manipulation  
- Apply bonus calculation logic  
- Implement exception handling within cursor block  

---

# ⚙️ **Procedure of the Practical**

## **Step 1: Create Staff Table**
```sql
CREATE TABLE Staff (
 staff_id SERIAL PRIMARY KEY,
 staff_name VARCHAR(60),
 base_pay NUMERIC(10,2),
 years_of_service INT,
 client_rating INT
);
INSERT INTO Staff (staff_name, base_pay, years_of_service, client_rating) VALUES
('Arjun', 50000, 3, 4),
('Meera', 82000, 9, 5),
('Dev', 45000, 2, 3),
('Sneha', 92000, 12, 5),
('Ishaan', 28000, 1, 2);

SELECT * FROM Staff;
```

<img width="764" height="210" alt="image" src="https://github.com/user-attachments/assets/908042c3-3daa-449a-afc5-9be306caf74f" /><br>
``` sql
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
```

<img width="511" height="119" alt="image" src="https://github.com/user-attachments/assets/a389ea7f-3ad7-4d2b-94ed-6d35acea297f" />

/* -----------------------------------------------------------
   STEP 2: Bonus Calculation and Pay Update
   ----------------------------------------------------------- */
```sql

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
```
<img width="545" height="129" alt="image" src="https://github.com/user-attachments/assets/7a9221e9-c163-4976-a3ee-5fef270fc749" />

/* -----------------------------------------------------------
   STEP 3: Exception Handling Example
   ----------------------------------------------------------- */
```sql
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
```
<img width="370" height="124" alt="image" src="https://github.com/user-attachments/assets/feb93052-43c5-48fe-a450-6c206e3f1556" />

## Outcomes
.Students will be able to implement and manage cursors for row-wise processing.

.Demonstrate lifecycle management of cursors.

.Handle exceptions effectively during iteration.

.Apply cursor logic to real-world payroll and enterprise scenarios.

## Conclusion
This experiment demonstrated practical implementation of cursors in PostgreSQL for sequential row processing, dynamic data manipulation, and structured exception handling in enterprise-level database systems.

