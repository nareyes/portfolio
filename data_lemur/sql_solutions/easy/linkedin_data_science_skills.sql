/*
Given a table of candidates and their skills, you're tasked with finding the candidates best suited for an open Data Science job.
You want to find candidates who are proficient in Python, Tableau, and PostgreSQL.

Write a query to list the candidates who possess all of the required skills for the job. Sort the the output by candidate ID in ascending order.

Assumption: There are no duplicates in the candidates table.

https://datalemur.com/questions/matching-skills
*/

SELECT 
  candidate_id
FROM candidates
WHERE skill IN ('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id
HAVING COUNT (skill) = 3
ORDER BY candidate_id ASC;