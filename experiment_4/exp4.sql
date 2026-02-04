CREATE TABLE students (
    stud_id    INT PRIMARY KEY,
    stud_name  VARCHAR(50),
    marks      INT,
    attendance INT
);

INSERT INTO students VALUES
(101, 'Amit',    78, 92),
(102, 'Neha',    65, 85),
(103, 'Rohit',   55, 60),
(104, 'Pooja',   48, 72),
(105, 'Karan',   82, 95);
SELECT * FROM students;


-- Example 1 — FOR Loop (Simple Counter)
DO $$
DECLARE
    i INT;
BEGIN
    FOR i IN 1..4 LOOP
        RAISE NOTICE 'Iteration number: %', i;
    END LOOP;
END $$;

-- Example 2 — FOR Loop with Query
DO $$
DECLARE
    rec RECORD;
BEGIN
    FOR rec IN SELECT stud_id, stud_name FROM students LOOP
        RAISE NOTICE 'Student ID: %, Name: %', rec.stud_id, rec.stud_name;
    END LOOP;
END $$;

-- Example 3 — WHILE Loop
DO $$
DECLARE
    cnt INT := 1;
BEGIN
    WHILE cnt <= 3 LOOP
        RAISE NOTICE 'While loop count: %', cnt;
        cnt := cnt + 1;
    END LOOP;
END $$;

-- Example 4 — LOOP with EXIT WHEN
DO $$
DECLARE
    num INT := 1;
BEGIN
    LOOP
        RAISE NOTICE 'Loop cycle: %', num;
        num := num + 1;
        EXIT WHEN num > 5;
    END LOOP;
END $$;

-- Example 5 — Give Bonus Marks Based on Attendance


DO $$
DECLARE
    rec RECORD;
BEGIN
    FOR rec IN SELECT stud_id, attendance FROM students LOOP
        IF rec.attendance > 90 THEN
            UPDATE students
            SET marks = marks + 5
            WHERE stud_id = rec.stud_id;

            RAISE NOTICE 'Grace marks added for Student ID %', rec.stud_id;
        END IF;
    END LOOP;
END $$;

-- Example 6 — Result Classification Using IF inside LOOP
DO $$
DECLARE
    rec RECORD;
BEGIN
    FOR rec IN SELECT stud_name, marks FROM students LOOP
        IF rec.marks >= 75 THEN
            RAISE NOTICE '% -> Result: Excellent', rec.stud_name;
        ELSIF rec.marks >= 60 THEN
            RAISE NOTICE '% -> Result: Good', rec.stud_name;
        ELSIF rec.marks >= 50 THEN
            RAISE NOTICE '% -> Result: Average', rec.stud_name;
        ELSE
            RAISE NOTICE '% -> Result: Needs Improvement', rec.stud_name;
        END IF;
    END LOOP;
END $$;

