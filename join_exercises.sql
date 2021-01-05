USE join_example_db;


#1 Select all the records from both the users and roles tables.
SELECT *
FROM users LEFT JOIN roles ON users.role_id = roles.id;  #gave 6 results that were user ids with some null roles


#2 Use join, left join and right join to combine results from the users and roles tables. 

SELECT *
FROM users RIGHT JOIN roles ON roles.id = users.role_id;  #gave 5 results, 4 roles with some null names

# JOIN (inner join)
SELECT *
FROM users JOIN roles ON users.role_id = roles.id;  #gave 5 results, 4 names, 4 roles no nulls


#3 Use count and the appropirate join type to get a list of roles along with the number of users that have the role.

SELECT roles.name AS Role, COUNT(users.name) AS Number_of_Users
FROM users RIGHT JOIN roles ON roles.id = users.role_id
GROUP BY roles.name; 
 
 -- admin 1
 -- author 1
 -- commenter 0
 -- reviewer 2
 
 
 
USE employees;

#2 Write a query that shows each department along with the name of the current manager for that department.

SELECT departments.dept_name AS "Department Name", concat(first_name," ",last_name) AS "Department Manager"
FROM departments JOIN dept_manager ON departments.dept_no = dept_manager.dept_no
JOIN employees ON employees.emp_no = dept_manager.emp_no
WHERE dept_manager.to_date>curdate()
ORDER BY "Department Name";


#3  Find the name of all departments currently managed by women

SELECT dept_name AS "Department Name", concat(first_name," ",last_name) AS "Manager Name"
FROM dept_manager JOIN employees ON dept_manager.emp_no = employees.emp_no
JOIN departments ON departments.dept_no = dept_manager.dept_no
WHERE gender = "F"
AND dept_manager.to_date>curdate()
ORDER BY dept_name;


#4 Find the current titles of employees currently working in the Customer Service department.
USE employees;

SELECT title AS "Title", COUNT(title) AS "COUNT"
FROM titles JOIN employees USING(emp_no)
JOIN dept_emp USING(emp_no)
JOIN departments USING(dept_no) 
WHERE departments.dept_name = "Customer Service"
AND dept_emp.to_date>curdate()
AND titles.to_date>curdate()
GROUP BY title;


#5 Find the current salary of all current managers


USE employees; 

SELECT dept_name AS "Department Name", concat(first_name," ",last_name) AS Name, salary AS Salary
FROM salaries JOIN employees USING(emp_no)
JOIN dept_manager USING(emp_no)
JOIN departments USING (dept_no)
WHERE salaries.to_date>curdate()
AND dept_manager.to_date>curdate()
ORDER BY dept_name;




#6 Find the number of current employees in each department.

USE employees;

SELECT dept_no, dept_name, COUNT(emp_no) AS num_employees
FROM dept_emp JOIN departments USING(dept_no)
WHERE to_date>curdate()
GROUP BY dept_no;


#7 Which department has the highest average salary?

SELECT dept_name, AVG(salary) AS average_salary
FROM salaries JOIN dept_emp USING(emp_no)
JOIN departments USING(dept_no)
WHERE salaries.to_date>curdate()
AND dept_emp.to_date>curdate()
GROUP BY dept_name
ORDER BY average_salary DESC
LIMIT 1;


#8 Who is the highest paid employee in the Marketing department?

SELECT first_name, last_name
FROM salaries JOIN employees USING(emp_no)
JOIN dept_emp USING(emp_no)
JOIN departments USING(dept_no)
WHERE dept_name="Marketing"
ORDER BY salary DESC
LIMIT 1;



#9 Which current department manager has the highest salary?

SELECT first_name, last_name, salary, dept_name
FROM salaries JOIN employees USING(emp_no)
JOIN dept_manager USING(emp_no)
JOIN departments USING(dept_no)
WHERE dept_manager.to_date>curdate()
AND salaries.to_date>curdate()
ORDER BY salary DESC
LIMIT 1;

#10 BONUS
#Find the names of all current employees, their department name, and their current manager's name 

SELECT CONCAT(first_name," ",last_name) AS "Employee Name"
			FROM dept_emp JOIN employees USING(emp_no)
			JOIN departments ON departments.dept_no = dept_emp.dept_no
			WHERE to_date>curdate()
			,
			(dept_name AS "Department Name"
			FROM dept_emp JOIN departments USING(dept_no)	
			),
			
			
# 11 BONUS
# Who is the highest paid employee within each department?
			
			
