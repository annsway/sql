
#### SELECT statement ####
#1
SELECT FIRST_NAME, LAST_NAME
FROM Employees;

#2
SELECT DISTINCT department_id
FROM employees; 

#3
SELECT * FROM employees 
ORDER BY FIRST_NAME DESC; 

#4
SELECT first_name, last_name, salary, 0.12*salary AS PF
FROM Employees; 

#5
SELECT employee_id, first_name, last_name, salary
FROM employees
ORDER BY salary; 

#6
SELECT SUM(salary)
FROM employees; 

#7 
SELECT MAX(Salary), MIN(Salary)
FROM employees; 

#8 
SELECT AVG(Salary), COUNT(*)
FROM employees; 

#9 
SELECT COUNT(*)
FROM employees; 

#10 #################################
SELECT COUNT(DISTINCT JOB_ID)
FROM employees;

#11 #################################
SELECT UPPER(first_name)
FROM employees; 

#12 #################################
SELECT SUBSTRING(first_name, 1,3)
FROM employees; 

#13 #################################
SELECT 171*214+625 RESULT; 

#14 #################################
SELECT CONCAT(first_name, " ", last_name) 'Employee Name'
FROM employees; 

#15 #################################
SELECT TRIM(first_name)
FROM employees; 

#16
SELECT first_name, last_name, LENGTH(first_name)+LENGTH(last_name) 'Length of Name'
FROM employees; 

#17 ?????????????????????????????????
SELECT * FROM employees
WHERE first_name REGEXP '[0-9]'; 

#18 ################################# 
SELECT employee_id, first_name
FROM employees
LIMIT 10; 

#19
SELECT first_name, last_name, ROUND(Salary/12, 2) 'MonthlySalary'
FROM employees; 













