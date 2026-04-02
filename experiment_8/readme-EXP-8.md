# **DBMS Lab – Worksheet 8**  
## **Implementation of Stored Procedures in PostgreSQL**

---

## 👨‍🎓 **Student Details**  
**Name:** Arnab Lala  
**UID:** 25MCI10232  
**Branch:** MCA (AI & ML)  
**Semester:** 2nd Sem  
**Section/Group:** MAM-1 A  
**Subject:** Technical Skills  
**Subject Code:** 25CAP-652_25MAM_KAR-1(A)  
**Date of Performance:** 12/01/2026  

---

## 🎯 **Aim of the Session**  
To apply the concept of stored procedures in database operations to perform insertion, updating, deletion, and retrieval efficiently, securely, and in a reusable manner.

---

## 💻 **Software Requirements**
- Oracle Database Express Edition  
- PostgreSQL  
- pgAdmin  

---

## 📌 **Objectives**  
- To understand stored procedures in database systems  
- To implement stored procedures for CRUD operations  
- To enhance data security using procedures  
- To reduce code redundancy using reusable logic  
- To improve performance using precompiled procedures  

---

## 🛠️ **Practical / Experiment Steps**  
- Create staff table  
- Insert sample data  
- Create stored procedure  
- Implement salary update logic  
- Handle exceptions  
- Execute procedure using DO block  

---

# ⚙️ **Procedure of the Practical**

## **Step 0: Table Creation and Data Insertion**

```sql
CREATE TABLE staff (
 staff_id INT PRIMARY KEY,
 staff_name VARCHAR(50),
 salary NUMERIC(20,3)
);

INSERT INTO staff VALUES
(1, 'Rahul', 20000),
(2, 'Neha', 30000),
(3, 'Amit', 25000);

SELECT * FROM staff;
```

<img width="756" height="216" alt="image" src="https://github.com/user-attachments/assets/4b22d102-897c-4916-a40b-1d3b5bf7f55d" />


## **Step 1: Create Stored Procedure**
```sql
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

 SELECT salary + P_INCREMENT 
 INTO NEW_SAL 
 FROM staff 
 WHERE staff_id = P_STAFF_ID;

 IF NOT FOUND THEN
  RAISE EXCEPTION 'STAFF NOT FOUND';
 END IF;

 UPDATE staff
 SET salary = NEW_SAL
 WHERE staff_id = P_STAFF_ID;

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
```

<img width="578" height="128" alt="image" src="https://github.com/user-attachments/assets/2344863f-0f1f-423c-bfdf-0f421e930f5c" />

## **Step 2: Execute Stored Procedure**
```sql 
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
```

<img width="859" height="152" alt="image" src="https://github.com/user-attachments/assets/65af6d69-a1fe-4156-bdb8-7492c1f7c293" />


## **Learning Outcomes**

1. Ability to create and execute stored procedures

2. Understanding secure database operations using procedures

3. Ability to handle exceptions in PL/pgSQL

4. Writing reusable and modular SQL logic

5. Improving database performance using procedures
