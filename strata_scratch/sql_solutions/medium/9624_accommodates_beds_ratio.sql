/*
Find the average accommodates-to-beds ratio for shared rooms in each city. 
Sort your results by listing cities with the highest ratios first.


https://platform.stratascratch.com/coding/9624-accommodates-to-bed-ratio?code_type=1
*/

select
    city,
    avg (
        cast (accommodates as float) / cast (beds as float)
    ) as avg_crowdness_ratio
from airbnb_search_details
where lower (room_type) = 'shared room'
group by city
order by avg_crowdness_ratio desc;