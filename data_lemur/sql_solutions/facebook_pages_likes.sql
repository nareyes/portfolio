/* 
Assume you are given the tables below about Facebook pages and page likes. 
Write a query to return the page IDs of all the Facebook pages that don't have any likes. 
The output should be in ascending order.

https://datalemur.com/questions/sql-page-with-no-likes
*/

select
  p.page_id
from pages as p
  left join page_likes as l
    on p.page_id = l.page_id
where l.liked_date is null
order by p.page_id asc;