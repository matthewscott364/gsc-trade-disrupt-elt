SELECT 
    "year",
    total_disruptions,
    avg_disruption_severity,
    avg_freight_rate_shock_pct,
    avg_trade_risk_score,
    avg_industry_vulnerability,
    total_trade_value_usd,
    avg_congestion_pressure_score,
    avg_port_utilization_pct,
    global_supply_chain_risk_score,
    CASE 
        WHEN global_supply_chain_risk_score >= 75 THEN 'critical'
        WHEN global_supply_chain_risk_score >= 50 THEN 'high'
        WHEN global_supply_chain_risk_score >= 25 THEN 'moderate'
        ELSE 'low'
    END AS global_risk_tier
FROM {{ ref('int_gsc_health') }}

