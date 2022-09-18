use employees;

desc employees;

show tables;

select dept_no from departments;

-- Show the list of employees with first name is 'Elvis'

SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Elvis';
# 246 Rows 

-- Show the list of employees with first name as 'Kellie' and gender 'F'

select * from employees
WHERE gender = 'F' and first_name = 'Kellie';
# 86 Rows

-- Show the list of employees with first name as 'Kellie' or 'Aruna'

select * from employees
WHERE first_name = 'Kellie' OR first_name = 'Aruna';
# Here males are also included
# 432 rows

-- Show the list of employees with first name as 'Kellie' or 'Aruna' along with gender 'F'

select * from employees
where gender = 'F' and (first_name = 'Kellie' or first_name = 'Aruna');
# 167 rows

# AND > OR
-- Show the list of employees with last name as 'Denis' and gender 'M' or 'F'

select * from employees
WHERE last_name = 'Denis' and (gender = 'M' or gender = 'F');
# 165 rows

-- Show the list of employees with first name as 'Denis' and 'Elvis'

select * from employees
WHERE first_name in ('Denis', 'Elvis');
# 478 rows

-- Show the list of employees with EXCLUDING the fist name 'John', 'mark', 'jacob'

SELECT 
    *
FROM
    employees
WHERE
    first_name NOT IN ('john' , 'mark', 'jacob');
# 299794 rows

SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('Mark%%');
# 690 rows

SELECT 
    *
FROM
    employees
WHERE
    hire_date LIKE ('%2000%');

SELECT 
    *
FROM
    employees
WHERE
    emp_no LIKE ('1000_');
# 9 rows 

SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('%jack%');
# 256 rows

SELECT 
    *
FROM
    employees
WHERE
    first_name NOT LIKE ('%jack%');
# 299796 rows;

-- Show the list of employee with salary between 69000 and 70000

SELECT 
    *
FROM
    employees
WHERE
    salary BETWEEN 69000 AND 70000;
# 17519 rows

SELECT 
    *
FROM
    salaries
WHERE
    emp_no NOT BETWEEN '10000' AND '80000';
# 302644 rows

SELECT 
    *
FROM
    departments
WHERE
    dept_no BETWEEN 'd003' AND 'd006';
# 4 rows 

SELECT 
    *
FROM
    departments
WHERE
    dept_no IS NOT NULL;
# 9 rows

SELECT 
    *
FROM
    employees
WHERE
    gender = 'F'
        AND hire_date >= '2000-01-01';
# 7 rows

SELECT 
    *
FROM
    salaries
WHERE
    salary >= 150000;
# 16 rows

SELECT DISTINCT
    hire_date
FROM
    employees
LIMIT 5000;

SELECT DISTINCT
    hire_date
FROM
    employees;
# 5435 rows

select * from emp_manager;

SELECT 
    COUNT(*)
FROM
    salaries
WHERE
    salary >= 100000;
# 32207

SELECT 
    COUNT(*)
FROM
    dept_manager;
# 24

SELECT 
    *
FROM
    employees
ORDER BY hire_date DESC;

SELECT 
    salary, COUNT(emp_no) AS emp_with_same_salary
FROM
    salaries
WHERE
    salary > 80000
GROUP BY salary
ORDER BY salary;
# 36617 rows

SELECT 
    COUNT(*)
FROM
    salaries
WHERE
    salary = '80001';
# 12

SELECT 
    *, AVG(salary)
FROM
    salaries
WHERE
    salary > 120000
GROUP BY emp_no
ORDER BY AVG(salary) DESC;
# 807 rows

SELECT 
    *, AVG(salary)
FROM
    salaries
WHERE
    salary > 120000
GROUP BY emp_no
HAVING AVG(salary) > 120000;
# 807 rows

SELECT 
    emp_no
FROM
    dept_emp
WHERE
    from_date > '2000-01-01'
GROUP BY emp_no
HAVING COUNT(from_date) > 1
ORDER BY emp_no;
# 196 rows

SELECT 
    *
FROM
    dept_emp
LIMIT 100;

Insert into employees
values ( 999903, '1977-09-04', 'Sagar', 'K', 'M', '1999-01-01');

SELECT 
    *
FROM
    dept_emp
ORDER BY emp_no DESC
LIMIT 10;

insert into dept_emp Values
( 999903, 'd005', '1997-01-01', '9999-01-01');

# check is it added in dept_emp table

select * from departments limit 10;

insert into departments values ('d010', 'Business Analysis');

# check d010 is added in dept.

select * from departments;

UPDATE departments 
SET 
    dept_name = 'data analysis'
WHERE
    dept_no = 'd010';

select * from departments limit 10;

DELETE FROM departments 
WHERE
    dept_no = 'd010';

select * from departments limit 10;

select * from dept_emp;

SELECT 
    COUNT(DISTINCT dept_no) AS Total_Dept
FROM
    dept_emp;
# 9

SELECT 
    SUM(salary)
FROM
    salaries
WHERE
    from_date > '1997-01-01';

select min(emp_no) from employees;
# 10001

select max(emp_no) from employees;
# 999904

SELECT 
    ROUND(AVG(salary), 2) AS Average_Salary
FROM
    salaries
WHERE
    from_date > '2000-02-02';
# 70365 RS

##select dept_no, dept_name coalesce(dept_no, dept_name) as dept_info 
## from dep

