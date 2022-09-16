/*
Find the most common grade earned by bakeries.

https://platform.stratascratch.com/coding/9703-find-the-most-common-grade-earned-by-bakeries?code_type=1
*/

with
grade_freq as (
    select
        grade,
        count(*) as freq
    from los_angeles_restaurant_health_inspections
    where facility_name ilike '%bakery%'
    group by grade
)

select grade
from grade_freq
where freq = (
    select max(freq)
    from grade_freq
    );
