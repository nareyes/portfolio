/*
Find the number of inspections per day.
Output the result along with the date of the activity.
Order results based on the activity date in the ascending order.

https://platform.stratascratch.com/coding/9704-find-the-number-of-inspections-per-day?code_type=1
*/

select
    activity_date,
    count (distinct record_id) as num_inspections
from los_angeles_restaurant_health_inspections
group by activity_date
order by activity_date asc;