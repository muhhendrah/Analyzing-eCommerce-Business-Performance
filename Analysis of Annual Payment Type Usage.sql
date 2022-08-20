COPY (

WITH

total_payment AS
(
SELECT
payment_type,
SUM(CASE WHEN date_part('year', order_purchase_timestamp) = 2016 THEN 1 ELSE 0 END) AS "2016",
SUM(CASE WHEN date_part('year', order_purchase_timestamp) = 2017 THEN 1 ELSE 0 END) AS "2017",
SUM(CASE WHEN date_part('year', order_purchase_timestamp) = 2018 THEN 1 ELSE 0 END) AS "2018",
COUNT(1) total
FROM orders_dataset o JOIN order_payments_dataset op ON o.order_id = op.order_id
GROUP BY 1
),

revenue_payment AS
(
SELECT payment_type,
SUM(CASE WHEN date_part('year', order_purchase_timestamp) = 2016 THEN (price + freight_value) ELSE 0 END) AS "rev_2016",
SUM(CASE WHEN date_part('year', order_purchase_timestamp) = 2017 THEN (price + freight_value) ELSE 0 END) AS "rev_2017",
SUM(CASE WHEN date_part('year', order_purchase_timestamp) = 2018 THEN (price + freight_value) ELSE 0 END) AS "rev_2018",
SUM(price + freight_value) revenue
FROM orders_dataset o, order_items_dataset oi, order_payments_dataset op
WHERE o.order_id = oi.order_id AND oi.order_id = op.order_id
AND o.order_status = 'delivered'
GROUP BY 1
ORDER BY 1
)

SELECT tp.payment_type, "2016", "2017", "2018", total, rev_2016, rev_2017, rev_2018, revenue
FROM
total_payment tp
JOIN
revenue_payment rp
ON
tp.payment_type = rp.payment_type

) TO 'D:\AI Lab\Rakamin\Mini Project\Analyzing eCommerce Business Performance with SQL\Task 4\Analysis of Annual Payment Type Usage.csv' WITH DELIMITER ',' CSV HEADER