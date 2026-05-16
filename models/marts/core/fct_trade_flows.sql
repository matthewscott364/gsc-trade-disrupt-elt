SELECT 
    ROW_NUMBER() OVER (
        ORDER BY "year", exporter_country, importer_country, industry_sector
    ) AS trade_flow_id,
    "year" AS trade_year,
    exporter_country,
    importer_country,
    trade_lane,
    industry_sector,
    trade_value_usd,
    import_dependency_pct,
    export_dependency_pct,
    dependency_risk
FROM {{ ref('stg_gsc_trade_flows') }}