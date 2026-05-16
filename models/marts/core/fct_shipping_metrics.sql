-- This model transforms the cleaned GSC shipping rates data into a staging table with standardized formats and additional calculated fields for analysis.
SELECT 
    id AS shipping_metric_id,
    shipping_date,
    shipping_year,
    shipping_month,
    "route",
    shipping_mode,
    container_rate_usd,
    baltic_dry_index,
    air_freight_index,
    supply_chain_pressure_index,
    pressure_level,
    freight_market_condition
FROM {{ ref('stg_gsc_shipping_rates') }}
