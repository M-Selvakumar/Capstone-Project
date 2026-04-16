Create Database sales_analysis;
use sales_analysis;
-- Inner Join for Order Details
	-- Join orders, order_items, and products to display detailed line items.
Select o.order_id, o.customer_id, o.order_status, o.order_date, o.required_date, o.shipped_date, o.store_id, o.staff_id,
 ot.list_price, ot.quantity, ot.discount, ot.Total_price,
 p.product_id, p.product_name, p.category_id, p.model_year
 from orders o join order_items ot on o.order_id = ot.order_id 
 join products p on p.product_id = ot.product_id;
 
 -- Total Sales by Store
select sto.store_id , sum(ot.Total_Price) as Total_Sales 
from order_items ot join stores sto group by sto.store_id; 

-- Top 5 Selling Products 
Select p.product_name, sum(ot.Total_Price) as Total_Sales 
from order_items ot join products p on ot.product_id = p.product_id 
group by p.product_name order by Total_Sales desc limit 5 ;
 
-- Customer Purchase Summary
select c.first_name , count(o.order_id) as Total_purchase, sum(ot.Total_Price) as Total_Revenue 
from customers c join orders o on c.customer_id = o.customer_id 
join order_items ot on  o.order_id = ot.order_id group by c.first_name; 

-- Staff Performance Analysis 
select s.first_name , count(o.order_id) as Total_Orders , sum(ot.Total_Price) as Total_Revenue 
from staffs s join orders o on s.staff_id = o.staff_id 
join order_items ot on  o.order_id = ot.order_id group by s.first_name; 

-- Stock Alert Query 
select p.product_name, s.quantity from products p join stocks s
on p.product_id = s.product_id  where s.quantity < 10 ;

-- Creating Final Segmentation Table
create table customer_segments(
customer_id int,
recency int,
frequency int,
monetary decimal(10,2),
segment varchar(50)); 
SELECT * FROM customer_segments;

