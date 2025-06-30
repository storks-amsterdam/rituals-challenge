-- depends_on: {{ ref('stg_customers') }}
-- depends_on: {{ ref('stg_orders') }}

SELECT
    CAST(shipment_id AS INT64) AS shipment_id,
    CAST(order_id AS INT64) AS order_id,
    CAST(ship_date AS TIMESTAMP) AS ship_date,
    CAST(delivery_date AS TIMESTAMP) AS delivery_date
FROM
    {{ source('raw_data', 'shipments') }}
WHERE
    SAFE_CAST(shipment_id AS INT64) IS NOT NULL
    AND SAFE_CAST(order_id AS INT64) IS NOT NULL
    AND SAFE_CAST(ship_date AS TIMESTAMP) IS NOT NULL
    AND SAFE_CAST(delivery_date AS TIMESTAMP) IS NOT NULL
    AND SAFE_CAST(order_id AS INT64) IN (SELECT order_id FROM {{ ref('stg_orders') }})