-- depends_on: {{ ref('int_orders_with_shipments') }}

WITH order_statuses AS (
    SELECT
        order_id,
        CASE WHEN order_date IS NOT NULL THEN 1 ELSE 0 END AS is_created,
        CASE WHEN first_ship_date IS NOT NULL THEN 1 ELSE 0 END AS is_shipped,
        CASE WHEN last_delivery_date IS NOT NULL THEN 1 ELSE 0 END AS is_delivered
    FROM
        {{ ref('int_orders_with_shipments') }}
)
SELECT
    SUM(is_created) AS total_orders,
    SUM(is_shipped) AS shipped_orders,
    SUM(is_delivered) AS delivered_orders,
    SAFE_DIVIDE(SUM(is_shipped), SUM(is_created)) * 100 AS shipped_conversion_rate_pct,
    SAFE_DIVIDE(SUM(is_delivered), SUM(is_created)) * 100 AS delivered_conversion_rate_pct
FROM
    order_statuses
