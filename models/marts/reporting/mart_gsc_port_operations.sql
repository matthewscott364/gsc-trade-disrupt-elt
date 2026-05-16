SELECT 
    congestion_date,
    congestion_year,
    port_name,
    region,
    vessels_waiting,
    avg_wait_days,
    port_utilization_pct,
    congestion_pressure_score,
    port_stress_level
FROM {{ ref('fct_port_congestion') }}

