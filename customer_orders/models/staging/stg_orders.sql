-- depends_on: {{ ref('stg_customers') }}

WITH dedup_orders AS (
    SELECT
        *,
        ROW_NUMBER() OVER(PARTITION BY order_id ORDER BY order_date DESC) as rn
    FROM {{ source('raw_data', 'orders') }}
)
SELECT
    CAST(order_id AS INT64) AS order_id,
    CAST(customer_id AS INT64) AS customer_id,
    CAST(order_date AS TIMESTAMP) AS order_date,
    SAFE_CAST(ship_date AS TIMESTAMP) AS ship_date,
    CAST(total_value AS NUMERIC) AS total_value
FROM
    dedup_orders
WHERE
    rn = 1
    AND SAFE_CAST(order_id AS INT64) IS NOT NULL
    AND SAFE_CAST(customer_id AS INT64) IS NOT NULL
    AND SAFE_CAST(order_date AS TIMESTAMP) IS NOT NULL
    AND SAFE_CAST(total_value as NUMERIC) IS NOT NULL
    AND SAFE_CAST(customer_id AS INT64) IN (SELECT customer_id FROM {{ ref('stg_customers') }})