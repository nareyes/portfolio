/*
Find departments with at more than or equal 5 employees.

https://platform.stratascratch.com/coding/9911-departments-with-5-employees?code_type=1
*/

select department
from employee
group by department
having count(id) >= 5;