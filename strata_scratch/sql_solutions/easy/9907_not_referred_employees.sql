/*
Find employees that are not referred by the manager id 1.
Output the first name of the employee.

https://platform.stratascratch.com/coding/9907-not-referred-employees?code_type=1
*/

select first_name
from employee
where manager_id <> 1 or manager_id is null;