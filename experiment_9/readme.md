# **DBMS Lab – Worksheet 9**  
## **Implementation of Triggers in PostgreSQL**

---

## 👨‍🎓 **Student Details**  
**Name:** Arnab Lala  
**UID:** 25MCI10232  
**Branch:** MCA (AI & ML)  
**Semester:** Sem - 2  
**Section/Group:** MAM-1 A  
**Subject:** Technical Skills  
**Subject Code:** 25CAP-652  
**Date of Performance:** 07/04/2026  

---

## 🎯 **Aim of the Session**  
To implement database triggers in PostgreSQL to automatically calculate values and enforce constraints during data insertion operations.

---

## 💻 **Software Requirements**
- PostgreSQL  
- pgAdmin  

---

## 📌 **Objectives**  
- To understand how to create and use triggers in PostgreSQL  
- To automate calculations using triggers  
- To enforce constraints using trigger conditions  
- To implement real-time database processing  

---

## 📖 **Theory**  
Triggers are special database objects that automatically execute a function when an event (INSERT, UPDATE, DELETE) occurs on a table.  

In PostgreSQL:
- Triggers are linked with trigger functions  
- Written in PL/pgSQL  
- Used for automation, validation, and data integrity  

---

## 🛠️ **Practical / Experiment Steps**  
- Create employee table  
- Create trigger function  
- Create trigger  
- Insert valid data  
- Insert invalid data (exception case)  
- Retrieve final data  

---

# ⚙️ **Procedure of the Practical**

## **Step 1: Create Table**

```sql
CREATE TABLE employee (
 emp_id INT PRIMARY KEY,
 emp_name VARCHAR(50),
 working_hours INT,
 perhour_salary NUMERIC,
 total_payable_amount NUMERIC
);
```
<img width="705" height="213" alt="image" src="https://github.com/user-attachments/assets/25ff5feb-c77d-430a-b7c3-7b7527a20f15" />

## **Step 2: Create Trigger Function**


```

CREATE OR REPLACE FUNCTION CACULATE_PAYABLE_AMOUNT() 
RETURNS TRIGGER 
AS 
$$ 
BEGIN 
 NEW.total_payable_amount := NEW.perhour_salary * NEW.working_hours;

 IF NEW.total_payable_amount > 25000 THEN 
  RAISE EXCEPTION 'INVALID ENTRY BEACUSE PAYABLE AMOUNT CAN NOT BE GREATER THAN 25000'; 
 END IF;

 RETURN NEW; 
END; 
$$ LANGUAGE PLPGSQL;
```

<img width="1055" height="214" alt="image" src="https://github.com/user-attachments/assets/64a184ca-2e1c-4f15-98e1-e808e6ebf6c6" />

## **Step 3: Create Trigger**

```
CREATE OR REPLACE TRIGGER 
AUTOMATED_PAYABLE_AMOUNT_CALCULATION 
BEFORE INSERT 
ON employee 
FOR EACH ROW 
EXECUTE FUNCTION CACULATE_PAYABLE_AMOUNT();
```


## **Step 4: Insert Valid Data**

```
INSERT INTO employee(emp_id, emp_name, working_hours, perhour_salary) 
VALUES (1, 'AKASH', 10, 1000)
```
<img width="1055" height="281" alt="image" src="https://github.com/user-attachments/assets/2c773fd0-e6e6-4936-a3b8-146399632c2d" />


📘 Learning Outcomes

1.Ability to create and implement triggers in PostgreSQL

2.Understanding of automated calculations using triggers

3.Ability to enforce constraints dynamically

4.Understanding real-time execution of database logic
