-- ============================================================
-- Case 01 — Global Shipping Disruptions: 25-Year Event Study
-- Query 03: Recovery Time by Disruption Family & Severity
-- Source:   Dataset 1, table: disruption_events
-- Output:   3_case_1.csv
-- ============================================================
-- Key verified contrast:
--   Natural & Energy   avg recovery  1.9 months (fast physical shocks)
--   Policy & Tariff    avg recovery 17.4 months (slow-burn policy pain)
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
    severity,
    COUNT(*)                        AS events,
    ROUND(AVG(recovery_months), 1)  AS avg_recovery_months
FROM disruption_events
GROUP BY 1, 2
ORDER BY 1, 2;
