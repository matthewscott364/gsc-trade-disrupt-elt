-- This model creates the fact table for supply chain disruptions, consolidating key attributes and metrics for analysis.
SELECT 
    id AS disruption_id,
    disruption_date,
    disruption_year,
    disruption_type,
    region_affected,
    duration_days,
    severity,
    is_pandemic,
    is_geopolitical,
    port_closure,
    freight_cost_impact_pct,
    trade_volume_impact_pct
FROM {{ ref('stg_gsc_disruption_events') }}
