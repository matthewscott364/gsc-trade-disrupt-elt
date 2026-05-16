-- This model creates the fact table for supply chain disruptions, consolidating key attributes and metrics for analysis.
SELECT 
    ROW_NUMBER() OVER (
        ORDER BY disruption_date, disruption_type, region_affected
    ) AS disruption_id,
    disruption_date,
    "year" AS disruption_year,
    disruption_type,
    region_affected,
    duration_days,
    severity,
    is_pandemic,
    is_geopolitical,
    port_closure,
    freight_rate_shock_pct,
    trade_volume_impact_pct
FROM {{ ref('stg_gsc_disruption_events') }}
