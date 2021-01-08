
#1.  Write a query that returns all employees (emp_no), their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.

USE employees;

Select employees.emp_no, dept_emp.dept_no, employees.hire_date as start_date, salaries.to_date as end_date, salaries.to_date,
	IF(salaries.to_date>=curdate(),true,false) AS is_current_employee	
FROM employees 
	JOIN dept_emp USING(emp_no) 
	JOIN salaries USING (emp_no);
			

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



#3.  How many employees (current or previous) were born in each decade?


SELECT decade, COUNT(decade)
FROM
(SELECT 
	CASE SUBSTR(birth_date,2,2)
		WHEN '90' THEN '1900'
		WHEN '91' THEN '1910'
		WHEN '92' THEN '1920'
		WHEN '93' THEN '1930'
		WHEN '94' THEN '1940'
		WHEN '95' THEN '1950'
		WHEN '96' THEN '1960'
		WHEN '97' THEN '1970'
		WHEN '98' THEN '1980'
		WHEN '99' THEN '1990'
		WHEN '00' THEN '2000'
		WHEN '01' THEN '2010'		
		WHEN '02' THEN '2020'	
		END as decade
		FROM employees) as t1
GROUP BY decade;

/*
1950	182,886
1960	117,138
*/


SELECT birth_date,
	CASE SUBSTR(birth_date,2,2)
		WHEN '90' THEN '1900'
		WHEN '91' THEN '1910'
		WHEN '92' THEN '1920'
		WHEN '93' THEN '1930'
		WHEN '94' THEN '1940'
		WHEN '95' THEN '1950'
		WHEN '96' THEN '1960'
		WHEN '97' THEN '1970'
		WHEN '98' THEN '1980'
		WHEN '99' THEN '1990'
		WHEN '00' THEN '2000'
		WHEN '01' THEN '2010'		
		WHEN '02' THEN '2020'	
		END as decade
		FROM employees
;



#BONUS: What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?

