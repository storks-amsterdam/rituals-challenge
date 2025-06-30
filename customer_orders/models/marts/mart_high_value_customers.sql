-- depends_on: {{ ref('stg_orders') }}

WITH customer_orders AS (
    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        c.country,
        o.total_value
    FROM
        {{ ref('stg_customers') }} c
    JOIN
        {{ ref('stg_orders') }} o ON c.customer_id = o.customer_id
    WHERE
        DATE(o.order_date) >= DATE_SUB(DATE(CURRENT_TIMESTAMP()), INTERVAL 6 MONTH)
)
SELECT
    customer_id,
    first_name,
    last_name,
    country,
    SUM(total_value) AS cumulative_order_value
FROM
    customer_orders
GROUP BY
    1, 2, 3, 4
HAVING
    SUM(total_value) > 5000
