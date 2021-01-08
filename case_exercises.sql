
#1.  Write a query that returns all employees (emp_no), their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.

/*USE employees;

Select 
	emp_no, 
	dept_no, 
	hire_date as start_date, 
	salaries.to_date as end_date, salaries.to_date,
	IF(salaries.to_date>=curdate(),true,false) AS is_current_employee	
FROM employees 
	JOIN dept_emp USING(emp_no) 
	JOIN salaries USING (emp_no);
	
	SELECT 
		emp_no,
		MAX(to_date) as max_date
		FROM dept_emp
		
*/

SELECT
 	dept_emp.emp_no,
 	dept_no,
 	to_date,
 	from_date,
 	hire_date,
 	IF(to_date = '9999-01-01', 1, 0) AS is_current_employee,
 	IF(hire_date = from_date, 1, 0) AS only_one_dept
 FROM dept_emp
 JOIN (SELECT 
 		emp_no,
 		MAX(to_date) AS max_date
 	FROM dept_emp
 	GROUP BY emp_no) AS last_dept
 ON dept_emp.emp_no = last_dept.emp_no
 	AND dept_emp.to_date = last_dept.max_date
 JOIN employees AS e ON e.emp_no = dept_emp.emp_no;


#2.  Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.

SELECT CONCAT(first_name," ",last_name) AS "Employee Name", 
	CASE substr(last_name,1,1)
			WHEN "A" THEN "A-H"
			WHEN "B" THEN "A-H"
			WHEN "C" THEN "A-H"
			WHEN "D" THEN "A-H"
			WHEN "E" THEN "A-H"
			WHEN "F" THEN "A-H"
			WHEN "G" THEN "A-H"
			WHEN "H" THEN "A-H"
			WHEN "I" THEN "I-Q"
			WHEN "J" THEN "I-Q"
			WHEN "K" THEN "I-Q"
			WHEN "L" THEN "I-Q"
			WHEN "M" THEN "I-Q"
			WHEN "N" THEN "I-Q"
			WHEN "O" THEN "I-Q"
			WHEN "P" THEN "I-Q"
			WHEN "Q" THEN "I-Q"
			WHEN "R" THEN "R-Z"
			WHEN "S" THEN "R-Z"
			WHEN "T" THEN "R-Z"
			WHEN "U" THEN "R-Z"
			WHEN "V" THEN "R-Z"
			WHEN "W" THEN "R-Z"
			WHEN "X" THEN "R-Z"
			WHEN "Y" THEN "R-Z"
			WHEN "Z" THEN "R-Z"
			ELSE "???"				
			END AS alpha_group
FROM employees;

# MUCH BETTER WAY FOR #2^^^^^:
SELECT CONCAT(first_name," ",last_name) AS "Employee Name", 
case
	when last_name < 'I' then 'A-H'
	when last_name < 'R' then 'I-Q'
	when last_name > 'Q' then 'R-Z'	
	else null
	end as alpha_group	
from employees;



# ANOTHER WAY^^^^:
SELECT
 	CONCAT(first_name, ' ', last_name) AS employee_name,
 	CASE
 		WHEN LEFT(last_name, 1) IN('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h') THEN 'A-H'
 		WHEN LEFT(last_name, 1) IN('i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q') THEN 'I-Q'
 		ELSE 'R-Z'
 	END AS alpha_group
 FROM employees;

#3.  How many employees (current or previous) were born in each decade?


SELECT decade, COUNT(decade)
FROM
(SELECT 
	CASE SUBSTR(birth_date,2,2)
		WHEN '95' THEN '1950'
		WHEN '96' THEN '1960'
		ELSE 'YOUNG'
		END as decade
		FROM employees) as t1
GROUP BY decade;

/*
1950	182,886
1960	117,138
*/


#. ANOTHER Way:
SELECT
	CASE
		WHEN birth_date LIKE '195%' THEN '50s'
		WHEN birth_date LIKE '196%' THEN '60s'
		ELSE 'YOUNG'
	END AS decade,
	COUNT(*)
FROM employees
GROUP BY decade;


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# CASE STATEMENT BONUS

#What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?

SELECT
	CASE
		WHEN dept_name IN('Research', 'Development') THEN 'R&D'
		WHEN dept_name IN('Sales', 'Marketing') THEN 'Sales & Marketing'
		WHEN dept_name IN('Production', 'Quality Management') THEN 'QM'
		WHEN dept_name IN('Finance', 'Human Resources') THEN 'Finance & HR'
		ELSE 'Customer Service'
	END AS department_group,
	ROUND(AVG(salary), 2) AS average_salary
FROM salaries AS s
JOIN employees_with_departments AS ewd ON s.emp_no = ewd.emp_no
	AND s.to_date > CURDATE()
GROUP BY department_group;

