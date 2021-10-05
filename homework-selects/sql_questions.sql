-- Write a query to display: 
-- 1. the first name, last name, salary, and job grade for all employees.
SELECT first_name, last_name, salary, job_title
FROM employees
    LEFT JOIN jobs USING (job_id);

-- 2. the first and last name, department, city, and state province for each employee.
SELECT first_name, last_name, department_name, city, state_province
FROM employees
	LEFT JOIN departments USING (department_id)
	LEFT JOIN locations USING (location_id);

-- 3. the first name, last name, department number and department name, for all employees for departments 80 or 40.
SELECT first_name, last_name, department_ID, department_name
FROM employees
    LEFT JOIN departments USING (department_id)
    WHERE department_id IN (80,40);

-- 4. those employees who contain a letter z to their first name and also display their last name, department, city, and state province.
SELECT first_name, last_name, department_name, city, state_province
FROM employees
    LEFT JOIN departments USING (department_id)
    LEFT JOIN locations USING (location_id)
    WHERE first_name LIKE '%z%';

-- 5. the first and last name and salary for those employees who earn less than the employee earn whose number is 182.
SELECT first_name, last_name, salary
FROM employees
    WHERE salary < (SELECT salary FROM employees WHERE employee_id = 182);

-- 6. the first name of all employees including the first name of their manager.
SELECT e.first_name AS employee, e1.first_name AS manager
FROM employees e, employees e1
    WHERE e1.employee_id = e.manager_id;

-- 7. the first name of all employees and the first name of their manager including those who does not working under any manager.
SELECT e.first_name AS employee, m.first_name AS manager
FROM employees e
    LEFT JOIN employees m
    ON e.manager_id = m.employee_id;

-- 8. the details of employees who manage a department.
SELECT *
FROM employees
    WHERE employee_id IN (SELECT manager_id FROM departments);

-- 9. the first name, last name, and department number for those employees who works in the same department as the employee who holds the last name as Taylor.
SELECT first_name, last_name, department_id
FROM employees
    WHERE department_id IN (SELECT department_id FROM employees WHERE last_name ='Taylor');

--10. the department name and number of employees in each of the departments.
SELECT d.department_name AS department, COUNT(e.employee_id) as number_of_employees
FROM departments d, employees e
        WHERE e.department_id = d.department_id
        GROUP BY d.department_name;

--11. the name of the department, average salary and number of employees working in that department who got commission.
SELECT d.department_name AS deparment, AVG(e.salary) AS average, COUNT (e.employee_id) AS number_of_employees
FROM departments d, employees e
    WHERE e.department_id = d.department_id
    AND e.commission_pct IS NOT NULL
    GROUP BY d.department_name;

--12. job title and average salary of employees.
SELECT j.job_title AS job_title, AVG(e.salary) AS average_salary
FROM jobs j, employees e
    WHERE j.job_id = e.job_id
    GROUP BY j.job_title;

--13. the country name, city, and number of those departments where at least 2 employees are working.
SELECT c.country_name, l.city, COUNT(d.department_id) AS number_of_departments
FROM countries c, locations l, departments d
    WHERE c.country_id = l.country_id
    AND l.location_id = d.location_id
    AND department_id IN (SELECT department_id FROM employees GROUP BY department_id HAVING COUNT(department_id)>=2)
    GROUP BY (c.country_name, l.city)

--14. the employee ID, job name, number of days worked in for all those jobs in department 80.
SELECT e.employee_id, j.job_title, (CURRENT_DATE - e.hire_date) AS days_worked
FROM employees e, jobs j
    WHERE e.job_id = j.job_id
    AND e.department_id = 80;

--15. the name ( first name and last name ) for those employees who gets more salary than the employee whose ID is 163.
SELECT (first_name||' '||last_name) AS name
FROM employees
    WHERE salary > (SELECT salary FROM employees WHERE employee_id = 163);

--16. the employee id, employee name (first name and last name ) for all employees who earn more than the average salary.
SELECT employee_id, (first_name||' '||last_name) AS employee_name
FROM employees
    WHERE salary > (SELECT AVG(salary) FROM employees);

