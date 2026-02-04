# Experiment 4

## Aim / Overview of the Practical   
To understand and implement iterative control structures in PostgreSQL conceptually, including FOR loops, WHILE loops, and basic LOOP constructs, for repeated execution of database logic.

## Objective of the Session
-	To understand why iteration is required in database programming
-	To learn the purpose and behavior of FOR, WHILE, and LOOP constructs
-	To understand how repeated data processing is handled in databases
-	To relate loop concepts to real-world batch processing scenarios
-	To strengthen conceptual knowledge of procedural SQL used in enterprise systems

## S/W Requirement 
- PostgreSQL

## Theory
In database applications, some tasks must be repeated on multiple records, such as updating marks, checking attendance, or generating results. While SQL handles single queries well, repeated logic needs procedural control.
PostgreSQL provides PL/pgSQL, which supports loop structures to execute statements multiple times based on conditions.
These loops are commonly used inside:
•	Functions
•	Stored procedures
•	Anonymous blocks (DO $$)


## Types of Loops in PostgreSQL
### FOR Loop (Range-Based)
-	Executes a fixed number of times
-	Useful when the number of iterations is known in advance
-	Commonly used for counters, testing, and batch execution
### FOR Loop (Query-Based)
-	Iterates over rows returned by a query
-	Processes one row at a time
-	Frequently used for reporting, audits, and row-wise calculations
### WHILE Loop
-	Executes repeatedly as long as a condition remains true
-	Suitable for condition-controlled execution
-	Often used in retry logic or threshold-based processing
### LOOP with EXIT Condition
-	Executes indefinitely until explicitly stopped
-	Provides maximum control over execution flow
-	Used in complex workflows where exit conditions are custom-defined


## Experiment Steps

### Example 1: FOR Loop – Simple Iteration
-	The loop runs a fixed number of times
-	Each iteration represents one execution cycle
-	Useful for understanding basic loop behavior
Application: Counters, repeated tasks, batch execution

### Example 2: FOR Loop with Query (Row-by-Row Processing)
-	The loop processes database records one at a time
-	Each iteration handles a single row
-	Simulates cursor-based processing
Application: Employee reports, audits, data verification

### Example 3: WHILE Loop – Conditional Iteration
-	The loop runs until a condition becomes false
-	Execution depends entirely on the condition
-	The condition is checked before every iteration
Application: Retry mechanisms, validation loops

### Example 4: LOOP with EXIT WHEN
-	The loop does not stop automatically
-	An explicit exit condition controls termination
-	Gives flexibility in complex logic
Application: Workflow engines, complex decision cycles

### Example 5: Salary Increment Using FOR Loop
-	Employee records are processed one by one
-	Salary values are updated iteratively
-	Represents real-world payroll processing
Application: Payroll systems, bulk updates

### Example 6: Combining LOOP with IF Condition
-	Loop processes each record
-	Conditional logic classifies data during iteration
-	Demonstrates decision-making inside loops
Application: Employee grading, alerts, categorization logic

## RESULT:
This experiment helps students understand how iterative control structures work in PostgreSQL at a conceptual level. Students learn where and why loops are used in database systems and gain foundational knowledge required for writing procedural logic in enterprise-grade applications.

## Learning Outcome
- Understand the need for iteration in database programming
- Learn the use of FOR, WHILE, and LOOP constructs in PostgreSQL
- Perform row-by-row processing using query-based FOR loops
- Use RECORD and scalar variables correctly in loops
- Apply conditional logic inside loops
- Execute batch operations such as salary updates
- Understand control flow using EXIT conditions
- Gain basic proficiency in PL/pgSQL programming

## Screenshots
### students  TABLE
<img width="577" height="263" alt="image" src="https://github.com/user-attachments/assets/017caafe-9b7a-491d-a502-753a10952b03" />


### EXAMPLE 1: For loop (Simple Iteration)
<img width="458" height="226" alt="image" src="https://github.com/user-attachments/assets/cc0ea0e3-1cad-48b9-ba49-5526954a6578" />


### Example 2: For loop with query(Row-by-Row processing)
<img width="470" height="201" alt="image" src="https://github.com/user-attachments/assets/df197637-e34f-40f8-8fa9-bcdc64a70cc5" />


### Example 3 : While LOOP - Conditional Iteration
<img width="442" height="169" alt="image" src="https://github.com/user-attachments/assets/fe415fa3-bb18-4dc2-adb1-941bf364e2ea" />


### Example 4 : LOOP with EXIT WHEN
<img width="363" height="245" alt="image" src="https://github.com/user-attachments/assets/e2f5c877-161d-45cd-ac08-b3c2152f8c44" />

### Example 5: Salary increment Using For LOOP
<img width="678" height="133" alt="image" src="https://github.com/user-attachments/assets/f06a42fd-00b0-42d4-8cbb-bda5d291ecdd" />

- Salary increased by 5000 for each employee

### Example 6: Combining LOOP and IF Condition	
<img width="655" height="244" alt="image" src="https://github.com/user-attachments/assets/d6e5101b-86c2-4723-b97c-7ac35c908167" />
