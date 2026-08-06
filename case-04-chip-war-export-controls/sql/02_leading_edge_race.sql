-- ============================================================
-- Case 04 — The Chip War: Export Controls & Fab Capacity Race
-- Query 02: Leading-Edge Capacity Race by Country (<= 7nm)
-- Source:   Dataset 5, table: fab_capacity
-- Output:   2_case_4.csv
-- ============================================================
-- Uses a WINDOW FUNCTION to compute each country's share of global
-- leading-edge capacity per year:
--   SUM(SUM(x)) OVER (PARTITION BY year)
--
-- Verified results (Taiwan's share of global <=7nm capacity):
--   2019: 56.4%  |  2023: 63.9% (peak concentration)
--   2024: 58.0%  |  2026: 44.4% (diversification finally arrives)
-- Wafer capacity, monthly, 300mm equivalent:
--   2024: TWN 360,707 | KOR 236,464 | USA 19,876 | CHN 5,084
--   2026: TWN 450,218 | KOR 308,401 | USA 169,006 | ISR 47,022 | CHN 15,954
-- Key insight: CHIPS Act money shows up as a capacity step-change
-- only in 2025-26 — US leading-edge capacity grows 8.5x from 2024,
-- but Taiwan still holds nearly half of global leading-edge output.
-- ============================================================

SELECT
    year,
    country_iso3,
    SUM(monthly_wafer_capacity) AS leading_edge_capacity,
    ROUND(SUM(monthly_wafer_capacity) * 100.0
        / SUM(SUM(monthly_wafer_capacity)) OVER (PARTITION BY year), 1) AS share_of_global_pct
FROM fab_capacity
WHERE process_node_nm <= 7
  AND year >= 2019
GROUP BY year, country_iso3
HAVING SUM(monthly_wafer_capacity) > 0
ORDER BY year, leading_edge_capacity DESC;
