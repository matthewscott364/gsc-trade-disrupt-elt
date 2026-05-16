WITH regions AS (
    SELECT region_affected AS region
    FROM {{ ref('stg_gsc_disruption_events') }}
    UNION
    SELECT region
    FROM {{ ref('stg_gsc_congestion') }}
)

SELECT
    LOWER(region) AS region_key,
    region,
    LOWER(region) AS region_normalized
FROM regions
WHERE region IS NOT NULL