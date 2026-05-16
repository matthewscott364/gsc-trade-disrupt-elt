-- This model transforms the cleaned GSC shipping rates data into a staging table with standardized formats and additional calculated fields for analysis.
SELECT 
    CAST("date" || '-01' AS DATE) AS shipping_date,
    "year",
    "month",
    'GLOBAL' AS "route",
    'OCEAN' AS shipping_mode,
    CAST(container_rate_usd_40ft AS NUMERIC) AS container_rate_usd,
    CAST(baltic_dry_index AS NUMERIC) AS baltic_dry_index,
    CAST(air_cargo_rate_usd_kg AS NUMERIC) AS air_freight_index,
    CAST(supply_chain_pressure_index AS NUMERIC) AS supply_chain_pressure_index,
    CASE
        WHEN supply_chain_pressure_index >= 2 THEN 'severe'
        WHEN supply_chain_pressure_index >= 1 THEN 'elevated'
        ELSE 'normal'
    END AS pressure_level,
    CASE
        WHEN container_rate_usd_40ft > 10000 THEN 'extreme'
        WHEN container_rate_usd_40ft > 5000 THEN 'high'
        ELSE 'stable'
    END AS freight_market_condition
FROM {{ source('cleaned_data', 'gsc_shipping_rates_clean') }}