--17. the employee name ( first name and last name ), employee id and salary of all employees who report to Payam.
SELECT (first_name||' '||last_name) AS employee_name, employee_id, salary
FROM employees
    WHERE manager_id = (SELECT employee_id FROM employees WHERE first_name = 'Payam');

--18. the department number, name ( first name and last name ), job and department name for all employees in the Finance department.
SELECT e.department_id, (e.first_name||' '||e.last_name) AS name, j.job_title, d.department_name
FROM employees e, jobs j, departments d
    WHERE e.department_id = d.department_id
    AND e.job_id = j.job_id
    AND e.department_id = (SELECT department_id FROM departments WHERE department_name = 'Finance');

--19. all the information of an employee whose id is any of the number 134, 159 and 183.
SELECT *
FROM employees
    WHERE employee_id IN (134,159,183);

--20. all the information of the employees whose salary is within the range of smallest salary and 2500.
SELECT *
FROM employees
    WHERE salary BETWEEN (SELECT MIN(salary) FROM employees) AND 2500;

--21. all the information of the employees who does not work in those departments where some employees works whose id within the range 100 and 200.
SELECT *
FROM employees
    WHERE department_id NOT IN (SELECT department_id FROM employees WHERE employee_id BETWEEN 100 AND 200);

--22. all the information for those employees whose id is any id who earn the second highest salary.
SELECT *
   FROM employees
   WHERE salary = (SELECT salary
                        FROM (SELECT salary, ROW_NUMBER() over (ORDER BY salary DESC) AS r_n FROM employees)
                        WHERE r_n = 2);

--23. the employee name( first name and last name ) and hiredate for all employees in the same department as Clara. Exclude Clara.
SELECT (first_name||' '||last_name) AS name, hire_date
FROM employees
    WHERE department_id = (SELECT department_id FROM employees WHERE first_name = 'Clara')
    AND first_name != 'Clara';

--24. the employee number and name( first name and last name ) for all employees who work in a department with any employee whose name contains a T.
SELECT employee_id, (first_name||' '||last_name) AS name
FROM employees
    WHERE department_id = (SELECT department_id FROM employees WHERE (first_name||last_name) LIKE '%T%');

--25. full name(first and last name), job title, starting and ending date of last jobs for those employees with worked without a commission percentage.
SELECT (e.first_name||' '||e.last_name) AS full_name, j.job_title, jh.start_date, jh.end_date
FROM employees e, jobs j, job_history jh
    WHERE e.job_id = j.job_id
    AND e.job_id = jh.job_id
    AND e.commission_pct IS NULL;

--26. the employee number, name( first name and last name ), and salary for all employees who earn more than the average salary and who work in a department with any employee with a J in their name.
SELECT employee_id, (first_name||' '||last_name) AS name, salary
FROM employees
    WHERE salary > (SELECT AVG(salary) FROM employees)
    AND department_id IN (SELECT department_id FROM employees WHERE (first_name||last_name) like '%J%');

--27. the employee number, name( first name and last name ) and job title for all employees whose salary is smaller than any salary of those employees whose job title is MK_MAN.
SELECT e.employee_id, (e.first_name||' '||e.last_name) AS name, j.job_title
FROM employees e, jobs j
    WHERE salary < (SELECT MIN(salary) FROM employees WHERE job_id = 'MK_MAN')
    AND e.job_id = j.job_id;

--28. the employee number, name( first name and last name ) and job title for all employees whose salary is smaller than any salary of those employees whose job title is MK_MAN. Exclude Job title MK_MAN.
SELECT e.employee_id, (e.first_name||' '||e.last_name) AS name, j.job_title
FROM employees e, jobs j
    WHERE salary < (SELECT MIN(salary) FROM employees WHERE job_id = 'MK_MAN')
    AND e.job_id = j.job_id
    AND e.job_id != 'MK_MAN';

--29. all the information of those employees who did not have any job in the past.
SELECT *
FROM employees, job_history
    WHERE hire_date = job_history.start_date;

