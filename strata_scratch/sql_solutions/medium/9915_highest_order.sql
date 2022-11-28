/*
Find the customer with the highest daily total order cost between 2019-02-01 to 2019-05-01. 
If customer had more than one order on a certain day, sum the order costs on daily basis. 
Output customer's first name, total cost of their items, and the date.
For simplicity, you can assume that every first name in the dataset is unique.

https://platform.stratascratch.com/coding/9915-highest-cost-orders?code_type=1
*/

select top 1
    o.order_date,
    c.first_name,
    sum (total_order_cost) as total_order_cost
from customers as c
    left join orders as o
        on c.id = o.cust_id
where o.order_date between '2019-02-01' and '2019-05-01'
group by o.order_date, c.id, c.first_name
order by total_order_cost desc;