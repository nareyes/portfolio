/*
Find the average score for grades A, B, and C.
Output the results along with the corresponding grade (ex: 'A', avg(score)).

https://platform.stratascratch.com/coding/9693-find-the-average-score-for-grades-a-b-and-c?code_type=1
*/

select
    grade,
    avg (score) as avg
from los_angeles_restaurant_health_inspections
where grade in ('A', 'B', 'C')
group by grade
order by grade asc;