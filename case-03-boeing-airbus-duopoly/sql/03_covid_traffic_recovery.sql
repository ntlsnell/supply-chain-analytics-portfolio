-- ============================================================
-- Case 03 — Boeing vs Airbus: A Duopoly Under Stress
-- Query 03: COVID Collapse & Recovery Asymmetry by Region
-- Source:   Dataset 4, table: passenger_traffic (RPK, monthly)
-- Output:   3_case_3.csv
-- ============================================================
-- Verified results (RPK billions):
--   Asia Pacific  1,310 (2019) -> 328 (2020) = -75.0%  -> 1,808 (2024) = +38%
--   Europe        1,016 -> 271 = -73.3%  -> 1,466 = +44.3%
--   North America   830 -> 255 = -69.2%  -> 1,158 = +39.6%
--   Middle East     264 ->  71 = -73.1%  ->   400 = +51.6%  <- strongest rebound
-- Every region collapsed ~70-75%, but recovery diverged sharply:
-- the Middle East grew its 2019 baseline by half, Latin America by a third.
-- ============================================================

SELECT
    region,
    ROUND(SUM(CASE WHEN year = 2019 THEN rpk_billions END), 0) AS rpk_2019,
    ROUND(SUM(CASE WHEN year = 2020 THEN rpk_billions END), 0) AS rpk_2020,
    ROUND(SUM(CASE WHEN year = 2024 THEN rpk_billions END), 0) AS rpk_2024,
    ROUND(SUM(CASE WHEN year = 2020 THEN rpk_billions END) * 100.0
        / SUM(CASE WHEN year = 2019 THEN rpk_billions END) - 100, 1) AS covid_drop_pct,
    ROUND(SUM(CASE WHEN year = 2024 THEN rpk_billions END) * 100.0
        / SUM(CASE WHEN year = 2019 THEN rpk_billions END) - 100, 1) AS vs_2019_pct
FROM passenger_traffic
GROUP BY region
ORDER BY rpk_2019 DESC;
