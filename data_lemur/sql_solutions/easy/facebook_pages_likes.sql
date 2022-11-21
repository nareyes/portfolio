/* 
Assume you are given the tables below about Facebook pages and page likes. 
Write a query to return the page IDs of all the Facebook pages that don't have any likes. 
The output should be in ascending order.

https://datalemur.com/questions/sql-page-with-no-likes
*/

SELECT
  P.page_id
FROM pages AS P
  LEFT JOIN page_likes AS L
    ON P.page_id = L.page_id
WHERE L.liked_date IS NULL
ORDER BY P.page_id ASC;