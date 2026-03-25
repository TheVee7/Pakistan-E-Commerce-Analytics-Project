-- LOAD DATA LOCAL INFILE 'C:/Users/dell/Desktop/Pakistan Largest Ecommerce Dataset.csv' 
-- INTO TABLE sales_data 
-- FIELDS TERMINATED BY ',' 
-- ENCLOSED BY '"' 
-- LINES TERMINATED BY '\r\n' 
-- IGNORE 1 ROWS;

-- Q1 What's the overall order completion rate? (%)

SELECT 
	count(case 
			when status In ('Complete', 'Received', 'Closed')
			Then 1
		end)*100/count(status) AS Completion_rate
from sales_data;

-- Q2 How many orders fall into each status category?

SELECT STATUS, count(sku_unit) from sales_data
group by status;

-- Which status costs us the most in lost revenue?

SELECT STATUS, SUM(adjusted_price) as Revenue from sales_data
group by status
order by Revenue desc;

-- Which product category has the highest completion rate?
select category,
		count(case 
			when status In ('Complete', 'Received', 'Closed')
			Then 1
		end)*100/count(status) AS Completion_rate_category
from sales_data
group by category
Order by Completion_rate_category desc;

-- Which category has the lowest completion rate?
SELECT category
FROM (
    SELECT 
        category,
        COUNT(CASE 
            WHEN status IN ('Complete', 'Received', 'Closed')
            THEN 1
        END) * 100.0 / COUNT(*) AS completion_rate
    FROM sales_data
    GROUP BY category
) t
ORDER BY completion_rate ASC
LIMIT 5;

-- What's the average order value by category?
select category, Avg(adjusted_total) as avg_value
from sales_data
group by category
order by avg_value desc;

-- How many customers are repeat customers vs one-time buyers?
SELECT 
    CASE 
        WHEN order_count > 1 THEN 'Repeat Customer'
        ELSE 'One-Time Buyer'
    END AS customer_type,
    COUNT(*) AS total_customers
FROM (
    SELECT customer_id, COUNT(*) AS order_count
    FROM sales_data
    GROUP BY customer_id
) AS customer_orders
GROUP BY customer_type;


-- What's the average spending of repeat customers vs one-time?
WITH customer_stats AS (
  SELECT 
    customer_id,
    COUNT(*) AS order_count,
    SUM(adjusted_total) AS total_spending
  FROM sales_data
  GROUP BY customer_id
)
SELECT 
  CASE WHEN order_count > 1 THEN 'repeat_cust' ELSE 'one_time_guy' END AS customer_type,
  AVG(total_spending) AS avg_spending
FROM customer_stats
GROUP BY customer_type;

-- Which customer spent the most? (Top 5 customers)
select customer_id, sum(adjusted_price) as ts from sales_data
group by customer_id
order by ts desc 
LIMIT 5 ;

-- Do discounted orders complete more often than non-discounted?
WITH order_flags AS (
    SELECT 
        CASE 
            WHEN discount_amount > 0 THEN 'Discounted'
            ELSE 'Non-Discounted'
        END AS discount_flag,

        CASE 
            WHEN status IN ('Complete', 'Received', 'Closed') 
            THEN 'Completed'
            ELSE 'Not Completed'
        END AS completion_flag
    FROM sales_data
)

SELECT 
    discount_flag,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN completion_flag = 'Completed' THEN 1 ELSE 0 END) AS completed_orders,
    ROUND(
        SUM(CASE WHEN completion_flag = 'Completed' THEN 1 ELSE 0 END) 
        / COUNT(*) * 100, 2
    ) AS completion_rate_percent
FROM order_flags
GROUP BY discount_flag;

-- What's the completion rate for discounted vs non-discounted orders?

-- Is discount amount correlated with completion?
WITH discount_bucket AS (
    SELECT 
        CASE 
            WHEN (discount_amount / NULLIF(adjusted_price,0)) * 100 = 0 THEN '0%'
            WHEN (discount_amount / NULLIF(adjusted_price,0)) * 100 BETWEEN 0 AND 10 THEN '1-10%'
            WHEN (discount_amount / NULLIF(adjusted_price,0)) * 100 BETWEEN 10 AND 20 THEN '10-20%'
            ELSE '20%+'
        END AS discount_range,

        CASE 
            WHEN status IN ('Complete', 'Received', 'Closed') 
            THEN 1
            ELSE 0
        END AS is_completed

    FROM sales_data
)

SELECT 
    discount_range,
    COUNT(*) AS total_orders,
    SUM(is_completed) AS completed_orders,
    ROUND(SUM(is_completed) * 100.0 / COUNT(*), 2) AS completion_rate
FROM discount_bucket
GROUP BY discount_range
ORDER BY discount_range;


-- Which payment method has the highest success rate?
	with order_com as 
		( Select payment_method,
			CASE 
				WHEN status IN ('Complete', 'Received', 'Closed') 
				THEN 'Completed'
				ELSE 'Not Completed'
			END AS completion_flag
		FROM sales_data ) 

	SELECT 
    payment_method, ( sum(case when completion_flag = 'Completed' then 1 else 0 end )/count(completion_flag) * 100 ) as completion_rate
   
FROM order_com
GROUP BY payment_method;


-- Which payment method has the lowest success rate?
	with order_com as 
		( Select payment_method,
			CASE 
				WHEN status IN ('Complete', 'Received', 'Closed') 
				THEN 'Completed'
				ELSE 'Not Completed'
			END AS completion_flag
		FROM sales_data ) 

	SELECT 
    payment_method, ( sum(case when completion_flag = 'Completed' then 1 else 0 end )/count(completion_flag) * 100 ) as completion_rate
   
FROM order_com
GROUP BY payment_method
order by completion_rate asc ;

-- Do customers prefer certain payment methods for certain categories?

-- SELECT 
--     category,
--     payment_method,
--     COUNT(*) AS transaction_count
-- FROM sales_data
-- GROUP BY category, payment_method
-- ORDER BY category, transaction_count DESC;

SELECT category, payment_method, transaction_count
FROM (
    SELECT 
        category,
        payment_method,
        COUNT(*) AS transaction_count,
        RANK() OVER (PARTITION BY category ORDER BY COUNT(*) DESC) AS rnk
    FROM sales_data
    GROUP BY category, payment_method
) t
WHERE rnk = 1;

-- NO of custumers 
select count(distinct customer_id) 
from sales_data;

-- AOV
SELECT status, SUM(adjusted_total) AS total_amount
FROM sales_data
GROUP BY status;

-- cate
SELECT 
    SUM(adjusted_total) AS vee
from sales_data
where status In ('Complete', 'Received', 'Closed');



