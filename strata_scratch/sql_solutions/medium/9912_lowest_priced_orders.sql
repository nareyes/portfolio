/*
Find the lowest order cost of each customer.
Output the customer id along with the first name and the lowest order price.

https://platform.stratascratch.com/coding/9912-lowest-priced-orders?code_type=1
*/

select
    c.id,
    c.first_name,
    min (total_order_cost) as lowest_price_per_group
from customers as c
    inner join orders as o
        on c.id = o.cust_id
group by c.id, c.first_name;