/*
Find employees whose bonus is less than $150.
Output the first name along with the corresponding bonus.

https://platform.stratascratch.com/coding/9903-employees-with-bonuses?code_type=1
*/

select
    first_name,
    bonus
from employee
where
    bonus < 150
    or bonus is null;