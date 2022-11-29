/*
Find the 3 most profitable companies in the entire world.
Output the result along with the corresponding company name.
Sort the result based on profits in descending order.

https://platform.stratascratch.com/coding/10354-most-profitable-companies?tabname=question
*/


select top 3
    company,
    sum (profits) as total_profits
from forbes_global_2010_2014
group by company
order by total_profits desc;

-- using cte and rank
with

ranking as (
    select
        company,
        sum (profits) as total_profits,
        rank() over (order by sum (profits) desc) as profit_rank
    from forbes_global_2010_2014
    group by company
)

select
    company,
    total_profits
from ranking
where profit_rank <= 3
order by total_profits desc;