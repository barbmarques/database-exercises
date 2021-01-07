#Create a file named temporary_tables.sql to do your work for this exercise.

#1. Using the example from the lesson, re-create the employees_with_departments table.

USE easley_1263;

CREATE TEMPORARY TABLE employees_with_departments AS(
		SELECT emp_no, first_name, last_name, dept_no, dept_name
		FROM employees.employees 
		JOIN employees.dept_emp USING(emp_no)
		JOIN employees.departments USING(dept_no)
		LIMIT 100);
		
SELECT *
FROM employees_with_departments;

#1a. Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns


SELECT (length(employees.first_name) + length(employees.last_name) FROM employees.employees;

ALTER TABLE employees_with_departments 
		ADD full_name 
		VARCHAR(31);

select *
from employees_with_departments;

#1b. Update the table so that the full name column contains the correct data.

UPDATE employees_with_departments
SET full_name = CONCAT(first_name," ",last_name);

SELECT *
FROM employees_with_departments;


#1c. Remove the first_name and last_name columns from the table.


ALTER TABLE employees_with_departments 
		DROP first_name;
		
		

ALTER TABLE employees_with_departments 
		DROP last_name;
SELECT *
FROM employees_with_departments;
		
		
#1d. What is another way you could have ended up with this same table?

CREATE TEMPORARY TABLE ewd AS(
		SELECT emp_no, CONCAT(first_name," ",last_name) AS full_name, dept_no, dept_name
		FROM employees.employees 
		JOIN employees.dept_emp USING(emp_no)
		JOIN employees.departments USING(dept_no)
		LIMIT 100);


SELECT *
FROM ewd;
		
#2. Create a temporary table based on the payment table from the sakila database.

SELECT *
FROM sakila.payment;

CREATE TEMPORARY TABLE payment AS(
		SELECT *
		FROM sakila.payment);
		
SELECT *
FROM payment;

#2b.  Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.

UPDATE payment 
SET AMOUNT = AMOUNT * 100;

ALTER TABLE payment 
MODIFY amount INT;

SELECT *
FROM payment;

#3  Find out how the current average pay in each department compares to the overall, historical average pay. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department right now to work for? The worst?


Use easley_1263;
#Table 1
CREATE TEMPORARY TABLE avg_hist11 AS (
        SELECT round(avg(salaries.salary), 2) as "avg_hist_salary", departments.dept_name
        FROM employees.salaries
        JOIN employees.dept_emp USING(emp_no)
        join employees.departments using(dept_no)
        group by dept_name);
        
Select *
from avg_hist11;

#Table 2        
CREATE TEMPORARY TABLE avg_curr1 AS (
        SELECT round(avg(salaries.salary), 2) as "avg_curr_salary", departments.dept_name
        FROM employees.salaries
        JOIN employees.dept_emp USING(emp_no)
        join employees.departments using(dept_no)
        where employees.salaries.to_date > curdate()
        group by dept_name);
        
        
Select *
from avg_curr1; 

#Table 3
CREATE TEMPORARY TABLE overall_hist_avg1 AS (
        SELECT round(avg(salaries.salary), 2) as "overall_hist_avg"
        FROM employees.salaries);
select * 
from overall_hist_avg1;
# We use Inner join to join each temp table (avg_curr and avg_hist)
select avg_hist11.*, avg_curr1.*
from avg_hist11
inner join avg_curr1 on avg_hist11.dept_name = avg_curr1.dept_name;
#Table 4 create a table called combined averages.
CREATE TEMPORARY TABLE comb_avg AS (
    select avg_hist11.*, avg_curr1.avg_curr_salary
    from avg_hist11
    right join avg_curr1 on avg_hist11.dept_name = avg_curr1.dept_name);
    
select * 
from comb_avg;
# Use alter table
Alter table comb_avg add z_score decimal(9, 2);
select * 
from comb_avg;
#create final table
CREATE TEMPORARY TABLE final AS (
    select overall_hist_avg1.*, comb_avg.*
    from comb_avg
    cross join overall_hist_avg1);
    
select *
from final;
Alter table final add STDDEV1 decimal(9, 2);
select *
from final;
#~~~~~~~~~~~~~
Update final 
set STDDEV1 = (overall_hist_avg - avg_curr_salary)/STDDEV;
select *
from final;
#~~~~~~~~~~~~~~
select round(STDDEV(avg_curr_salary), 2)
from final;
#8034.52
#~~~~~~~~~~~~~~~~~~~~~
Alter table final add x_mean decimal(9, 2);
select *
from final;
#~~~~~~~~~~~~~~~~~~~~~~~~~
update final
set x_mean = (avg_curr_salary - overall_hist_avg);
select *
from final;
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
update final
set z_score = x_mean/8034.52;
select *
from final;
alter table final drop STDDEV1;
select *
from final;
#final output
select *
from final
order by z_score DESC;



