--30. the employee number, name( first name and last name ) and job title for all employees whose salary is more than any average salary of any department.
SELECT e.employee_id, (e.first_name||' '||e.last_name) AS name, j.job_title
FROM employees e, jobs j
    WHERE salary > (SELECT MAX(AVG(salary)) FROM employees GROUP BY department_id)
    AND e.job_id = j.job_id;

--31. the employee id, name ( first name and last name ) and the job id column with a modified title SALESMAN for those employees whose job title is ST_MAN and DEVELOPER for whose job title is IT_PROG.
SELECT employee_id, (first_name||' '||last_name) AS name,
CASE
    WHEN job_id = 'ST_MAN' THEN 'SALESMAN'
    WHEN job_id = 'IT_PROG' THEN 'DEVELOPER'
END AS job_title
FROM employees
    WHERE job_id IN ('ST_MAN', 'IT_PROG');

--32. the employee id, name ( first name and last name ), salary and the SalaryStatus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than the average salary of all employees.
SELECT employee_id, (first_name||' '||last_name) AS name, salary,
CASE
    WHEN salary < (SELECT AVG(salary) FROM employees) THEN 'LOW'
    WHEN salary > (SELECT AVG(salary) FROM employees) THEN 'HIGH'
END AS salary_status
FROM employees;

--33. the employee id, name ( first name and last name ), SalaryDrawn, AvgCompare (salary - the average salary of all employees)
    -- and the SalaryStatus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than
    -- the average salary of all employees.
    SELECT employee_id, (first_name||' '||last_name) AS name, salary, (salary-(SELECT AVG(salary) FROM employees)) AS avg_compare,
    CASE
        WHEN salary < (SELECT AVG(salary) FROM employees) THEN 'LOW'
        WHEN salary > (SELECT AVG(salary) FROM employees) THEN 'HIGH'
    END AS salary_status
    FROM employees;

--34. all the employees who earn more than the average and who work in any of the IT departments.
SELECT *
FROM employees
    WHERE department_id in (SELECT department_id FROM departments WHERE department_name LIKE '%IT%')
    AND salary > (SELECT AVG(salary) FROM employees);

--35. who earns more than Mr. Ozer.
SELECT *
FROM employees
    WHERE salary > (SELECT salary FROM employees WHERE last_name = 'Ozer');

--36. which employees have a manager who works for a department based in the US.
SELECT *
FROM employees
    WHERE manager_id IN (SELECT employee_id FROM employees WHERE department_id IN
                        (SELECT department_id FROM departments WHERE location_id IN
                        (SELECT location_id FROM locations WHERE country_id = 'US')));

--37. the names of all employees whose salary is greater than 50% of their department’s total salary bill.
SELECT (first_name||' '||last_name) AS name
FROM employees e1
    WHERE salary > (SELECT SUM(salary)*0.5 FROM employees e2 WHERE e1.department_id = e2.department_id);
    
--38. the employee id, name ( first name and last name ), salary, department name and city for all
--the employees who gets the salary as the salary earn by the employee which is maximum within the joining person January 1st, 2002 and December 31st, 2003.  
--39. the first and last name, salary, and department ID for all those employees who earn more than the average salary and arrange the list in descending order on salary.
--40. the first and last name, salary, and department ID for those employees who earn more than the maximum salary of a department which ID is 40.
--41. the department name and Id for all departments where they located, that Id is equal to the Id for the location where department number 30 is located.
--42. the first and last name, salary, and department ID for all those employees who work in that department where the employee works who hold the ID 201.
--43. the first and last name, salary, and department ID for those employees whose salary is equal to the salary of the employee who works in that department which ID is 40.
--44. the first and last name, salary, and department ID for those employees who earn more than the minimum salary of a department which ID is 40.
--45. the first and last name, salary, and department ID for those employees who earn less than the minimum salary of a department which ID is 70.
--46. the first and last name, salary, and department ID for those employees who earn less than the average salary, and also work at the department where the employee Laura is working as a first name holder.
--47. the full name (first and last name) of manager who is supervising 4 or more employees.
--48. the details of the current job for those employees who worked as a Sales Representative in the past.
--49. all the infromation about those employees who earn second lowest salary of all the employees.
--50. the department ID, full name (first and last name), salary for those employees who is highest salary drawar in a department.
