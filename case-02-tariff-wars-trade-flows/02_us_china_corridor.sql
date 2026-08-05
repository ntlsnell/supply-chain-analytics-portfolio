-- ============================================================
-- Case 02 — Tariff Wars & Trade Flow Shifts
-- Query 02: China -> USA Corridor, 2000-2024
-- Source:   Dataset 1, table: trade_flows
-- Output:   2_case_2.csv
-- ============================================================
-- The manufacturing corridor (electronics, machinery, textiles)
-- under escalating tariffs:
--   effective tariff: 2.5% (2000-17) -> 12% (2018) -> 22% (2019+)
--   corridor value:   $146B (2017) -> $124B (2018) -> $128B (2024)
-- The corridor never recovered its pre-tariff level.
-- NOTE: each exporter-importer pair in this dataset is a single
-- CATEGORY corridor, not total bilateral trade — dynamics are
-- meaningful, absolute totals are not.
-- ============================================================

SELECT
    year,
    trade_value_bn_usd,
    yoy_growth_pct,
    effective_tariff_rate_pct
FROM trade_flows
WHERE exporter = 'China' AND importer = 'USA'
ORDER BY year;
