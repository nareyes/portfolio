/*
We have a table with employees and their salaries, however, some of the records are old and contain outdated salary information. Find the current salary of each employee assuming that salaries increase each year. Output their id, first name, last name, department ID, and current salary. Order your list by employee ID in ascending order.

https://platform.stratascratch.com/coding/10299-finding-updated-records?code_type=1
*/

with

    rankings
    as
    (
        select
            id,
            first_name,
            last_name,
            department_id,
            salary,
            dense_rank() over (partition by id order by salary desc) as salary_rank
        from ms_employee_salary
    )

select
    id,
    first_name,
    last_name,
    department_id,
    salary as current_salary
from rankings
where salary_rank = 1
order by id asc;