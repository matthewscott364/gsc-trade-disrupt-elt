-- This model transforms the cleaned GSC trade flows data into a staging table with standardized formats and additional calculated fields for analysis.
SELECT 
    "year",
    "year" AS trade_year,
    UPPER(exporter) AS exporter_country,
    UPPER(importer) AS importer_country,
    UPPER(exporter) || ' -> ' || UPPER(importer) AS trade_lane,
    trade_category AS industry_sector,
    CAST(trade_value_bn_usd AS NUMERIC) * 1000000000 AS trade_value_usd,
    CAST(concentration_risk AS NUMERIC) * 100 AS import_dependency_pct,
    CAST(concentration_risk AS NUMERIC) * 100 AS export_dependency_pct,
    CASE
        WHEN concentration_risk >= 0.70 THEN 'high_dependency'
        WHEN concentration_risk >= 0.40 THEN 'medium_dependency'
        ELSE 'low_dependency'
    END AS dependency_risk
FROM {{ source('cleaned_data', 'gsc_trade_flows_clean') }}