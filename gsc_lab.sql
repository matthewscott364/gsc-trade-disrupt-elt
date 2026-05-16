-- TESTING QUERIES HERE
SELECT
	year,
	UPPER(exporter) AS exporter_country,
	UPPER(importer) AS importer_country,
	UPPER(exporter) || ' -> ' || UPPER(importer) AS trade_lane,
	trade_category AS industry_sector,
	CAST(trade_value_bn_usd AS NUMERIC) * 1000000000 AS trade_value_usd
FROM gsc_trade_flows_clean
LIMIT 5;