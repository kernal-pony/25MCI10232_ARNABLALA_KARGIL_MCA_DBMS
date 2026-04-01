CREATE TABLE Studentss (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    department_id INT
);

INSERT INTO Studentss VALUES (1, 'Arjun', 101);
INSERT INTO Studentss VALUES (2, 'Neha', 102);
INSERT INTO Studentss VALUES (3, 'Kabir', 103);
INSERT INTO Studentss VALUES (4, 'Meera', NULL);
INSERT INTO Studentss VALUES (5, 'Rohan', 101);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50)
);

INSERT INTO Courses VALUES (201, 'Database Systems');
INSERT INTO Courses VALUES (202, 'Artificial Intelligence');
INSERT INTO Courses VALUES (203, 'Computer Networks');
INSERT INTO Courses VALUES (204, 'Cloud Computing');


CREATE TABLE Enrollments (
    student_id INT,
    course_id INT,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES Studentss(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);
INSERT INTO Enrollments VALUES (1, 201);
INSERT INTO Enrollments VALUES (1, 202);
INSERT INTO Enrollments VALUES (2, 203);
INSERT INTO Enrollments VALUES (3, 201);
INSERT INTO Enrollments VALUES (3, 204);
INSERT INTO Enrollments VALUES (5, 202);


CREATE TABLE Departmentss (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);
INSERT INTO Departmentss VALUES (101, 'Computer Engineering');
INSERT INTO Departmentss VALUES (102, 'Data Science');
INSERT INTO Departmentss VALUES (103, 'Electronics & Communication');
INSERT INTO Departmentss VALUES (104, 'Mechanical');

--1. Write queries to list students with their enrolled courses (INNER JOIN).
select s.student_name , c.course_name
from Studentss s
inner join Enrollments e 
on s.student_id = e.student_id
inner join Courses c
on c.course_id = e.course_id;

--2. Find students not enrolled in any course (LEFT JOIN).
select s.student_name 
from Studentss s
left join Enrollments e 
on s.student_id = e.student_id

where e.course_id is Null;

-- 3.Display all courses with or without enrolled students 
select distinct c.course_name
from courses c
 join Enrollments e
on c.course_id= e.course_id;

--4. Show students with department info using SELF JOIN or multiple joins.
select s.student_name, d.department_id, d.department_name
from Studentss s
join Departmentss d
on s.department_id = d.department_id

-- Display all possible student-course combinations (CROSS JOIN). (Oracle, SAP, IBM, Microsoft)
select *
from Studentss cross join Courses