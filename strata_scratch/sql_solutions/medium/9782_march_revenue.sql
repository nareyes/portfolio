/*
Calculate the total revenue from each customer in March 2019. 
Include only customers who were active in March 2019.

Output the revenue along with the customer id and sort the results based on the revenue in descending order.

https://platform.stratascratch.com/coding/9782-customer-revenue-in-march?code_type=1
*/

select
    cust_id,
    sum (total_order_cost) as revenue
from orders
where order_date >= '2019-03-01' and order_date <= '2019-03-31'
group by cust_id
having sum (total_order_cost) > 0
order by revenue desc;