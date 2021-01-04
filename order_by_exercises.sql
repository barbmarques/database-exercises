#1. Create a new file named order_by_exercises.sql and copy in the contents of your exercise from the previous lesson.

use employees;
SELECT database();

#2 Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?

select first_name, last_name
from employees
where first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name ASC;  #2a Irena Reutenauer


select first_name, last_name
from employees
where first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name DESC, emp_no DESC;  #2b. Vidya Simmen


#3 Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name and then last name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?


select first_name, last_name
from employees
where first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name ASC, last_name ASC
LIMIT 5;  #3a. Irena Acton

select first_name, last_name
from employees
where first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name DESC, last_name DESC
LIMIT 5;   #3b.  Vidya Zweizig


#4. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by last name and then first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?

select first_name, last_name
from employees
where first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY last_name ASC, first_name ASC
LIMIT 5;  #4a.  Irena Acton


select first_name, last_name
from employees
where first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY last_name DESC, first_name DESC
LIMIT 5;   #4b.  Maya Zyda


#5. Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their employee number. Enter a comment with the number of employees returned, the first employee number and their first and last name, and the last employee number with their first and last name.


select first_name, last_name, emp_no
from employees
where last_name LIKE 'e%e'
ORDER BY emp_no;  #5a 899,  100021: Ramzi Erde. 
#last line explicit instruction not necessary, because emp_no was already our primary key 

select first_name, last_name, emp_no
from employees
where last_name LIKE 'e%e'
ORDER BY emp_no DESC;  #5b 499648L. Tadahiro Erde. 

#6. Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their hire date, so that the newest employees are listed first. Enter a comment with the number of employees returned, the name of the newest employee, and the name of the oldest emmployee.

select first_name, last_name, hire_date
from employees
where last_name LIKE 'e%e'
ORDER BY hire_date DESC;  #6a. 899,  Teiji Eldridge

select first_name, last_name, hire_date
from employees
where last_name LIKE 'e%e'
ORDER BY hire_date;  #6b. Sergi Erde



#7. Find all employees hired in the 90s and born on Christmas. Sort the results so that the oldest employee who was hired last is the first result. Enter a comment with the number of employees returned, the name of the oldest employee who was hired last, and the name of the youngest emmployee who was hired first.

select first_name, last_name, hire_date, birth_date
from employees
where hire_date LIKE '199%'
	AND birth_date LIKE "%12-25"
ORDER BY birth_date ASC, hire_date DESC;  #7a. 362. Khun Bernini


select first_name, last_name, hire_date, birth_date
from employees
where hire_date LIKE '199%'
	AND birth_date LIKE "%12-25"
ORDER BY birth_date DESC, hire_date;  #7b. Douadi Pettis
