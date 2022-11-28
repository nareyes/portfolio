/*
Given a list of projects and employees mapped to each project, calculate by the amount of project budget allocated to each employee. 
The output should include the project title and the project budget rounded to the closest integer. 
Order your list by projects with the highest budget per employee first.

https://platform.stratascratch.com/coding/10301-expensive-projects?code_type=1
*/

select
    p.title as project,
    round (cast (budget as float) / count (emp_id), 0) as budget_emp
from ms_projects as p
    join ms_emp_projects as e
        on p.id = e.project_id
group by p.title, budget
order by budget_emp desc;