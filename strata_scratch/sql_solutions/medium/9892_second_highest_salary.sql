/*
Find the second highest salary of employees.

https://platform.stratascratch.com/coding/9892-second-highest-salary?code_type=1
*/

with

ranked_salaries as (
    select 
        id,
        salary,
        dense_rank () over (order by salary desc) as salary_rank
    from employee
)

select distinct (salary)
from ranked_salaries
where salary_rank = 2;