COPY (

-- Average Monthly Active User per Year

WITH

mau AS
(
SELECT active_year, FLOOR(AVG(monthly_active_user)) monthly_active_cust
FROM 
(
SELECT date_part('month', order_purchase_timestamp) active_month, date_part('year', order_purchase_timestamp) active_year, COUNT(DISTINCT(customer_unique_id)) monthly_active_user
FROM orders_dataset o JOIN customers_dataset c ON o.customer_id = c.customer_id
GROUP BY 1, 2
ORDER BY 1, 2
) AS t1
GROUP BY 1
ORDER BY 1
),

-- Average Monthly Active User per Year

cust AS
(
SELECT date_part('year', order_purchase_timestamp) active_year, COUNT(DISTINCT(customer_unique_id)) total_active_user
FROM orders_dataset o JOIN customers_dataset c ON o.customer_id = c.customer_id
GROUP BY 1
ORDER BY 1
),	
	
-- Total New Customers per Year

new_cust AS
(
SELECT first_purchase_year, COUNT(1) total_new_cust
FROM 
(
SELECT customer_unique_id, date_part('year', MIN(order_purchase_timestamp)) first_purchase_year
FROM orders_dataset o JOIN customers_dataset c ON o.customer_id = c.customer_id
GROUP BY 1
ORDER BY 1
) AS t1
GROUP BY 1
ORDER BY 1
),

-- Total Repeat Orders Customers per Year

ro_cust AS
(
SELECT active_year, COUNT(1) total_ro_cust
FROM 
(
SELECT date_part('year', order_purchase_timestamp) active_year, customer_unique_id, COUNT(1)
FROM orders_dataset o JOIN customers_dataset c ON o.customer_id = c.customer_id
GROUP BY 1, 2
HAVING COUNT(1) > 1
ORDER BY 2 DESC
) AS t1
GROUP BY 1
ORDER BY 1
),
	
-- Repeat Orders Frequency per Year

ro_freq AS
(
SELECT active_year, ROUND(AVG(total_orders),3) ro_freq
FROM 
(
SELECT date_part('year', order_purchase_timestamp) active_year, customer_unique_id, COUNT(1) total_orders
FROM orders_dataset o JOIN customers_dataset c ON o.customer_id = c.customer_id
GROUP BY 1, 2
ORDER BY 2 DESC
) AS t1
GROUP BY 1
ORDER BY 1
)

SELECT
mau.active_year,
mau.monthly_active_cust,
cust.total_active_user,
new_cust.total_new_cust,
ro_cust.total_ro_cust,
ro_freq.ro_freq
FROM
mau,
cust,
new_cust,
ro_cust,
ro_freq
WHERE
mau.active_year = cust.active_year AND
cust.active_year = new_cust.first_purchase_year AND
new_cust.first_purchase_year = ro_cust.active_year AND
ro_cust.active_year = ro_freq.active_year

) TO 'D:\AI Lab\Rakamin\Mini Project\Analyzing eCommerce Business Performance with SQL\Task 2\Annual Customer Activity Growth Analysis.csv' WITH DELIMITER ',' CSV HEADER
