-- depends_on: {{ ref('stg_orders') }}

SELECT
    EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(QUARTER FROM order_date) AS order_quarter,
    SUM(total_value) AS total_revenue
FROM
    {{ ref('stg_orders') }}
GROUP BY
    1, 2
ORDER BY
    1, 2
