-- ============================================================
-- Case 02 — Tariff Wars & Trade Flow Shifts
-- Query 03: US Import Corridors — Winners & Losers, 2017 vs 2024
-- Source:   Dataset 1, table: trade_flows
-- Output:   3_case_2.csv
-- ============================================================
-- Verified results (corridor value change 2017 -> 2024):
--   Mexico   +27.8%  ($398B -> $508B)  <- biggest winner
--   Japan    +16.4%
--   Vietnam  +13.0%
--   Colombia +12.5%
--   ...
--   China    -12.5%  ($146B -> $128B)  <- the only decline
-- China is the ONLY corridor that shrank — trade rerouted, it
-- didn't disappear.
-- ============================================================

SELECT
    exporter,
    trade_category,
    ROUND(SUM(CASE WHEN year = 2017 THEN trade_value_bn_usd END), 1) AS value_2017_bn,
    ROUND(SUM(CASE WHEN year = 2024 THEN trade_value_bn_usd END), 1) AS value_2024_bn,
    ROUND(SUM(CASE WHEN year = 2024 THEN trade_value_bn_usd END) * 100.0
        / SUM(CASE WHEN year = 2017 THEN trade_value_bn_usd END) - 100, 1) AS change_pct
FROM trade_flows
WHERE importer = 'USA'
GROUP BY exporter, trade_category
ORDER BY change_pct DESC;
