-- This model calculates trade risk scores for each trade lane and industry sector by combining trade flow data with industry exposure metrics. The resulting scores can be used to identify high-risk trade relationships and inform supply chain risk management strategies.
SELECT
    t.trade_year,
    t.exporter_country,
    t.importer_country,
    t.trade_lane,
    t.industry_sector,
    t.trade_value_usd,
    t.import_dependency_pct,
    t.export_dependency_pct,
    t.dependency_risk,
    e.region,
    e.single_source_dependency_pct,
    e.china_dependency_pct,
    e.logistics_risk_score,
    e.geopolitical_risk_score,
    e.overall_vulnerability,
    e.vulnerability_tier,
    (
        COALESCE(t.import_dependency_pct, 0) * 0.30 +
        COALESCE(e.single_source_dependency_pct, 0) * 0.25 +
        COALESCE(e.china_dependency_pct, 0) * 0.20 +
        COALESCE(e.logistics_risk_score, 0) * 0.15 +
        COALESCE(e.geopolitical_risk_score, 0) * 0.10
    ) AS trade_risk_score
FROM {{ ref('stg_gsc_trade_flows') }} t
LEFT JOIN {{ ref('stg_gsc_industry_exposure') }} e
    ON t.industry_sector = e.industry