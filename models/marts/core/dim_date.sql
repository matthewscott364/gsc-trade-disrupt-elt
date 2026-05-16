-- This model creates a date dimension table by extracting unique dates from the disruption events, shipping rates, and port stress data. It also calculates the year, month, and quarter for each date to facilitate time-based analysis in the data warehouse.
WITH dates AS (
    SELECT disruption_date AS full_date
    FROM {{ ref('stg_gsc_disruption_events') }}
    UNION
    SELECT shipping_date AS full_date
    FROM {{ ref('stg_gsc_shipping_rates') }}
    UNION
    SELECT congestion_date AS full_date
    FROM {{ ref('int_gsc_port_stress') }}
)

SELECT
    full_date AS date_key,
    full_date,
    CAST(strftime('%Y', full_date) AS INTEGER) AS "year",
    CAST(strftime('%m', full_date) AS INTEGER) AS month,
    CASE
        WHEN CAST(strftime('%m', full_date) AS INTEGER) BETWEEN 1 AND 3 THEN 1
        WHEN CAST(strftime('%m', full_date) AS INTEGER) BETWEEN 4 AND 6 THEN 2
        WHEN CAST(strftime('%m', full_date) AS INTEGER) BETWEEN 7 AND 9 THEN 3
        ELSE 4
    END AS quarter
FROM dates
WHERE full_date IS NOT NULL