use employees;
CREATE VIEW v_manager_avg_salary AS
    SELECT 
        ROUNG(AVG(salary), 2)
    FROM
        salaries s
            JOIN
        dept_manager m ON s.emp_no = m.emp_no;

select * from departments;
SELECT 
    *
FROM
    dept_empcurrent_dept_emp;

select * from emp_infoemp_avg_salary;

SELECT
    dept_no,
    dept_name,
    COALESCE(dept_no, dept_name) AS dept_info
FROM
    departments
ORDER BY dept_no ASC;

CREATE TABLE departments_dup
(
    dept_no CHAR(4) NULL,
    dept_name VARCHAR(40) NULL
);

INSERT INTO departments_dup
( 	dept_no,
    dept_name
)SELECT * FROM departments;

INSERT INTO departments_dup (dept_name)
VALUES ('Public Relations');

DELETE FROM departments_dup 
WHERE
    dept_no = 'd002'; 

INSERT INTO departments_dup(dept_no) VALUES ('d010'), ('d011');

select * from employees.departments_dup;

CREATE TABLE depart_manager_dup (
    emp_no INT(11) NOT NULL,
    dept_no CHAR(4) NULL,
    from_date DATE NOT NULL,
    to_date DATE NULL
);
  
  insert into depart_manager_dup 
  select * from dept_manager;
  
  insert into depart_manager_dup(emp_no, from_date) values
   (999904, '2017-01-01'),
   (999905, '2017-01-01'),
   (999906, '2017-01-01'),
   (999907, '2017-01-01');
   
-- Inner join the employees and dept. manager table

SELECT 
    e.emp_no, dm.dept_no, e.first_name, e.last_name, e.hire_date
FROM
    employees.employees e
        JOIN
    employees.dept_manager dm ON e.emp_no = dm.emp_no;

-- LEFT JOIN the employees and dept. manager table 

SELECT 
    dm.dept_no, e.emp_no, e.first_name, e.last_name, e.hire_date
FROM
    employees.employees e
        LEFT JOIN
    employees.dept_manager dm ON e.emp_no = dm.emp_no
WHERE
    e.last_name = 'Markovitch'
ORDER BY dm.dept_no DESC , e.emp_no;


SELECT 
    *
FROM
    employees e
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE
    first_name = 'Margareta'
        AND last_name = 'Markovitch'
ORDER BY e.emp_no;


SELECT 
    *
FROM
    departments;
SELECT 
    *
FROM
    dept_manager;


SELECT 
    dm.*, d.*
FROM
    dept_manager dm
        CROSS JOIN
    departments d
WHERE
    d.dept_no = 'd009';


SELECT 
    e.*, d.*
FROM
    employees e
        CROSS JOIN
    departments d
WHERE
    e.emp_no < '10011'
ORDER BY e.emp_no , d.dept_name; 


SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    t.title,
    dm.from_date,
    d.dept_name
FROM
    employees e
        JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
        JOIN
    departments d ON d.dept_no = dm.dept_no
        JOIN
    titles t ON t.emp_no = e.emp_no
WHERE
    t.title = 'manager'
ORDER BY e.emp_no;


SELECT 
    e.gender, COUNT(dm.emp_no)
FROM
    employees e
        JOIN
    dept_manager dm ON dm.emp_no = e.emp_no
GROUP BY e.gender;


SELECT 
    *
FROM
    (SELECT 
        e.emp_no,
            e.first_name,
            e.last_name,
            NULL AS dept_no,
            NULL AS from_date
    FROM
        employees e
    WHERE
        last_name = 'Denis' UNION SELECT 
        NULL AS emp_no,
            NULL AS first_name,
            NULL AS last_name,
            dm.dept_no,
            dm.from_date
    FROM
        dept_manager dm) AS a
ORDER BY a.emp_no DESC;

-- SQL Sub Queries

SELECT 
    *
FROM
    dept_manager
WHERE
    emp_no IN (SELECT 
            emp_no
        FROM
            employees
        WHERE
            hire_date BETWEEN '1990-01-01' AND '1995-01-01');


SELECT 
    *
FROM
    employees e
WHERE
    EXISTS( SELECT 
            *
        FROM
            titles t
        WHERE
            t.emp_no = e.emp_no
                AND title = 'Assistant Engineer');

-- Create View / replace view


CREATE OR REPLACE VIEW Manager_AVG_Salary AS
    SELECT 
        s.emp_no, dm.dept_no, dm.from_date, ROUND(AVG(salary), 2)
    FROM
        salaries s
            JOIN
        dept_manager dm ON s.emp_no = dm.emp_no;

-- Create Procedure 

DELIMITER $$
CREATE PROCEDURE AVG_Salary_of_employee()
BEGIN SELECT AVG(salary) from salaries;
END$$
DELIMITER ;

CALL AVG_Salary_of_employee();
CALL employees.AVG_SALARY();


-- JOIN WITH AGGREGATE FUNCTION
SELECT 
    e.emp_no, e.gender, AVG(s.salary) AS average_salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
GROUP BY gender; 

-- CROSS JOIN THE TWO TABLES

SELECT 
    e.*, d.*
FROM
    employees e
        CROSS JOIN
    departments d
WHERE
    e.emp_no < 10011
ORDER BY e.emp_no, d.dept_name;
