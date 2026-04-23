-- Top 10 most sold product_categories
select 
p.product_category_name as category_name,
count(ot.order_id ) as total_orders,
sum(ot.price) as total_sales
from product p
join orders_items ot
on p.product_id = ot.product_id
join orders o
on o.order_id = ot.order_id
where order_status = "delivered"
group by p.product_category_name
order by total_sales desc
limit 10;

-- Monthly order sale analysis
select
year(o.order_purchase_timestamp)  as year,
monthname(o.order_purchase_timestamp)as month,
count(o.order_id) as total_order,
sum(ot.price) total_revenue 
from
orders o 
join orders_items ot
on o.order_id = ot.order_id
where o.order_status = "delivered"
group by year,month
order by  year,month;

--    average order value by category 
select 
coalesce(p.product_category_name,"Unknown") as category,
round(avg(ot.price),2) avg_ordervalue
from orders_items ot
join product p
on ot.product_id = p.product_id
join orders o
on ot.order_id = o.order_id
where o.order_status = "delivered"
group by category
order by avg_ordervalue desc;

--  percentage of orders by status 
with perce_orders as (
select 
order_status,
count(order_id) as order_count
from orders
group by order_status)
select order_status,
order_count,
round(order_count / (select count(order_id) from orders) *100,3) as Order_percentage
from perce_orders
order by Order_percentage desc;

-- most popular payment method
select 
payment_type,
count(*) total_orders,
sum(payment_value) total_spent
from order_payments
group by payment_type
order by total_spent desc;

-- customer lifetime value 
with customer_orders as (
select 
c.customer_id as customer,
min(o.order_purchase_timestamp) as first_orderdate,
max(o.order_purchase_timestamp) as last_orderdate,
count(o.order_id) total_orders ,
sum(op.payment_value) total_spent
from customers c 
join orders o 
on c.customer_id = o.customer_id
join order_payments op
on o.order_id = op.order_id
group by c.customer_id
)
select 
customer,
total_orders,
total_spent,
round(total_spent/total_orders,2) as avg_order_value,
timestampdiff(day,first_orderdate,last_orderdate) as customer_life_span
from customer_orders
order by total_spent desc
;


-- products with higgest cancellation  
select 
p.product_category_name,
o.order_status,
count(o.order_id) as no_cancelled_orders
from orders o 
join orders_items ot
on o.order_id = ot.order_id
join product p
on ot.product_id = p.product_id
where order_status = "canceled"
group by p.product_category_name,
o.order_status
order by no_cancelled_orders desc;

-- Monthly Revenue Trend Analysis
with mom as (
select 
date_format(o.order_purchase_timestamp,"%Y-%m") as _month,
sum(op.payment_value) revenue,
avg(op.payment_value) avg_revenue
from 
orders o
join order_payments op
on o.order_id = op.order_id
where o.order_status = "delivered"
group by _month)
select 
_month,
revenue,
avg_revenue ,
sum(revenue) over(ORDER BY _month) as cumulative_revenue
from mom
order by _month;

-- avg product rating by category
select 
p.product_category_name as category,
count(distinct p.product_id) total_products,
round(avg(r.review_score),1) as review_score
from
order_reviews r
join orders_items o 
on r.order_id = o.order_id
join product p 
on o.product_id = p.product_id
group by category	
order by review_score desc;

-- customer segmentation
with rfm as (
select 
o.customer_id as customer_id,
timestampdiff(day,max(o.order_purchase_timestamp),now()) as recency,
count(o.order_id) as frequency,
sum(op.payment_value) as monetary
from 
orders o 
join order_payments op 
on o.order_id = op.order_id
where o.order_status = "delivered"
group by customer_id
)
select *,
case when recency <=60 and frequency >= 5 then "Diamond"
when recency <= 90 and frequency >= 3 then "Gold"
when recency <= 120 and frequency >= 1 then "Silver"
else "Bronze" end as customer_segment
from rfm
order by customer_segment desc;
