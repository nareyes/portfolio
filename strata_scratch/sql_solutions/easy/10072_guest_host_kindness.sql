/*
Find whether hosts or guests give higher review scores based on their average review scores.
Output the higher of the average review score rounded to the 2nd decimal spot (e.g., 5.11).

https://platform.stratascratch.com/coding/10072-guest-or-host-kindness?code_type=1
*/

select top 1
    from_type,
    round (avg (cast (review_score as float)), 2) as winner
from airbnb_reviews
group by from_type
order by winner desc;