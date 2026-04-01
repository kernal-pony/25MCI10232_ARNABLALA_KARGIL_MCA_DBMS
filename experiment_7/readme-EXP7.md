# **DBMS Lab – Worksheet 7**  
## **Implementation of JOINS in PostgreSQL**

---

## 👨‍🎓 **Student Details**  
**Name:** Arnab Lala  
**UID:** 25MCI10232  
**Branch:** MCA (AI & ML)  
**Semester:** Sem - 2  
**Section/Group:** MAM-1 A  
**Subject:** Technical Skills  
**Subject Code:** 25CAP-652  
**Date of Performance:** 31/03/2026  

---

## 🎯 **Aim of the Session**  
To implement different types of SQL JOIN operations in PostgreSQL to analyze relationships between multiple relational tables.

---

## 💻 **Software Requirements**
- Oracle Database Express Edition  
- PostgreSQL  
- pgAdmin  

---

## 📌 **Objectives**  
- To understand how relational tables are connected using SQL joins  
- To implement INNER, LEFT, RIGHT, and CROSS JOIN operations  
- To analyze relationships between students, courses, and departments  
- To identify unmatched records using LEFT and RIGHT JOIN  
- To explore many-to-many relationships using a junction table  
- To generate insights by combining multiple tables  

---

## 🛠️ **Practical / Experiment Steps**  
- Create tables: Students, Courses, Enrollments, Departments  
- Insert sample data  
- Perform INNER JOIN queries  
- Perform LEFT JOIN queries  
- Perform multiple JOIN operations  
- Implement CROSS JOIN  
- Analyze outputs  

---

# ⚙️ **Procedure of the Practical**

## **Step 0: Table Creation & Data Insertion**

```sql
CREATE TABLE Studentss (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    department_id INT
);

INSERT INTO Studentss VALUES 
(1, 'Arjun', 101),
(2, 'Neha', 102),
(3, 'Kabir', 103),
(4, 'Meera', NULL),
(5, 'Rohan', 101);
```
<img width="570" height="247" alt="image" src="https://github.com/user-attachments/assets/18c9cf95-e53e-48d9-a266-250695fa2239" />

```sql
CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50)
);

INSERT INTO Courses VALUES 
(201, 'Database Systems'),
(202, 'Artificial Intelligence'),
(203, 'Computer Networks'),
(204, 'Cloud Computing');
```
<img width="413" height="202" alt="image" src="https://github.com/user-attachments/assets/5040379c-8de9-4ea9-ab9d-0f0d3f56bec4" />

```sql
CREATE TABLE Enrollments (
    student_id INT,
    course_id INT,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES Studentss(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

INSERT INTO Enrollments VALUES 
(1, 201),
(1, 202),
(2, 203),
(3, 201),
(3, 204),
(5, 202);

CREATE TABLE Departmentss (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

INSERT INTO Departmentss VALUES 
(101, 'Computer Engineering'),
(102, 'Data Science'),
(103, 'Electronics & Communication'),
(104, 'Mechanical');
```

<img width="413" height="202" alt="image" src="https://github.com/user-attachments/assets/a9412f0f-dbcf-4348-ba5e-0ec9cc722819" />

Step 1: INNER JOIN – Students with Courses
```sql
SELECT s.student_name, c.course_name
FROM Studentss s
INNER JOIN Enrollments e 
ON s.student_id = e.student_id
INNER JOIN Courses c
ON c.course_id = e.course_id;
```

<img width="443" height="256" alt="image" src="https://github.com/user-attachments/assets/d48801f4-4c27-4bf5-b485-2a5c1ec36b89" />

Step 2: LEFT JOIN – Students Not Enrolled
```sql
SELECT s.student_name 
FROM Studentss s
LEFT JOIN Enrollments e 
ON s.student_id = e.student_id
WHERE e.course_id IS NULL;
```
<img width="330" height="110" alt="image" src="https://github.com/user-attachments/assets/b6143ff4-9121-4d8f-9b59-30fd263f7ad8" />

Step 3: Courses with/without Students
```sql
SELECT DISTINCT c.course_name
FROM Courses c
JOIN Enrollments e
ON c.course_id = e.course_id;
```
<img width="245" height="192" alt="image" src="https://github.com/user-attachments/assets/2bc391b4-ccd8-450a-9be0-efe2cefee8a1" />

Step 4: Students with Department Info
```sql 
SELECT s.student_name, d.department_id, d.department_name
FROM Studentss s
JOIN Departmentss d
ON s.department_id = d.department_id;
```
<img width="578" height="171" alt="image" src="https://github.com/user-attachments/assets/226bea14-422d-40de-8bdc-1afd37e981e8" />

Step 5: CROSS JOIN – All Combinations
```sql 
SELECT s.student_name, c.course_name
FROM Studentss s
CROSS JOIN Courses c;
```
<img width="500" height="408" alt="image" src="https://github.com/user-attachments/assets/c782b817-ddee-4d67-a2a9-eb214c710066" />

📘 Learning Outcomes

1.Ability to use different types of JOINs effectively

2.Understanding of relational database connections

3.Ability to identify one-to-many and many-to-many relationships

4.Skill in retrieving matching and non-matching data

5.Improved SQL query writing for real-world applications

