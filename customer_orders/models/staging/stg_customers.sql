WITH dedup_customers AS (
    SELECT
        *,
        ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY customer_id) as rn
    FROM {{ source('raw_data', 'customers') }}
)
SELECT
    CAST(CAST(customer_id AS FLOAT64) AS INT64) AS customer_id,
    first_name,
    last_name,
    country
FROM
    dedup_customers
WHERE
    rn = 1 AND SAFE_CAST(customer_id AS FLOAT64) IS NOT NULL