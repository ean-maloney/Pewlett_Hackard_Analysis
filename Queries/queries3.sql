--Sales and development retirees
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	d.dept_name
FROM retirement_info as ri
INNER JOIN dept_emp as de
	ON ri.emp_no = de.emp_no
INNER JOIN departments as d
	ON de.dept_no = d.dept_no
WHERE de.dept_no IN ('d007', 'd005');