-- This model calculates port congestion and stress levels based on the number of vessels waiting, average wait times, and port utilization rates. It categorizes ports into stress levels (normal, moderate, high, critical) to help identify bottlenecks in global supply chains.
SELECT 
    week_start AS congestion_date,
    CAST(strftime('%Y', week_start) AS INTEGER) AS congestion_year,
    port AS port_name,
    region,
    vessels_waiting,
    avg_wait_days,
    port_utilization_pct,
    vessels_waiting * avg_wait_days AS congestion_pressure_score,
    CASE 
        WHEN port_utilization_pct >= 90 OR avg_wait_days >= 10 THEN 'critical'
        WHEN port_utilization_pct >= 75 OR avg_wait_days >= 5 THEN 'high'
        WHEN port_utilization_pct >= 50 THEN 'moderate'
        ELSE 'normal'
    END AS port_stress_level
FROM {{ ref('stg_gsc_congestion') }}