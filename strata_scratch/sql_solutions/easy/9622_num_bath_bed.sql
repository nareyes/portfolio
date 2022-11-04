/*
Find the average number of bathrooms and bedrooms for each city’s property types. 
Output the result along with the city name and the property type.

https://platform.stratascratch.com/coding/9622-number-of-bathrooms-and-bedrooms?code_type=1
*/

select
    city,
    property_type,
    avg (cast (bathrooms as float)) as avg_bathrooms,
    avg (cast (bedrooms as float)) as avg_bedrooms
from airbnb_search_details
group by city, property_type
order by city, property_type;