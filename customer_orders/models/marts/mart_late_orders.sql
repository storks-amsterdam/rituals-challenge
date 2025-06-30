-- depends_on: {{ ref('int_orders_with_shipments') }}

SELECT
    order_id,
    customer_id,
    order_date,
    first_ship_date,
    days_to_ship AS delay_duration_days
FROM
    {{ ref('int_orders_with_shipments') }}
WHERE
    days_to_ship > 5
