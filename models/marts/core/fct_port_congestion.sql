-- This model creates the fact table for port congestion, aggregating key metrics and indicators from the intermediate port stress data.
SELECT
    id AS port_congestion_id,
    congestion_date,
    congestion_year,
    port_name,
    region,
    vessels_waiting,
    avg_wait_days,
    port_utilization_pct,
    congestion_pressure_score,
    port_stress_level
FROM {{ ref('int_gsc_port_stress') }}