-- This model aggregates the GSC disruption events data to analyze the impact of different types of disruptions on global supply chains, including severity, duration, and economic impacts.
SELECT
    disruption_year,
    disruption_type,
    region_affected,
    COUNT(*) AS disruption_count,
    AVG(severity) AS avg_severity,
    AVG(duration_days) AS avg_duration,
    AVG(freight_cost_impact_pct) AS avg_freight_cost_impact_pct,
    AVG(trade_volume_impact_pct) AS avg_trade_volume_impact_pct,
    SUM(CASE WHEN is_pandemic THEN 1 ELSE 0 END) AS pandemic_event_count,
    SUM(CASE WHEN is_geopolitical THEN 1 ELSE 0 END) AS geopolitical_event_count,
    SUM(CASE WHEN port_closure THEN 1 ELSE 0 END) AS port_closure_count
FROM {{ ref('stg_gsc_disruption_events') }}
GROUP BY
    disruption_year,
    disruption_type,
    region_affected