/*
Compare each employee's salary with the average salary of the corresponding department.
Output the department, first name, and salary of employees along with the average salary of that department.

https://platform.stratascratch.com/coding/9917-average-salaries?code_type=1
*/

select
    department,
    first_name,
    salary,
    avg (cast (salary as float)) over (partition by department) as avg_dept_salary
from employee;