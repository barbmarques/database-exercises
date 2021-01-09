#  Extra MySQL Exercises

# 1. How much do the current managers of each department get paid, relative to the average salary for the department? Is there any department where the department manager gets paid less than the average salary?

USE easley_1263;

CREATE TABLE Manager_Salaries as(
	SELECT dept_name, salary as Manager_Salary 
		FROM employees.salaries
			JOIN employees.dept_manager USING(emp_no)
			JOIN employees.departments USING(dept_no)
	WHERE emp_no IN 
			(select emp_no from employees.dept_manager
				WHERE employees.dept_manager.to_date>curdate()
				AND employees.salaries.to_date>curdate())
	GROUP BY dept_name, salary);

SELECT *
FROM Manager_Salaries;

SELECT dept_name, truncate(AVG(salary),0) as Average_Dept_Salary, Manager_Salary
FROM employees.salaries 
	JOIN employees.dept_manager USING(emp_no)
	JOIN employees.departments USING(dept_no)
	JOIN Manager_Salaries USING(dept_name)
GROUP BY dept_name, Manager_Salary;

# dept_name					Average_Dept_Salary	Manager_Salary
# Customer Service		54959							58745
# Development				59658							74510
# Finance						70815							83457
# Human Resources		58286							65400
# Marketing					88371							106491
# Production				56233							56654
# Quality Management	67130							72876
# Research					77535							79393
# Sales							85738							101987

# All department managers are paid more than their department's average salary


# ~~~~~~~~~~~~~~~~~~~~~~

# Using the WORLD DATABASE

# What languages are spoken in Santa Monica?

USE world;

SELECT *
FROM city;  #ID, Name, CountryCode, District, Population

SELECT * 
FROM country; #Code, Name, Continent, Region, SurfaceAre, IndepYear, Population, LifeExpectancy, GNP, GNPOId, LocalName, GovernmentForm, HeadOfState, Capital, Code2

SELECT * 
FROM countrylanguage; #CountryCode, Language, IsOfficial, Percentage

SELECT Language, Percentage
FROM countrylanguage
	JOIN city USING(CountryCode)
WHERE Name = 'Santa Monica'
ORDER BY Percentage ASC;


# ~~~~~~~~~~~~~~~~~~~~~~~~~~
# How many different countries are in each region?

USE world;

SELECT *
FROM city;  #ID, Name, CountryCode, District, Population

SELECT * 
FROM country; #Code, Name, Continent, Region, SurfaceAre, IndepYear, Population, LifeExpectancy, GNP, GNPOId, LocalName, GovernmentForm, HeadOfState, Capital, Code2

SELECT * 
FROM countrylanguage; #CountryCode, Language, IsOfficial, Percentage


SELECT Region, Count(Name)
FROM country
GROUP BY Region
ORDER BY Count(Name) ASC;

# ~~~~~~~~~~~~~~~~~~~~~~~~~~
# What is the population for each region?

USE world;

SELECT * 
FROM country; #Code, Name, Continent, Region, SurfaceAre, IndepYear, Population, LifeExpectancy, GNP, GNPOId, LocalName, GovernmentForm, HeadOfState, Capital, Code2

SELECT Region, SUM(population)
FROM country
GROUP BY Region
ORDER BY SUM(Population) DESC;  #returns 25 rows, beginning with largest population


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~
# What is the population for each continent?

SELECT Continent, SUM(population)
FROM country
GROUP BY Continent
ORDER BY SUM(Population) DESC;


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~
# What is the average life expectancy globally?

SELECT * 
FROM country; #Code, Name, Continent, Region, SurfaceAre, IndepYear, Population, LifeExpectancy, GNP, GNPOId, LocalName, GovernmentForm, HeadOfState, Capital, Code2


SELECT AVG(LifeExpectancy)
FROM country;  #66.48604


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~
# What is the average life expectancy for each region, each continent? Sort the results from shortest to longest.


# BY CONTINENT:

SELECT Continent, AVG(LifeExpectancy) as life_expectancy
FROM country
GROUP BY continent
ORDER BY life_expectancy ASC;

# BY REGION:

SELECT Region, AVG(LifeExpectancy) as life_expectancy
FROM country
GROUP BY Region
ORDER BY life_expectancy ASC;


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~

#BONUS: Find all the countries whose local name is different from the official name.

SELECT Name, LocalName
FROM country
WHERE Name != LocalName
ORDER BY Name ASC;     #135 rows


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~

#BONUS: How many countries have a life expectancy less than x?

SELECT Name, LifeExpectancy
FROM country
WHERE LifeExpectancy<65;

# 30 - none
# 40 - 7
# 50 - 28
# 65 - 76


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~

#BONUS: What district is city x located in?

#city:ID, Name, CountryCode, District, Population

#country: Code, Name, Continent, Region, SurfaceAre, IndepYear, Population, LifeExpectancy, GNP, GNPOId, LocalName, GovernmentForm, HeadOfState, Capital, Code2


SELECT Name, District
FROM city
WHERE Name = 'Moscow';

# London - England & Ontario
# Liverpool - England
# Moscow


SELECT * 
FROM city;