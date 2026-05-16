-- This model transforms the cleaned GSC shipping rates data into a staging table with standardized formats and additional calculated fields for analysis.
SELECT 
    ROW_NUMBER() OVER (
        ORDER BY shipping_date, "route"
    ) AS shipping_metric_id,
    shipping_date,
    "year" AS shipping_year,
    "month" AS shipping_month,
    "route",
    container_rate_usd,
    baltic_dry_index,
    air_freight_index,
    supply_chain_pressure_index,
    pressure_level,
    freight_market_condition
FROM {{ ref('stg_gsc_shipping_rates') }}
