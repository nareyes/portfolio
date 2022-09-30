/*
Count the number of unique facilities per municipality zip code along with the number of inspections.
Output the result along with the number of inspections per each municipality zip code.
Sort the result based on the number of inspections in descending order.

https://platform.stratascratch.com/coding/9702-number-of-unique-facilities-and-inspections-per-municipality?code_type=1
*/

select
    facility_zip,
    count (distinct facility_id) as no_facilities,
    count (record_id) as no_inspections
from los_angeles_restaurant_health_inspections
group by facility_zip
order by no_inspections desc;