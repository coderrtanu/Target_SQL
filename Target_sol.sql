-- Q1 Import the dataset and inspect its structure and column data types.

SELECT * FROM `target_SQL.customers` LIMIT 10;

-- Q2 Find the operational time range of this dataset.

SELECT 
  MIN(order_purchase_timestamp) AS start_time, 
  MAX(order_purchase_timestamp) AS end_time 
FROM `target_SQL.orders`;

-- Q3 Extract customers & States who ordered between January and March 2018.

SELECT c.customer_city, c.customer_state 
FROM `target_SQL.orders` AS o
INNER JOIN `target_SQL.customers` AS c 
  ON o.customer_id = c.customer_id
WHERE EXTRACT(YEAR FROM o.order_purchase_timestamp) = 2018
  AND EXTRACT(MONTH FROM o.order_purchase_timestamp) BETWEEN 1 AND 3;
  
  -- Q4 Find the total number of orders made each month to identify seasonality.
  
  SELECT 
  EXTRACT(MONTH FROM order_purchase_timestamp) AS month, 
  COUNT(order_id) AS order_num 
FROM `target_SQL.orders`
GROUP BY month
ORDER BY order_num DESC;

-- Q5 Identify peak shopping hours during the day.

SELECT 
  EXTRACT(HOUR FROM order_purchase_timestamp) AS time, 
  COUNT(order_id) AS order_num
FROM `target_SQL.orders`
GROUP BY time
ORDER BY order_num DESC;

-- Q6 Map the unique customer density across cities and states.

SELECT 
  customer_city, 
  customer_state, 
  COUNT(DISTINCT customer_id) AS customer_count
FROM `target_SQL.customers`
GROUP BY customer_city, customer_state
ORDER BY customer_count DESC;

-- Q7 Calculate the YoY percentage increase in order costs from 2017 to 2018 (January to August only).

WITH yearly_totals AS (
  SELECT 
    EXTRACT(YEAR FROM o.order_purchase_timestamp) AS year,
    SUM(p.payment_value) AS total_payment
  FROM `target_SQL.payments` AS p
  INNER JOIN `target_SQL.orders` AS o ON p.order_id = o.order_id
  WHERE EXTRACT(YEAR FROM o.order_purchase_timestamp) IN (2017, 2018)
    AND EXTRACT(MONTH FROM o.order_purchase_timestamp) BETWEEN 1 AND 8
  GROUP BY year
),
yearly_comparisons AS (
  SELECT 
    year, 
    total_payment,
    LEAD(total_payment) OVER (ORDER BY year DESC) AS previous_year_payment
  FROM yearly_totals
)
SELECT 
  year, total_payment, previous_year_payment,
  ROUND(((total_payment - previous_year_payment) / previous_year_payment) * 100, 2) AS pct_increase
FROM yearly_comparisons;

-- Q8 Compute the average and total order prices and freight values by state.

SELECT 
  c.customer_state,
  AVG(oi.price) AS average_price,
  SUM(oi.price) AS sum_price,
  AVG(oi.freight_value) AS average_freight,
  SUM(oi.freight_value) AS sum_freight
FROM `target_SQL.orders` AS o
INNER JOIN `target_SQL.order_items` AS oi ON o.order_id = oi.order_id
INNER JOIN `target_SQL.customers` AS c ON o.customer_id = c.customer_id
GROUP BY c.customer_state;

-- Q9 Calculate days taken to deliver vs. the deviation from estimated timelines.

SELECT 
  order_id,
  DATE_DIFF(order_delivered_customer_date, order_purchase_timestamp, DAY) AS days_to_delivery,
  DATE_DIFF(order_delivered_customer_date, order_estimated_delivery_date, DAY) AS estimated_delivery_diff
FROM `target_SQL.orders`;

-- Q10 Find the top 5 states with the highest average freight costs.

SELECT 
  c.customer_state,
  AVG(oi.freight_value) AS average_freight_value
FROM `target_SQL.orders` AS o
INNER JOIN `target_SQL.order_items` AS oi ON o.order_id = oi.order_id
INNER JOIN `target_SQL.customers` AS c ON o.customer_id = c.customer_id
GROUP BY c.customer_state
ORDER BY average_freight_value DESC
LIMIT 5;

-- Q11 Track the month-on-month distribution of order volumes across payment methods.

SELECT 
  p.payment_type,
  EXTRACT(YEAR FROM o.order_purchase_timestamp) AS year,
  EXTRACT(MONTH FROM o.order_purchase_timestamp) AS month,
  COUNT(DISTINCT o.order_id) AS order_count
FROM `target_SQL.orders` AS o
INNER JOIN `target_SQL.payments` AS p ON o.order_id = p.order_id
GROUP BY p.payment_type, year, month
ORDER BY p.payment_type, year, month;

-- Q12 Categorize order frequencies based on installment financing.

SELECT 
  payment_installments,
  COUNT(DISTINCT order_id) AS number_of_orders
FROM `target_SQL.payments`
GROUP BY payment_installments
ORDER BY payment_installments;



