-- Annual Revenue

CREATE TABLE annual_revenue AS
SELECT date_part('year', order_purchase_timestamp) active_year, SUM(price + freight_value) revenue
FROM orders_dataset o JOIN order_items_dataset oi
ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY 1
ORDER BY 1;

-- Total Canceled Order per Year

CREATE TABLE annual_candeled_order AS
SELECT date_part('year', order_purchase_timestamp) active_year, COUNT(1) total_canceled_order
FROM orders_dataset
WHERE order_status = 'canceled'
GROUP BY 1
ORDER BY 1;

-- Top Category by Revenue per Year

CREATE TABLE top_category AS
SELECT *, rank() OVER (PARTITION BY active_year ORDER BY revenue DESC)
FROM(
SELECT date_part('year', order_purchase_timestamp) active_year, product_category_name, SUM(price + freight_value) revenue
FROM orders_dataset o, order_items_dataset oi, product_dataset p
WHERE o.order_id = oi.order_id AND oi.product_id = p.product_id
GROUP BY 1, 2
ORDER BY 1, 3 DESC
) subq
ORDER BY rank() OVER (PARTITION BY active_year ORDER BY revenue DESC), active_year
LIMIT 3;

-- Highest Cancel Order Product Category per Year

CREATE TABLE top_canceled_product AS
SELECT *, rank() OVER (PARTITION BY active_year ORDER BY total_canceled_order DESC)
FROM(
SELECT date_part('year', order_purchase_timestamp) active_year, product_category_name, COUNT(1) total_canceled_order
FROM orders_dataset o, order_items_dataset oi, product_dataset p
WHERE o.order_id = oi.order_id AND oi.product_id = p.product_id AND o.order_status = 'canceled'
GROUP BY 1, 2
ORDER BY 1, 3 DESC
) subq
ORDER BY rank() OVER (PARTITION BY active_year ORDER BY total_canceled_order DESC), active_year
LIMIT 3;

COPY (

SELECT
ar.active_year,
ar.revenue,
aco.total_canceled_order,
tc.product_category_name,
tc.revenue category_revenue,
tcp.product_category_name,
tcp.total_canceled_order category_canceled_order
FROM
annual_revenue ar,
annual_candeled_order aco,
top_category tc,
top_canceled_product tcp
WHERE
ar.active_year = aco.active_year AND
aco.active_year = tc.active_year AND
tc.active_year = tcp.active_year
	
) TO 'D:\AI Lab\Rakamin\Mini Project\Analyzing eCommerce Business Performance with SQL\Task 3\Annual Product Category Quality Analysis.csv' WITH DELIMITER ',' CSV HEADER