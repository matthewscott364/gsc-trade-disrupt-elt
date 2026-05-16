SELECT 
    trade_year AS "year",
    region,
    industry_sector,
    COUNT(DISTINCT trade_lane) AS trade_lane_count,
    SUM(trade_value_usd) AS total_trade_value_usd,
    AVG(overall_vulnerability) AS avg_industry_vulnerability,
    CASE
        WHEN AVG(trade_risk_score) >= 75 THEN 'critical'
        WHEN AVG(trade_risk_score) >= 50 THEN 'high'
        WHEN AVG(trade_risk_score) >= 25 THEN 'moderate'
        ELSE 'low'
    END AS risk_tier
FROM {{ ref('int_gsc_trade_risk_scores') }}
GROUP BY trade_year, region, industry_sector