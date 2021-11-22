-- Use Dictinct with Orderby to remove duplicate rows



-- Employees who have been born between January 1st, 1952 and December 31st, 1955
SELECT e.emp_no,
	   e.first_name,
	   e.last_name,
	   tl.title,
	   tl.from_date,
	   tl.to_date
INTO retire_employees	   
FROM employees as e
INNER JOIN  titles as tl
ON (e.emp_no = tl.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no; 

-- Count the 133,776 rows form retire_employees
SELECT * FROM retire_employees;
SELECT COUNT(last_name) from retiremeretire_employees; 

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title
INTO retirement_employees_unique
FROM retire_employees as rt
ORDER BY rt.emp_no, rt.to_date DESC;


-- Count the 90,398 rows form retirement_employees_unique
-- we check this just to be sure there is uniques of all data
SELECT COUNT(last_name) from retirement_employees_unique; 

-- Create a table resume count group by titles name
SELECT COUNT(rut.title), rut.title
INTO retiring_titles
FROM retirement_employees_unique as rut
GROUP BY rut.title
ORDER BY COUNT(rut.title) DESC;

-- Count the 90,398 rows form retiring_titles;
SELECT * FROM retiring_titles;
SELECT SUM(count) from retiring_titles; 

-- Create a table for the eligibilty employees for mentorship
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	tl.title
INTO mentorship
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as tl
ON (e.emp_no = tl.emp_no)
WHERE (de.to_date = '9999-01-01')
	AND(e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;


SELECT * FROM mentorship;
SELECT COUNT(last_name) from mentorship; 

-- Create a table for the employees who will retire by department and title
SELECT count(e.first_name),
	d.dept_name,
	tl.title
INTO retirement_resume_dept_title
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)
INNER JOIN retirement_employees_unique as tl
ON (e.emp_no = tl.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01')
GROUP by (d.dept_no,tl.title)
ORDER BY (d.dept_no, tl.title);