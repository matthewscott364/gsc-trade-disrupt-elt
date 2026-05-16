-- This model aggregates key metrics from the disruption impact, trade risk scores, and port stress models to create an overall GSC health score by year.
WITH disruption AS (
    SELECT 
        disruption_year AS "year",
        AVG(avg_severity) AS avg_disruption_severity,
        SUM(disruption_count) AS total_disruptions,
        AVG(avg_freight_rate_shock_pct) AS avg_freight_rate_shock_pct
    FROM {{ ref('int_gsc_disruption_impact') }}
    GROUP BY disruption_year
),

trade_risk AS (
    SELECT
        trade_year AS "year",
        AVG(trade_risk_score) AS avg_trade_risk_score,
        AVG(overall_vulnerability) AS avg_industry_vulnerability,
        SUM(trade_value_usd) AS total_trade_value_usd
    FROM {{ ref('int_gsc_trade_risk_scores') }}
    GROUP BY trade_year
),

port_stress AS (
    SELECT 
        congestion_year AS "year",
        AVG(congestion_pressure_score) AS avg_congestion_pressure_score,
        AVG(port_utilization_pct) AS avg_port_utilization_pct
    FROM {{ ref('int_gsc_port_stress') }}
    GROUP BY congestion_year
)

SELECT
    d."year",
    d.avg_disruption_severity,
    d.total_disruptions,
    d.avg_freight_rate_shock_pct,
    t.avg_trade_risk_score,
    t.avg_industry_vulnerability,
    t.total_trade_value_usd,
    p.avg_congestion_pressure_score,
    p.avg_port_utilization_pct,
    (
        COALESCE(d.avg_disruption_severity, 0) * 0.30 +
        COALESCE(t.avg_trade_risk_score, 0) * 0.30 +
        COALESCE(p.avg_congestion_pressure_score, 0) * 0.25
    ) AS global_supply_chain_risk_score
FROM disruption d
LEFT JOIN trade_risk t ON d."year" = t."year"
LEFT JOIN port_stress p ON d."year" = p."year"