#String 

#1 
SELECT job_id, GROUP_CONCAT(employee_id, " ") AS 'Employee ID'
FROM employees
GROUP BY job_id; 

#2 
UPDATE employees SET phone_number = REPLACE (phone_number, '124', '999')
WHERE phone_number LIKE '%124%';

UPDATE employees SET phone_number = REPLACE (phone_number, '999', '124')
WHERE phone_number LIKE '%999%';

#3
SELECT * 
FROM employees
WHERE LENGTH(first_name) >= 8; 

#4 ###########################
SELECT job_id, LPAD(max_salary, 7, '0') AS 'Max Salary', 
               LPAD(min_salary, 7, '0') AS 'Min Salary'
FROM jobs; 

#5 
#UPDATE employees SET email=CONCAT(email, '@example.com'); 

#6
# hire_date format: xxxx-xx-xx
# MID(string, start_position, length)
SELECT employee_id, first_name, MID(hire_date, 6, 2) AS hire_month
FROM employees;

#7 Discard the last three characters 
# REVERSE('123'): returns '321'
# SUBSTRING: to extract a substring from a string. 
#            SUBSTRING(string, start_position, length)
SELECT employee_id, 
  REVERSE(SUBSTR(REVERSE(email), 16)) AS email_id 
FROM employees;

#8 
# BINARY: an exact *case-sensitiv* match
SELECT *  
FROM employees
WHERE first_name=BINARY UPPER(first_name) ; 

SELECT 'abc'='abc'; #Right

SELECT 'abc'='ABC'; #Right

SELECT BINARY 'abc'='abc'; #Right

SELECT BINARY 'ABC'='abc'; #Wrong 

#9 
SELECT SUBSTRING(phone_number, 9, 4)
FROM employees; 

#9 OR 
SELECT RIGHT(phone_number, 4) AS 'Phone.NO.'
FROM employees; 

#10 ###############################
SELECT location_id, street_address, 
       SUBSTRING_INDEX(street_address, ' ', -1) AS 'Last word'
FROM locations; 

#11
SELECT * 
FROM locations a
WHERE LENGTH(a.street_address) = 
  (SELECT MIN(LENGTH(b.street_address)) 
   FROM locations b);

#11 OR 
SELECT * FROM locations
WHERE LENGTH(street_address) <= (SELECT  MIN(LENGTH(street_address)) 
FROM locations);

#12 
SELECT SUBSTRING_INDEX(job_title, ' ', 1)
FROM jobs; 

#13 ########################
#INSTR returns the *location* of a substring in a string
SELECT first_name, last_name 
FROM employees 
WHERE INSTR(last_name, 'c') > 2;

#14
SELECT first_name, LENGTH(first_name)
FROM employees 
WHERE first_name LIKE 'A%'
OR first_name LIKE 'J%'
OR first_name LIKE 'M%'
ORDER BY first_name;

#15
SELECT first_name, LPAD(salary, 10, '$') AS 'Salary' 
FROM employees;

#16 ###########################
# SELECT REPEAT('A', 2) = 'AA'
# FLOOR(34.999) = 34

SELECT left(first_name, 8),
  REPEAT('$', FLOOR(salary/1000)) AS 'SALARY($)', 
  salary
FROM employees
ORDER BY salary DESC;

#17 
SELECT employee_id, first_name, last_name, hire_date
FROM employees 
WHERE MID(hire_date, 7, 1) = '7'
OR MID(hire_date, 9, 2) = '07';

SELECT employee_id, first_name, last_name, hire_date
FROM employees 
WHERE MONTH(hire_date) = 7
OR DAY(hire_date) = 7;

#17 OR
SELECT employee_id,first_name,last_name,hire_date 
FROM employees 
WHERE POSITION("07" IN DATE_FORMAT(hire_date, '%d %m %Y'))>0;


-- position ('be' in 'To be or not to be')      -- returns 4
-- position ('be', 'To be or not to be')        -- returns 4
-- position ('be', 'To be or not to be', 4)     -- returns 4
-- position ('be', 'To be or not to be', 8)     -- returns 17
-- position ('be', 'To be or not to be', 18)    -- returns 0
-- position ('be' in 'Alas, poor Yorick!')      -- returns 0










