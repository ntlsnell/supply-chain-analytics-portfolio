-- ============================================================
-- Case 03 — Boeing vs Airbus: A Duopoly Under Stress
-- Query 02: Backlog & Production Capacity
-- Source:   Dataset 4, table: fleet_orders
-- Output:   2_case_3.csv
-- ============================================================
-- Verified results (total backlog, all families):
--   2010: Boeing 3,136 | Airbus 3,216  (near parity)
--   2019: Boeing 5,706 | Airbus 6,961
--   2024: Boeing 6,876 | Airbus 9,730  (gap widened to ~2,850 aircraft)
--   COMAC C919 backlog: 815 (2018) -> 1,437 (2024)
-- years_of_backlog = backlog / annual deliveries — how many years
-- of production each manufacturer has already sold.
-- ============================================================

SELECT
    year,
    manufacturer,
    SUM(backlog_end_of_year)  AS backlog,
    SUM(deliveries)           AS deliveries,
    ROUND(SUM(backlog_end_of_year) * 1.0 / NULLIF(SUM(deliveries), 0), 1) AS years_of_backlog
FROM fleet_orders
WHERE year <= 2025
  AND manufacturer IN ('Boeing', 'Airbus', 'COMAC')
GROUP BY year, manufacturer
ORDER BY year, manufacturer;
