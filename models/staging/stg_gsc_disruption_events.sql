SELECT 
    CAST("date" AS DATE) AS disruption_date,
    "year",
    LOWER(disruption_type) AS disruption_type,
    LOWER(region_affected) AS region_affected,
    duration_days,
    severity,
    CAST(is_pandemic AS BOOLEAN) AS is_pandemic,
    CAST(is_geopolitical AS BOOLEAN) AS is_geopolitical,
    CAST(port_closure AS BOOLEAN) AS port_closure,
    freight_cost_impact_pct,
    trade_volume_impact_pct
FROM {{ source('cleaned_data', 'gsc_disruption_events_clean') }}