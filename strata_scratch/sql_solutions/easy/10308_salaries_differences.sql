/*
Write a query that calculates the difference between the highest salaries found in the marketing and engineering departments. Output just the absolute difference in salaries.

https://platform.stratascratch.com/coding/10308-salaries-differences?code_type=1
*/

select

    abs (

    (select max (e.salary)
    from db_dept as d
        inner join db_employee as e
            on d.id = e.department_id
    where d.department = 'marketing') 
    
    - -- difference
    
    (select max (e.salary)
    from db_dept as d
        inner join db_employee as e
            on d.id = e.department_id
    where d.department = 'engineering')
    
) as salary_difference