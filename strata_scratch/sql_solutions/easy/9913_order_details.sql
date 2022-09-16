/*
Find order details made by Jill and Eva.
Consider the Jill and Eva as first names of customers.
Output the order date, details and cost along with the first name.
Order records based on the customer id in ascending order.

https://platform.stratascratch.com/coding/9913-order-details?code_type=1
*/

select
    c.first_name,
    o.order_date,
    o.order_details, o.total_order_cost
from customers as c
    -- left join preserves customer side in the case of missing orders (for reproducibility)
    left join orders as o
        on c.id = o.cust_id
where first_name in ('Jill', 'Eva')
order by o.cust_id asc;