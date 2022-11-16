/*
Find the total AdWords earnings for each business type. 
Output the business types along with the total earnings.

https://platform.stratascratch.com/coding/10164-total-adwords-earnings?code_type=1
*/

select
    business_type,
    sum (adwords_earnings) as total_earnings
from google_adwords_earnings
group by business_type;