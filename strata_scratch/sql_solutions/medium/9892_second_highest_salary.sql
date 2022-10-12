/*
Find the second highest salary of employees.

https://platform.stratascratch.com/coding/9892-second-highest-salary?code_type=1
*/

-- cte
with

ranked_salaries as (
    select 
        id,
        salary,
        dense_rank () over (order by salary desc)
    from employee
)

select distinct (salary)
from ranked_salaries
where dense_rank = 2;

-- limit & offset
select distinct salary
from employee
order by salary desc
limit 1 offset 1;