/*
Find the owner_name and the pe_description of facilities owned by 'BAKERY' where low-risk cases have been reported.


https://platform.stratascratch.com/coding/9697-bakery-owned-facilities?code_type=1
*/


select distinct
    owner_name,
    pe_description
from los_angeles_restaurant_health_inspections
where
    owner_name ilike '%bakery%'
    and pe_description ilike '%low risk%'
order by owner_name asc;