/*
Find the number of employees in each department.
Output the department name along with the corresponding number of employees.
Sort records based on the number of employees in descending order.

https://platform.stratascratch.com/coding/9906-number-of-employees-per-department?code_type=1
*/

select
    department,
    count(id) as num_of_emp
from employee
group by department
order by num_of_emp desc;