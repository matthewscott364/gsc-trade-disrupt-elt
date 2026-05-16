-- This model transforms the cleaned GSC industry exposure data into a staging table with standardized formats and calculated vulnerability tiers for analysis.
SELECT 
    industry,
    'global' AS region,
    CAST(supplier_concentration_hhi AS NUMERIC) * 100 AS single_source_dependency_pct,
    CAST(just_in_time_dependency AS NUMERIC) * 100 AS china_dependency_pct,
    CAST(logistics_exposure AS NUMERIC) AS logistics_risk_score,
    CAST(geopolitical_exposure AS NUMERIC) AS geopolitical_risk_score,
    CAST(overall_vulnerability AS NUMERIC) AS overall_vulnerability,
    CASE
        WHEN overall_vulnerability >= 8 THEN 'critical'
        WHEN overall_vulnerability >= 6 THEN 'high'
        WHEN overall_vulnerability >= 4 THEN 'medium'
        ELSE 'low'
    END AS vulnerability_tier
FROM {{ source('cleaned_data', 'gsc_industry_exposure_clean') }}