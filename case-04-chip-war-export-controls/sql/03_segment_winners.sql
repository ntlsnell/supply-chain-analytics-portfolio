-- ============================================================
-- Case 04 — The Chip War: Export Controls & Fab Capacity Race
-- Query 03: Who Won the AI Era — Revenue Growth by Segment
-- Source:   Dataset 5, table: chip_companies_financials (40 companies)
-- Output:   3_case_4.csv
-- ============================================================
-- Verified results (segment revenue 2019 -> 2024):
--   fabless_gpu       $12.7bn -> $130.5bn   +930%   <- the AI trade
--   fabless_cpu_gpu    $8.2bn ->  $26.1bn   +218%
--   equipment_litho   $13.7bn ->  $31.8bn   +133%   <- ASML EUV monopoly
--   foundry           $69.0bn -> $131.1bn    +90%
--   idm_memory       $133.7bn -> $161.0bn    +20%
--   idm_cpu           $73.3bn ->  $54.4bn    -26%   <- the only decline
-- Segments below $5bn in 2019 excluded — small-base growth rates
-- would dominate the ranking without being economically meaningful.
-- Key insight: the AI boom did not lift the industry evenly. GPU
-- designers grew 10x while the CPU incumbent shrank by a quarter.
-- ============================================================

SELECT
    segment,
    ROUND(SUM(CASE WHEN year = 2019 THEN revenue_usd_bn END), 1) AS revenue_2019_bn,
    ROUND(SUM(CASE WHEN year = 2024 THEN revenue_usd_bn END), 1) AS revenue_2024_bn,
    ROUND(SUM(CASE WHEN year = 2024 THEN revenue_usd_bn END) * 100.0
        / NULLIF(SUM(CASE WHEN year = 2019 THEN revenue_usd_bn END), 0) - 100, 1) AS growth_pct,
    ROUND(AVG(CASE WHEN year = 2024 THEN operating_margin_pct END), 1) AS avg_margin_2024
FROM chip_companies_financials
WHERE year IN (2019, 2024)
GROUP BY segment
HAVING SUM(CASE WHEN year = 2019 THEN revenue_usd_bn END) > 5
ORDER BY growth_pct DESC;
