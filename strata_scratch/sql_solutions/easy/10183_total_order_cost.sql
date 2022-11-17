/*
Find the total cost of each customer's orders. Output customer's id, first name, and the total order cost. 
Order records by customer's first name alphabetically.

https://platform.stratascratch.com/coding/10183-total-cost-of-orders?code_type=1
*/

select
    c.id,
    c.first_name,
    sum (o.total_order_cost) as total_order_cost
from customers as c
    inner join orders as o -- inner join outputs customers with orders
        on c.id = o.cust_id
group by c.id, c.first_name
order by c.first_name asc;