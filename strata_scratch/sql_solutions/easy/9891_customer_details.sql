/*
Find the details of each customer regardless of whether the customer made an order.
Output the customer's first name, last name, and the city along with the order details.
You may have duplicate rows in your results due to a customer ordering several of the same items.
Sort records based on the customer's first name and the order details in ascending order.

https://platform.stratascratch.com/coding/9891-customer-details?code_type=1
*/

select
    c.first_name,
    c.last_name,
    c.city,
    o.order_details
from customers as c
    left join orders as o
        on c.id = o.cust_id
order by 
    c.first_name asc, 
    o.order_details asc;


-- alternate solution (control return for customers without an exisiting order)
select
    c.first_name,
    c.last_name,
    c.city,
    case
        when o.order_details is null then 'no order'
        else o.order_details
    end as order_details
from customers as c
    left join orders as o
        on c.id = o.cust_id
order by 
    c.first_name asc, 
    o.order_details asc;