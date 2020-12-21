#1. Create a new file named group_by_exercises.sql
#2. In your script, use DISTINCT to find the unique titles in the titles table. How many unique titles have there ever been? 

use employees;
select database();

SELECT DISTINCT title
FROM titles;      #2. There are 7 unique titles in the titles table



#3. Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.

SELECT last_name
FROM employees
WHERE last_name LIKE 'e%e'
GROUP BY last_name;    #3 Eldridge, Erbe, Erde, Erie, Etalle


#4 Write a query to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.

SELECT DISTINCT concat(first_name, ' ', last_name)
FROM employees
WHERE last_name LIKE 'e%e';  #4 846 unique combinations



#5. Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.

SELECT last_name
FROM employees
WHERE last_name LIKE '%q%'
	AND last_name NOT LIKE '%qu%'
GROUP BY last_name;  # Chleq, Lindqvist, Qiwen
	
	
	
#6. Add a COUNT() to your results (the query above) and use ORDER BY to make it easier to find employees whose unusual name is shared with others.

SELECT last_name, COUNT(*)
FROM employees
WHERE last_name LIKE '%q%'
	AND last_name NOT LIKE '%qu%'
GROUP BY last_name;   # Chleq 189, Lindqvist 190, Qiwen 168
					  # Order by is not necessary when you use group by
					  

#7 Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.

SELECT first_name, gender, COUNT(*)
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
GROUP BY first_name, gender;


-- Irena	M	144
-- Irena	F	97
-- Maya		M	146
-- Maya		F	90
-- Vidya	M	151
-- Vidya	F	81



#8. Using your query that generates a username for all of the employees, generate a count employees for each unique username. Are there any duplicate usernames?



SELECT DISTINCT LOWER(CONCAT(SUBSTR(first_name,1,1),substr(last_name,1,4),"_",substr(birth_date,6,2),substr(birth_date,3,2))) AS username, first_name, last_name, birth_date, COUNT(*)
FROM employees
GROUP BY username, first_name, last_name, birth_date
ORDER BY count(*) desc;  #There are 300,018 user names

#BONUS:  THere are 6 duplicate user names

-- tcrom_0563	Tonny		Cromarty	1963-05-07	2
-- sghal_1263	Sarita		Ghalwash	1963-12-08	2
-- sgide_0763	Shim		Gide		1963-07-10	2
-- pgran_1156	Pintsang	Granlund	1956-11-25	2
-- pacto_0558	Pragnesh	Acton		1958-05-12	2
-- hnego_0763	Holgard		Negoita		1963-07-19	2



