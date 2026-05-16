SELECT DISTINCT
    LOWER(exporter_country || '_' || importer_country) AS trade_lane_key,
    exporter_country,
    importer_country,
    trade_lane
FROM {{ ref('stg_gsc_trade_flows') }}
WHERE trade_lane IS NOT NULL