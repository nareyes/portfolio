/*
Find the price of the cheapest property for every city.

https://platform.stratascratch.com/coding/9625-cheapest-properties?code_type=1
*/

select
    city,
    min(price) as min_price
from airbnb_search_details
group by city;