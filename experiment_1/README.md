
# 📘 Experiment 1 – Organizational Database Design Using SQL (DDL, DML, DCL)

## 👨‍🎓 Student Details
- **Name:** Arnab Lala  
- **UID:** 25MCI10232  
- **Branch:** MCA  
- **Section:** MAM-1(A)  
- **Semester:** 2nd  
- **Subject:** Technical Training  
- **Subject Code:** 25CAP-652  
- **Date of Performance:** 6 January 2026  

---

## 1️⃣ Experiment
**Title:**  
Design and Implementation of an Organizational Database System Using PostgreSQL

---

## 2️⃣ Objective
The objectives of this experiment are:
- To understand and apply DDL commands such as CREATE, ALTER, and DROP  
- To perform DML operations like INSERT, UPDATE, DELETE, and SELECT  
- To implement DCL commands including CREATE ROLE, GRANT, and REVOKE  
- To enforce referential integrity using primary and foreign keys  
- To provide controlled and secure access using role-based privileges  

---

## 3️⃣ Practical / Experiment Steps  
*(In place of experiment question)*

1. Create tables for Department, Employee, and Project.  
2. Define primary keys and foreign key relationships.  
3. Insert sample records into all tables.  
4. Display records to verify successful insertion.  
5. Perform UPDATE and DELETE operations.  
6. Create roles and assign privileges using GRANT.  
7. Revoke selected permissions to control access.  

---

## 4️⃣ Procedure of the Experiment and Screenshots  

### Step 1: Table Creation (DDL Commands)
sql
CREATE TABLE Department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(30) UNIQUE NOT NULL
);

CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(30) NOT NULL,
    emp_email VARCHAR(40) UNIQUE NOT NULL,
    emp_phone VARCHAR(15) UNIQUE NOT NULL,
    emp_address VARCHAR(50),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
    ON UPDATE CASCADE
    ON DELETE SET NULL
);

CREATE TABLE Project (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(30) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    assigned_emp INT,
    FOREIGN KEY (assigned_emp) REFERENCES Employee(emp_id)
    ON UPDATE CASCADE
    ON DELETE SET NULL
);


---

### Step 2: Insert Records (DML Commands)

INSERT INTO Department VALUES
(10, 'Research'),
(20, 'Development'),
(30, 'Sales'),
(40, 'Operations');

INSERT INTO Employee VALUES
(201, 'Arjun Das', 'arjun@gmail.com', '9001112222', 'Kolkata', 20),
(202, 'Meera Roy', 'meera@gmail.com', '9003334444', 'Delhi', 20),
(203, 'Sahil Khan', 'sahil@gmail.com', '9005556666', 'Mumbai', 30),
(204, 'Nina Paul', 'nina@gmail.com', '9007778888', 'Chennai', 10),
(205, 'Vikram Jain', 'vikram@gmail.com', '9009990000', 'Pune', 40);

INSERT INTO Project VALUES
(1, 'Inventory System', '2026-01-05', '2026-06-30', 201),
(2, 'CRM Software', '2026-02-10', '2026-07-15', 202),
(3, 'Sales Dashboard', '2026-03-01', '2026-05-31', 203),
(4, 'Research Portal', '2026-01-20', '2026-04-25', 204),
(5, 'Ops Automation', '2026-02-01', '2026-08-01', 205);


---

### Step 3: Data Modification

UPDATE Employee
SET dept_id = 40
WHERE emp_id = 203;

DELETE FROM Employee WHERE emp_id = 205;


---

### Step 4: Role Creation and Privilege Management (DCL Commands)

CREATE ROLE HR LOGIN PASSWORD 'HR';

GRANT SELECT, INSERT, UPDATE ON Employee TO HR;
GRANT SELECT ON Department TO HR;
GRANT SELECT, INSERT, UPDATE ON Project TO HR;

REVOKE INSERT ON Employee FROM HR;
REVOKE UPDATE ON Department FROM HR;



---

## 5️⃣ Output Screenshots  
<img width="334" height="236" alt="image" src="https://github.com/user-attachments/assets/68908b15-e522-4f7d-bf48-6989a66d294c" /> <br>
<br><img width="615" height="139" alt="image" src="https://github.com/user-attachments/assets/e8e8ac82-5dcb-45c3-9e7f-ff7c6262ce39" />
<br><img width="660" height="159" alt="image" src="https://github.com/user-attachments/assets/9236c62e-2d0a-4318-bbb7-196d2573937b" />
<br><img width="424" height="94" alt="image" src="https://github.com/user-attachments/assets/07946c7b-acf7-4777-98c4-0c14d79922bd" />






---

## 6️⃣ Learning Outcome
After completing this experiment, I learned:
1. How to design a relational database using multiple tables  
2. How to apply constraints to maintain data integrity  
3. How to perform INSERT, UPDATE, and DELETE operations  
4. How foreign keys maintain relationships between tables  
5. How to manage database security using roles and privileges  

---

## 7️⃣ Tools / Technologies Used
- **Database:** PostgreSQL  
- **GUI Tool:** pgAdmin  
- **Query Language:** SQL (DDL, DML, DCL)

---
