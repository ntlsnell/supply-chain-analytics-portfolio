-- ============================================================
-- Case 03 — Boeing vs Airbus: A Duopoly Under Stress
-- Query 04: Airline Resilience by Business Model
-- Source:   Dataset 4, table: airline_financials (30 airlines)
-- Output:   4_case_3.csv
-- ============================================================
-- Verified results (avg operating margin %):
--                2019    2020    2024
--   legacy        5.9   -35.3     7.4   (22 airlines, $522bn revenue 2024)
--   low_cost     11.1   -34.2    11.9   ( 7 airlines,  $79bn)
--   regional      8.8   -36.6    12.6   ( 1 airline,   $11bn)
-- COVID hit every model equally hard (~-35% margins), but low-cost
-- carriers entered the crisis twice as profitable as legacy and
-- exited it still ahead.
-- NOTE: margins here are modeled around real anchor points; the
-- MODEL-LEVEL CONTRAST is the analytical signal, not exact values.
-- ============================================================

SELECT
    business_model,
    COUNT(DISTINCT airline_name) AS airlines,
    ROUND(AVG(CASE WHEN year = 2019 THEN operating_margin_pct END), 1) AS margin_2019,
    ROUND(AVG(CASE WHEN year = 2020 THEN operating_margin_pct END), 1) AS margin_2020,
    ROUND(AVG(CASE WHEN year = 2024 THEN operating_margin_pct END), 1) AS margin_2024,
    ROUND(SUM(CASE WHEN year = 2019 THEN revenue_usd_bn END), 0)       AS revenue_2019_bn,
    ROUND(SUM(CASE WHEN year = 2020 THEN revenue_usd_bn END), 0)       AS revenue_2020_bn,
    ROUND(SUM(CASE WHEN year = 2024 THEN revenue_usd_bn END), 0)       AS revenue_2024_bn
FROM airline_financials
GROUP BY business_model
ORDER BY revenue_2024_bn DESC;
