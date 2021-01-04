#1. Create a new file named order_by_exercises.sql and copy in the contents of your exercise from the previous lesson.

use employees;
SELECT database();

#2. Write a query to to find all current employees whose last name starts and ends with 'E'. Use concat() to combine their first and last name together as a single column named full_name.

select concat(first_name,' ',last_name) as full_name
from employees
where last_name LIKE 'e%e';

#3 Convert the names produced in your last query to all uppercase.
select upper(concat(first_name,' ',last_name)) as full_name
from employees
where last_name LIKE 'e%e';

#4 Find all previous employees hired in the 90s and born on Christmas. Use datediff() function to find how many days they have been working at the company (Hint: You will also need to use NOW() or CURDATE()),

select datediff(NOW(), hire_date) as How_Many_Days_at_Company
from employees
where hire_date LIKE '199%' 
AND birth_date LIKE "%12-25";

#5. Find the smallest and largest current salary from the salaries table

SELECT min(salary) AS MIN_CURRENT_SALARY
FROM salaries
WHERE to_date > CURDATE();  #. $38,623


SELECT max(salary) AS MAX_CURRENT_SALARY
FROM salaries
WHERE to_date > CURDATE();  #. $158,220


#6: A username should be all lowercase, and consist of the first character of the employees first name, the first 4 characters of the employees last name, an underscore, the month the employee was born, and the last two digits of the year that they were born. Below is an example of what the first 10 rows will look like:

use employees;
SELECT LOWER(CONCAT(SUBSTR(first_name,1,1),substr(last_name,1,4),"_",substr(birth_date,6,2),substr(birth_date,3,2))) AS username, first_name, last_name, birth_date
FROM employees
limit 10;







