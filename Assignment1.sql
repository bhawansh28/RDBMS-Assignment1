--Assignment-1 SQL

-- Task 1: Create tables with primary key
CREATE TABLE departments (
    dept_id SERIAL PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL
);

CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_id INT,
    salary NUMERIC(10,2)
);

-- Task 2: Add foreign key constraint
ALTER TABLE employees
ADD CONSTRAINT fk_department
FOREIGN KEY (dept_id)
REFERENCES departments(dept_id);

-- Task 3: Add unique constraint
ALTER TABLE employees
ADD CONSTRAINT unique_emp_name
UNIQUE(emp_name);

-- Task 4: Add index to salary column
CREATE INDEX idx_salary ON employees(salary);

-- Task 5: Insert data into tables
INSERT INTO departments (dept_name) VALUES
('HR'), ('Finance'), ('IT'), ('Marketing');

INSERT INTO employees (emp_name, dept_id, salary) VALUES
('Alice', 1, 50000),
('Bob', 2, 60000),
('Charlie', 3, 70000),
('David', 3, 75000),
('Eve', 4, 55000);

-- Task 6: SELECT with WHERE, NOT IN, LIKE, ORDER BY
SELECT * 
FROM employees
WHERE salary > 55000
  AND dept_id NOT IN (4)
  AND emp_name LIKE 'C%'
ORDER BY salary DESC;

-- Task 7: SELECT with GROUP BY, HAVING, COUNT, SUM
SELECT dept_id, COUNT(*) AS total_employees, SUM(salary) AS total_salary
FROM employees
GROUP BY dept_id
HAVING COUNT(*) > 1;

-- Task 8: INNER JOIN employees and departments
SELECT e.emp_name, d.dept_name, e.salary
FROM employees e
INNER JOIN departments d
ON e.dept_id = d.dept_id;

-- Task 9: LEFT JOIN employees and departments
SELECT e.emp_name, d.dept_name, e.salary
FROM employees e
LEFT JOIN departments d
ON e.dept_id = d.dept_id;

-- Task 10: INSERT and UPDATE with COMMIT and ROLLBACK

-- Start transaction
BEGIN;

-- Insert new employees
INSERT INTO employees (emp_name, dept_id, salary) VALUES
('Frank', 1, 52000),
('Grace', 2, 61000),
('Hannah', 3, 72000);

-- Update salaries
UPDATE employees SET salary = salary + 5000 WHERE emp_name = 'Alice';
UPDATE employees SET salary = salary + 3000 WHERE emp_name = 'Bob';

-- Rollback transaction (undo changes)
ROLLBACK;

-- Start another transaction
BEGIN;

-- Insert employees
INSERT INTO employees (emp_name, dept_id, salary) VALUES
('Frank', 1, 52000),
('Grace', 2, 61000);

-- Update salary
UPDATE employees SET salary = salary + 5000 WHERE emp_name = 'Alice';

-- Commit transaction (save changes)
COMMIT;
