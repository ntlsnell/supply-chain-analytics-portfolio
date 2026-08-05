-- ============================================================
-- Case 01 — Global Shipping Disruptions: 25-Year Event Study
-- Query 01: Disruption Landscape — 58 events, 8 families
-- Source:   Dataset 1 (Global Supply Chain & Trade Disruptions)
--           table: disruption_events
-- Output:   1_case_1.csv
-- ============================================================
-- Verified results (58 events, 2001-2025):
--   Geopolitical          12 events | avg shock 13.3% | recovery  8.9 m
--   Policy & Tariff       10 events | avg shock  9.2% | recovery 17.4 m  <- slowest!
--   Logistics & Demand     8 events | avg shock 76.3% | recovery  8.8 m  <- hardest hit
--   Pandemic               6 events | avg shock 49.2% | recovery  3.2 m
--   Natural & Energy       8 events | avg shock 16.9% | recovery  1.9 m  <- fastest
-- Key insight: sharp physical shocks recover fast; policy-driven
-- disruptions are smaller but last ~9x longer.
-- ============================================================

SELECT
    CASE
        WHEN disruption_type = 'pandemic'                      THEN 'Pandemic'
        WHEN disruption_type IN ('geopolitical','political')   THEN 'Geopolitical'
        WHEN disruption_type IN ('financial','economic')       THEN 'Financial & Economic'
        WHEN disruption_type IN ('logistics','demand')         THEN 'Logistics & Demand'
        WHEN disruption_type IN ('natural','energy')           THEN 'Natural & Energy'
        WHEN disruption_type IN ('labor','social')             THEN 'Labor & Social'
        WHEN disruption_type IN ('policy','tariff')            THEN 'Policy & Tariff'
        ELSE 'Cyber'
    END AS disruption_family,
    COUNT(*)                                              AS events,
    SUM(CASE WHEN severity = 'extreme' THEN 1 ELSE 0 END) AS extreme_events,
    ROUND(AVG(ABS(freight_rate_shock_pct)), 1)            AS avg_abs_freight_shock_pct,
    ROUND(AVG(recovery_months), 1)                        AS avg_recovery_months
FROM disruption_events
GROUP BY 1
ORDER BY events DESC;
