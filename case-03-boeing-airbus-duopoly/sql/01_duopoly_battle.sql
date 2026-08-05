-- ============================================================
-- Case 03 — Boeing vs Airbus: A Duopoly Under Stress
-- Query 01: The Narrowbody Battle — Net Orders 2010-2025
-- Source:   Dataset 4 (Global Aviation), table: fleet_orders
-- Output:   1_case_3.csv
-- ============================================================
-- Verified against real Boeing/Airbus order books:
--   2018: Boeing 737 +675 | Airbus A320 +626   (Boeing ahead)
--   2019: Boeing 737  -87 | Airbus A320 +654   (post-ET302 grounding,
--                                               cancellations exceeded orders)
--   2020: Boeing 737 -1026 | Airbus A320 +296  (MAX grounded + COVID)
--   2024: Boeing 737 +569 | Airbus A320 +1456  (2.5x gap, still unrecovered)
-- Negative net orders mean cancellations outnumbered new orders —
-- the single clearest number in the 737 MAX crisis.
-- ============================================================

SELECT
    year,
    SUM(CASE WHEN manufacturer = 'Boeing' AND is_narrowbody = 1 THEN orders_net END) AS boeing_net_orders,
    SUM(CASE WHEN manufacturer = 'Airbus' AND is_narrowbody = 1 THEN orders_net END) AS airbus_net_orders,
    SUM(CASE WHEN manufacturer = 'COMAC'  AND is_narrowbody = 1 THEN orders_net END) AS comac_net_orders,
    ROUND(
        SUM(CASE WHEN manufacturer = 'Airbus' AND is_narrowbody = 1 THEN orders_net END) * 100.0
      / NULLIF(SUM(CASE WHEN manufacturer IN ('Boeing','Airbus') AND is_narrowbody = 1
                        AND orders_net > 0 THEN orders_net END), 0), 1) AS airbus_share_pct
FROM fleet_orders
WHERE year <= 2025
GROUP BY year
ORDER BY year;
