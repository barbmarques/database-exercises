#1Create a new SQL script named limit_exercises.sql.

use employees;
select database ();


#2. List the first 10 DISTINCT last name sorted in descending order. 

SELECT DISTINCT `last_name`
FROM employees
ORDER BY last_name DESC
LIMIT 10;  # Zykh, Zyda, Zwicker, Zweizig, Zumaque, Zulner, Zucker, Zuberek, Zschoche, Zongker


#3. Find all previous or current employees hired in the 90s and born on Christmas. Find the first 5 employees hired in the 90's by sorting by hire date and limiting your results to the first 5 records. Write a comment in your code that lists the five names of the employees returned.

SELECT *
FROM employees
WHERE 
	hire_date LIKE '199%'
	AND
	birth_date LIKE '%12-25'
ORDER BY hire_date
LIMIT 5;  #Alselm Cappello, Utz Mandell, Bouchung Schreiter, Baocai Kushner, Petter Stroustrup


#4. Try to think of your results as batches, sets, or pages. The first five results are your first page. The five after that would be your second page, etc. Update the query to find the tenth page of results.

SELECT *
FROM employees
WHERE 
	hire_date LIKE '199%'
	AND
	birth_date LIKE '%12-25'
ORDER BY hire_date
LIMIT 5 OFFSET 45;  #offset = page - 1 times limit
					# Pranay Narwekar, Marjo Farrow, Ennio Karcich, Dines Lubachevsky, Ipke Fontan


