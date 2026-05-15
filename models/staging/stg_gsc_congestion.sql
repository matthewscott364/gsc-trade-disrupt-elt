-- This model transforms the cleaned GSC congestion data into a staging table with standardized formats and additional calculated fields for analysis.
SELECT 
    CAST(week_start AS DATE) AS week_start,
    port_name,
    region,
    CAST(vessels_waiting AS INTEGER) AS vessels_waiting,
    CAST(avg_wait_days AS NUMERIC) AS avg_wait_days,
    CAST(port_utilization_pct AS NUMERIC) AS port_utilization_pct,
    vessels_waiting * avg_wait_days AS congestion_pressure_score,
    CASE
        WHEN avg_wait_days >= 10 THEN 'critical'
        WHEN avg_wait_days >= 5 THEN 'high'
        ELSE 'manageable'
    END AS congestion_status
FROM {{ source('cleaned_data', 'gsc_congestion_clean') }}
