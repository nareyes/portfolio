/*
Write a query to find which gender gives a higher average review score when writing reviews as guests. Use the from_type column to identify guest reviews. Output the gender and their average review score.

https://platform.stratascratch.com/coding/10149-gender-with-generous-reviews?code_type=1
*/

select
    g.gender,
    avg (review_score) as avg_score
from airbnb_guests as g
    inner join airbnb_reviews as r
        on g.guest_id = r.from_user
where r.from_type = 'guest'
group by g.gender
order by avg_score desc
limit 1;
