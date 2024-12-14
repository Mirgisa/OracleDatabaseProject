 --1. write a SQL query to find the first name, last name, department number, and department name for each employee
 
 Select e.FIRST_NAME,
       e.LAST_NAME,
       e.DEPARTMENT_ID AS DEPARTMENT_NUMBER, d.DEPARTMENT_NAME
FROM
   EMPLOYEES e
JOIN
  DEPARTMENTS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID;
  
  --2. write a SQL query to find all departments, including those without employees. Return first name, last name,department ID, department name.
  
  SELECT d.DEPARTMENT_ID,
          d.DEPARTMENT_NAME,
         e.FIRST_NAME,
         e.LAST_NAME
FROM
       DEPARTMENTS d
LEFT JOIN 
         EMPLOYEES e ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
ORDER BY
       d.DEPARTMENT_ID,
       e.LAST_NAME;
       
--3. write a SQL query to display the department name, city, and state province for each department.

SELECT d.DEPARTMENT_NAME,
       l.CITY,
       l.STATE_PROVINCE
FROM 
    DEPARTMENTS d
JOIN 
       LOCATIONS l ON l.LOCATION_ID = d.LOCATION_ID;
       
--4. write a SQL query to calculate the average salary, the number of employees receiving commissions in that department. Return department name, average salary and number of employees.

SELECT d.DEPARTMENT_NAME,
       AVG(e.SALARY) AS AVERAGE_SALARY,
       COUNT(CASE WHEN e.COMMISSION_PCT IS NOT NULL THEN 1 END) AS NUMBER_OF_EMPOYEES
FROM
   DEPARTMENTS d
JOIN
   EMPLOYEES e ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
GROUP BY
      d.DEPARTMENT_NAME;
      
--5. write a SQL query to calculate the difference between the maximum salary and the salary of all the employees who work in the department of ID 80. Return job title, employee name and salary difference.

SELECT j.JOB_TITLE,
       e.FIRST_NAME AS EMPLOYEE_NAME,
      ( MAX(e.SALARY) OVER() - e.SALARY)AS SALARY_DIFFERENCE
FROM
   EMPLOYEES e
JOIN
    JOBS j ON e.JOB_ID = j.JOB_ID
WHERE
    e.DEPARTMENT_ID = 80;

--6. write a SQL query to find out which departments have at least two employees. Group the result set on country name and city. Return country name, city, and number.

SELECT
      c.COUNTRY_NAME,
      l.CITY
     --COUNT( e.EMPLOYEE_ID) AS NUMBER
FROM
 EMPLOYEES e
JOIN
    DEPARTMENTS d ON d.DEPARTMENT_ID = e.DEPARTMENT_ID
    
JOIN 
    LOCATIONS l ON l.LOCATION_ID = d.LOCATION_ID
JOIN
    COUNTRIES c ON c.COUNTRY_ID = l.COUNTRY_ID
GROUP BY
       c.COUNTRY_NAME,
       l.CITY
       
HAVING
      COUNT( e.EMPLOYEE_ID) >= 2;
      
--7. write a SQL query to find first and last name, job title, start and end date of last jobs of employees who did not receive commissions.

SELECT
      e.FIRST_NAME,
      e.LAST_NAME,
      j.JOB_TITLE,
      jh.START_DATE,
      jh.END_DATE
FROM
    EMPLOYEES e
JOIN
    JOB_HISTORY jh ON jh.EMPLOYEE_ID = e.EMPLOYEE_ID
JOIN
   JOBS j ON j.JOB_ID = jh.JOB_ID
WHERE e.COMMISSION_PCT IS NULL;

--8. write a SQL query to find those employees who have not had a job in the past.

SELECT *
FROM
     EMPLOYEES e
LEFT JOIN 
         JOB_HISTORY jh ON jh.EMPLOYEE_ID = e.EMPLOYEE_ID
WHERE
     jh.EMPLOYEE_ID IS NULL;
 
 --9. write a SQL query to find employees who have previously worked as 'Sales Representatives'. Return all the fields of jobs.
 
 SELECT 
    j.*
FROM 
    JOBS j
WHERE j.JOB_TITLE ='Sales Representatives';


--10.write a SQL query to find the city of the employee of ID 134. Return city.      

SELECT
     --e.FIRST_NAME,
     l.CITY
FROM
    EMPLOYEES e
JOIN
    DEPARTMENTS d ON d.DEPARTMENT_ID = e.DEPARTMENT_ID
JOIN 
    LOCATIONS l ON l.LOCATION_ID = d.LOCATION_ID
WHERE 
     e.EMPLOYEE_ID = 134;
     
--11.write a SQL query to find those employees who earn less than the average salary and work at the department where Laura (first name) is employed.
--Return first name, last name, salary, and department ID.
    
SELECT
      e.FIRST_NAME,
      e.LAST_NAME,
      e.SALARY,
      e.DEPARTMENT_ID
FROM
    EMPLOYEES e
WHERE
    e.SALARY < (
    SELECT
    AVG(SALARY)
   FROM  EMPLOYEES 
   WHERE DEPARTMENT_ID =(
   SELECT DEPARTMENT_ID
   FROM EMPLOYEES
   WHERE FIRST_NAME = 'Laura')
    )
AND
   e.DEPARTMENT_ID =(
SELECT
     DEPARTMENT_ID
FROM
   EMPLOYEES
WHERE
     FIRST_NAME ='Laura'
     );
     
--12.write a SQL query to find those employees whose salaries are less than 6000. Return first and last name, and salary.

SELECT
     e.FIRST_NAME,
     e.LAST_NAME,
     e.SALARY
FROM
    EMPLOYEES e
WHERE
     e.SALARY < 6000;
     
--13.write a SQL query to find those employees whose salary matches that of the employee who works in department ID 40. Return first name, last name, salary, and department ID.

SELECT
     e.FIRST_NAME,
     e.LAST_NAME,
     e.SALARY,
     e.DEPARTMENT_ID
FROM
    EMPLOYEES e
WHERE
    e.SALARY IN(
               SELECT SALARY
               FROM EMPLOYEES
               WHERE DEPARTMENT_ID =40);
               
--14.write a SQL query to find those employees who joined after 7th September 1987. Return all the fields.

SELECT *
FROM
    EMPLOYEES e
WHERE
     e.HIRE_DATE > TO_DATE('1987-09-07','YYYY-MM-DD');
     
--15.write a SQL query to find those employees who do not have commission percentage and have salaries between 7000, 12000 (Begin and end values are included.) and who are employed in the department number 50. 
--Return all the fields of employees.

SELECT *
FROM
   EMPLOYEES e
WHERE
     e.COMMISSION_PCT IS NULL
     AND e.SALARY BETWEEN 7000 AND 12000
     AND e.DEPARTMENT_ID = 50;