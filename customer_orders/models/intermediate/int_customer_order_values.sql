-- depends_on: {{ ref('stg_orders') }}

SELECT
    customer_id,
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date,
    COUNT(order_id) AS number_of_orders,
    SUM(total_value) AS total_order_value
FROM
    {{ ref('stg_orders') }}
GROUP BY
    1
