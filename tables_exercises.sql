#Use the employees database

USE employees;

#List all the tables in the database.

SHOW tables;

SHOW CREATE TABLE employees;

#What different data types are present:  INT, DATE, VARCHAR, ENUM

#Numeric type columns: emp_no

#String type columns: first_name, last_name, gender

#Date type columns: birth_date, hire_date

#What is the relationship between the employees and departments tables?  They are siblings

SHOW CREATE TABLE dept_manager;