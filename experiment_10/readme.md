## **Implementation of Transaction Control in PostgreSQL**

---

## 👨‍🎓 **Student Details**  
**Name:** Arnab Lala  
**UID:** 25MCI10232  
**Branch:** MCA (AI & ML)  
**Semester:** Sem - 2  
**Section/Group:** MAM-1 A  
**Subject:** Technical Skills  
**Subject Code:** 25CAP-652  
**Date of Performance:** 21/04/2026  

---

## 🎯 **Aim of the Session**  
To understand and apply transaction control in PostgreSQL using BEGIN, COMMIT, ROLLBACK, and SAVEPOINT to maintain data integrity.

---

## 💻 **Software Requirements**
- PostgreSQL  
- pgAdmin  

---

## 📌 **Objectives**  
- To apply transaction control commands  
- To ensure safe and reliable database updates  
- To understand rollback and savepoint mechanisms  
- To maintain consistency and data integrity  

---

## 🛠️ **Practical / Experiment Steps**  
- Create Payroll table  
- Insert initial data  
- Perform transaction with ROLLBACK  
- Perform transaction with SAVEPOINT  
- Analyze results  

---

# ⚙️ **Procedure of the Practical**

## **Step 1: Table Creation and Data Insertion**

```sql
DROP TABLE IF EXISTS Payroll;

CREATE TABLE Payroll (
 emp_id INT PRIMARY KEY,
 emp_name VARCHAR(50),
 salary DECIMAL(10,2) CHECK (salary > 0)
);

INSERT INTO Payroll VALUES 
(1, 'Amit', 30000),
(2, 'Neha', 40000),
(3, 'Ravi', 50000);

SELECT * FROM Payroll;
```
<img width="856" height="435" alt="image" src="https://github.com/user-attachments/assets/0a783ae1-7050-4812-b8c6-3f6228e5cae7" />

## **Experiment 1: Transaction with ROLLBACK**
```
BEGIN;

UPDATE Payroll 
SET salary = -1000 
WHERE emp_id = 3;

SELECT * FROM Payroll;

ROLLBACK;
```

<img width="856" height="435" alt="image" src="https://github.com/user-attachments/assets/9ed96db3-f890-46b6-b721-de69083e854d" />

## **Experiment 1: Transaction with ROLLBACK**

```
BEGIN;

UPDATE Payroll 
SET salary = -1000 
WHERE emp_id = 3;

SELECT * FROM Payroll;

ROLLBACK;

SELECT * FROM Payroll;
```

<img width="738" height="221" alt="image" src="https://github.com/user-attachments/assets/892b50f8-acee-4e05-bf3f-63a4d11c17b3" />


<img width="856" height="214" alt="image" src="https://github.com/user-attachments/assets/0b16aa8c-0e73-49da-bd58-b5d321064727" />

<img width="856" height="316" alt="image" src="https://github.com/user-attachments/assets/74cad4b9-69e3-4a58-91ce-cc3a1304504a" />


## **Experiment 2: Transaction with SAVEPOINT**

```
BEGIN;

UPDATE Payroll 
SET salary = salary + 5000 
WHERE emp_id = 1;

SAVEPOINT sp1;

UPDATE Payroll 
SET salary = salary + 7000 
WHERE emp_id = 2;

UPDATE Payroll 
SET salary = -1000 
WHERE emp_id = 3;

ROLLBACK TO sp1;

COMMIT;

SELECT * FROM Payroll;
```

<img width="856" height="589" alt="image" src="https://github.com/user-attachments/assets/46620397-1955-4b6f-b7f3-4ba266ffba5e" />

<img width="738" height="240" alt="image" src="https://github.com/user-attachments/assets/fa003a04-21ee-4bec-a5f1-10da99bc375b" />

<img width="856" height="761" alt="image" src="https://github.com/user-attachments/assets/5ce6181b-b71c-4364-a1bb-b56c3e59a3de" />

<img width="856" height="393" alt="image" src="https://github.com/user-attachments/assets/90772ea1-a71b-42de-9eb3-1c9dd6ea1296" />


## Input

a. Payroll table data

b. Transaction control commands

## Output

a.Successful updates

b.Constraint violation handling

c.Rollback and partial rollback results

📘 Learning Outcomes

1.BEGIN starts a transaction block

2.ROLLBACK cancels changes

3.SAVEPOINT allows partial rollback

4.CHECK constraint ensures valid data

5.Transaction control maintains consistency
