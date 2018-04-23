# Aggregate Functions & Group by 

#1 #############################
SELECT COUNT(DISTINCT job_id)
FROM employees; 

#2 
SELECT SUM(Salary)
FROM employees; 

#3
SELECT MIN(Salary)
FROM Employees; 

#4
SELECT MAX(Salary)
FROM employees
WHERE job_id='IT_PROG'; 

#5
SELECT AVG(salary) 'Average Salary', COUNT(employee_id)
FROM Employees
WHERE department_id=90; 

#6
SELECT MAX(Salary), MIN(Salary), SUM(Salary), AVG(Salary)
FROM employees; 

#6 OR
SELECT ROUND(MAX(Salary),0) 'Maximum',
       ROUND(MIN(Salary),0) 'Minimum',
       ROUND(SUM(Salary),0) 'Sum', 
       ROUND(AVG(Salary),0) 'Average'
FROM employees; 

#7
SELECT job_id, COUNT(Employee_id) 'Number of Employees'
FROM employees
GROUP BY job_id; 

#8 
SELECT MAX(salary)-MIN(salary) DIFFERENCE
FROM employees; 

#9 ###############################
SELECT Manager_id, MIN(salary) AS 'Salary of the lowest-paid employee'
FROM employees
WHERE manager_id IS NOT NULL
GROUP BY Manager_id
ORDER BY MIN(salary) DESC; 

#10 
SELECT department_id, SUM(Salary) total_salary
FROM employees
GROUP BY department_id; 

#11
SELECT Job_id, ROUND(AVG(Salary), 0) Avg_salary
FROM employees 
WHERE job_id <> 'IT_PROG'
GROUP BY job_id; 

#12
SELECT job_id, 
       SUM(salary) total_salary, 
       MAX(salary) max_salary, 
       MIN(salary) min_salary, 
       ROUND(AVG(salary), 2) avg_salary
FROM employees
WHERE department_id=90
GROUP BY job_id; 

#13 ######################
SELECT job_id, MAX(salary)
FROM employees
GROUP BY job_id
HAVING MAX(salary) >= 4000; 

#14
SELECT job_id, ROUND(AVG(salary),2), COUNT(EMPLOYEE_ID)
FROM employees
GROUP BY department_id
HAVING COUNT(EMPLOYEE_ID)>10; 

