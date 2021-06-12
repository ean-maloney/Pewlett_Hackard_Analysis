--Employee_Database_challenge

--Deliverable 1 

--Reteive cols from Employees table
SELECT e.emp_no, e.first_name, e.last_name,
	ti.title, ti.from_date, ti.to_date
INTO retirement_titles
FROM employees AS e
INNER JOIN titles AS ti
ON e.emp_no = ti.emp_no
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY emp_no;

SELECT * FROM retirement_titles

--Remove duplicate entries for previously held positions
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

SELECT * FROM unique_titles

--Get list of unique titles
SELECT DISTINCT title
FROM unique_titles;
--https://www.w3schools.com/sql/sql_distinct.asp

--Create derivative table with unique titles and 
--count of occurrences in unique_titles
DROP TABLE retiring_titles;

CREATE TABLE retiring_titles AS
SELECT DISTINCT COUNT(ut.title), ut.title 
FROM unique_titles AS ut
GROUP BY ut.title
ORDER BY COUNT(ut.title) DESC;
--https://www.w3schools.com/sql/sql_create_table.asp

SELECT * FROM retiring_titles

--Deliverable 2

SELECT DISTINCT ON(e.emp_no) e.emp_no, e.first_name, 
	e.last_name, e.birth_date,
	de.from_date, de.to_date,
	ti.title
INTO mentorship_eligibility
FROM employees AS e 
INNER JOIN dept_emp AS de
	ON e.emp_no = de.emp_no
INNER JOIN titles AS ti 
	ON e.emp_no = ti.emp_no 
WHERE de.to_date = '9999-01-01' AND 
e.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
ORDER BY e.emp_no

SELECT * FROM mentorship_eligibility

--Additional data needed
CREATE TABLE mentorship_titles AS
SELECT DISTINCT COUNT(me.title), me.title 
FROM mentorship_eligibility AS me
GROUP BY me.title
ORDER BY COUNT(me.title) DESC;
--https://www.w3schools.com/sql/sql_create_table.asp

SELECT * FROM mentorship_titles;

