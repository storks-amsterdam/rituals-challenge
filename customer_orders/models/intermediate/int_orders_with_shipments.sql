-- depends_on: {{ ref('stg_shipments') }}

WITH orders AS (
    SELECT * FROM {{ ref('stg_orders') }}
),

shipments AS (
    -- Aggregate shipments to the order level to prevent fan-out
    SELECT
        order_id,
        MIN(ship_date) AS first_ship_date,
        MAX(ship_date) AS last_ship_date,
        MIN(delivery_date) AS first_delivery_date,
        MAX(delivery_date) AS last_delivery_date
    FROM {{ ref('stg_shipments') }}
    GROUP BY 1
)

SELECT
    o.order_id,
    o.customer_id,
    o.order_date,
    o.total_value,
    s.first_ship_date,
    s.last_ship_date,
    s.first_delivery_date,
    s.last_delivery_date,
    TIMESTAMP_DIFF(s.first_ship_date, o.order_date, DAY) AS days_to_ship,
    TIMESTAMP_DIFF(s.last_delivery_date, s.first_ship_date, DAY) AS days_to_deliver
FROM orders o
LEFT JOIN shipments s ON o.order_id = s.order_id
