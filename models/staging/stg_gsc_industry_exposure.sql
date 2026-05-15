-- This model transforms the cleaned GSC industry exposure data into a staging table with standardized formats and calculated vulnerability tiers for analysis.
SELECT 
    industry,
    region,
    CAST(single_source_dependency_pct AS NUMERIC) AS single_source_dependency_pct,
    CAST(china_dependency_pct AS NUMERIC) AS china_dependency_pct,
    CAST(logistics_risk_score AS NUMERIC) AS logistics_risk_score,
    CAST(geopolitical_risk_score AS NUMERIC) AS geopolitical_risk_score,
    CAST(overall_vulnerability AS NUMERIC) AS overall_vulnerability,
    CASE
        WHEN overall_vulnerability >= 8 THEN 'critical'
        WHEN overall_vulnerability >= 6 THEN 'high'
        WHEN overall_vulnerability >= 4 THEN 'medium'
        ELSE 'low'
    END AS vulnerability_tier
FROM {{ source('cleaned_data', 'gsc_industry_exposure_clean') }}