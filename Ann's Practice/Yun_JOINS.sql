# JOINS 

#1 
SELECT location_id, street_address, city, state_province, country_name
FROM locations 
NATURAL JOIN countries; 

#2 
SELECT first_name, last_name, employees.department_id, department_name
FROM employees
JOIN departments USING (department_id);

#3 
SELECT first_name, last_name, job_id, d.department_id, department_name
FROM employees e
JOIN departments d ON (d.department_id=e.department_id)
JOIN locations l ON (l.location_id=d.location_id)
WHERE city='London'; 

#4 ######################
SELECT a.employee_id, a.last_name, b.manager_id, b.last_name AS manager_name
FROM employees a
JOIN employees b ON (a.manager_id=b.employee_id);

#5 ######################
SELECT a.first_name, a.last_name, a.hire_date 
FROM employees a 
JOIN employees b ON (b.last_name='Jones')
WHERE a.hire_date > b.hire_date;

#6 
SELECT department_name, COUNT(employee_id) AS 'Number of employees'
FROM employees e
JOIN departments d ON (e.department_id=d.department_id)
GROUP BY e.department_id
ORDER BY department_name; 

#7 
SELECT jh.employee_id, j.job_title, DATEDIFF(end_date,start_date) AS 'Days of Employeement'
FROM jobs j
JOIN job_history jh ON (j.job_id=jh.job_id)
WHERE jh.department_id=90;

#8 
SELECT d.department_id, department_name, first_name AS 'Manager Name'
FROM employees e
JOIN departments d ON (d.manager_id=e.employee_id);

#9
SELECT department_name, first_name AS 'manager name', city
FROM employees e 
JOIN departments d ON (d.manager_id=e.employee_id)
JOIN locations l ON (d.location_id=l.location_id); 

#10 
SELECT job_title, ROUND(AVG(salary),0) AS average_salary
FROM employees e
JOIN jobs j ON (e.job_id=j.job_id)
GROUP BY job_title
ORDER BY average_salary DESC;

#11
SELECT job_title, CONCAT (first_name, " ", last_name) AS 'employee name',
       salary - min_salary AS 'Salary Difference'
FROM employees
JOIN jobs USING (job_id); 

#12
SELECT jh.* 
FROM job_history jh
JOIN employees e ON (e.employee_id=jh.employee_id)
WHERE salary > 10000;

#13
SELECT first_name, last_name,
       hire_date, salary, DATEDIFF(now(), hire_date)/365 AS "Years of Experience"
FROM employees e 
JOIN departments d ON (e.employee_id=d.manager_id)
WHERE (DATEDIFF(now(), hire_date))/365 > 15
ORDER BY hire_date ASC; 



















