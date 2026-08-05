-- ============================================================
-- Case 02 — Tariff Wars & Trade Flow Shifts
-- Query 04: Did Tariffs Bite? Growth Before vs During Tariff Era
-- Source:   Dataset 1, table: trade_flows
-- Output:   4_case_2.csv
-- ============================================================
-- Difference-in-differences style comparison:
--                              2010-2017   2018-2024
--   All other -> USA corridors    +2.1%       +1.7%   (stable)
--   China -> USA (tariffed)       +1.7%       -1.5%   (flipped!)
-- The tariffed corridor went from growth to contraction while
-- every other US corridor barely changed — the impact is
-- target-specific, not a general trade slowdown.
-- ============================================================

SELECT
    CASE WHEN exporter = 'China' THEN 'China -> USA (tariffed)'
         ELSE 'All other -> USA corridors' END AS corridor_group,
    '2010-2017 (pre-tariff)' AS period,
    ROUND(AVG(yoy_growth_pct), 1) AS avg_yoy_growth_pct
FROM trade_flows
WHERE importer = 'USA' AND year BETWEEN 2010 AND 2017
GROUP BY 1

UNION ALL

SELECT
    CASE WHEN exporter = 'China' THEN 'China -> USA (tariffed)'
         ELSE 'All other -> USA corridors' END,
    '2018-2024 (tariff era)',
    ROUND(AVG(yoy_growth_pct), 1)
FROM trade_flows
WHERE importer = 'USA' AND year BETWEEN 2018 AND 2024
GROUP BY 1

ORDER BY corridor_group, period;
