WITH industries AS (
    SELECT industry
    FROM {{ ref('stg_gsc_industry_exposure') }}
    UNION
    SELECT trade_category AS industry
    FROM {{ ref('stg_gsc_trade_flows') }}
)

SELECT
    LOWER(industry) AS industry_key,
    industry,
    LOWER(industry) AS normalized_industry_name
FROM industries
WHERE industry IS NOT NULL