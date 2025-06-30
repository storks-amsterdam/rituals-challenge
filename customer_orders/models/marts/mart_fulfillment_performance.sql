-- depends_on: {{ ref('int_orders_with_shipments') }}

SELECT
    AVG(days_to_ship) AS average_days_to_ship
FROM
    {{ ref('int_orders_with_shipments') }}
WHERE
    days_to_ship IS NOT NULL
