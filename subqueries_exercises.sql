#1 Find all the current employees with the same hire date as employee 101010 using a sub-query.

USE employees;

SELECT CONCAT(first_name," ",last_name), hire_date
FROM employees
WHERE hire_date = (
		SELECT hire_date
		FROM employees
		WHERE emp_no = 101010);    #69 employees hired 1990-10-22
		
		
#2 Find all the titles ever held by all current employees with the first name Aamod.

USE employees;

SELECT title, first_name
FROM title
WHERE first_name="Aamod"
AND dept_emp.to_date>curdate()
GROUP BY title;    

   -- 6 different titles. (Assistant Engineer, Engineer, Senior Engineer, Senior Staff, Staff, Technique Leader

SELECT title, first_name
FROM employees 
JOIN dept_emp USING(emp_no)
JOIN titles USING(emp_no)
WHERE first_name IN(
		SELECT first_name 
		FROM employees 
		WHERE first_name="Aamod"
AND dept_emp.to_date>curdate())
GROUP BY title;   



#3 How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.

SELECT COUNT(emp_no) 
FROM dept_emp 
WHERE to_date IN (
	SELECT to_date 
	from dept_emp 
	WHERE to_date<curdate())
OR to_date IN (
	SELECT to_date from dept_manager WHERE to_date<curdate());

	--  91,479 employees


#4 Find all the current department managers that are female. List their names in a comment in your code.

SELECT CONCAT(first_name," ", last_name) AS "Female Department Managers"
FROM employees
WHERE emp_no in(
		SELECT emp_no
		FROM dept_manager
		WHERE to_date>curdate())
AND gender="F";     

		-- Isamu Legleitner
		-- Leon DasSarma
		-- Karsten Sigstam
		-- Hilary Kambil
		

#5 Find all the employees who currently have a higher salary than the companies overall, historical average salary.

#63810.74;

SELECT CONCAT(first_name," ", last_name) AS "Employee",Salary
FROM salaries 
JOIN employees USING(emp_no)
WHERE salary > (
		SELECT AVG(salary) 
		from salaries)
AND salaries.to_date>curdate()
ORDER BY SALARY ASC;

  -- 154,543


#6 How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?

 -- highest current salary is 158,220

Select Max(salary)
from salaries 
where to_date>curdate();


SELECT COUNT(salary)
from salaries
WHERE salary > (SELECT max(salary)-STDDEV(salary) FROM salaries WHERE to_date>curdate())
AND to_date>curdate();



SELECT COUNT(SALARY)
FROM salaries
WHERE to_date>curdate();


SELECT
(SELECT COUNT(salary)
from salaries
WHERE salary > (SELECT max(salary)-STDDEV(salary) FROM salaries WHERE to_date>curdate())
AND to_date>curdate()
/
SELECT COUNT(salary)
FROM salaries
WHERE to_date>curdate()
*100);


#BONUS

#Find all the department names that currently have female managers.

Find the first and last name of the employee with the highest salary.

Find the department name that the employee with the highest salary works in.