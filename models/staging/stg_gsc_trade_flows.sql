SELECT 
    "year",
    UPPER(exporter_country) AS exporter_country,
    UPPER(importer_country) AS importer_country,
    exporter_country || ' -> ' || importer_country AS trade_lane,
    industry_sector,
    CAST(trade_value_usd AS NUMERIC) AS trade_value_usd,
    CAST(import_dependency_pct AS NUMERIC) AS import_dependency_pct,
    CAST(export_dependency_pct AS NUMERIC) AS export_dependency_pct,
    CASE
        WHEN import_dependency_pct >= 70 THEN 'high_dependency'
        WHEN import_dependency_pct >= 40 THEN 'medium_dependency'
        ELSE 'low_dependency'
    END AS dependency_risk
FROM {{ source('cleaned_data', 'gsc_trade_flows_clean') }}