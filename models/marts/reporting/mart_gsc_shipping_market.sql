SELECT 
    shipping_year,
    shipping_month,
    AVG(container_rate_usd) AS avg_container_rate_usd,
    AVG(baltic_dry_index) AS avg_baltic_dry_index,
    AVG(air_freight_index) AS avg_air_freight_index,
    AVG(supply_chain_pressure_index) AS avg_supply_chain_pressure_index,
    CASE 
        WHEN AVG(supply_chain_pressure_index) >= 2 THEN 'severe'
        WHEN AVG(supply_chain_pressure_index) >= 1 THEN 'elevated'
        ELSE 'normal'
    END AS freight_market_condition
FROM {{ ref('fct_shipping_metrics') }}
GROUP BY shipping_year, shipping_month