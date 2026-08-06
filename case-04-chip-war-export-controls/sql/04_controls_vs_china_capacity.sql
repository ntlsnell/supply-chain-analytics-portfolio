-- ============================================================
-- Case 04 — The Chip War: Export Controls & Fab Capacity Race
-- Query 04: Did the Controls Work? Controls vs China Capacity
-- Source:   Dataset 5, tables: export_controls + fab_capacity
-- Output:   4_case_4.csv
-- ============================================================
-- Joins the annual control count against China's own fab capacity,
-- split into leading-edge (<=7nm, the sanctions target) and total.
--
-- Verified results:
--   year  controls  severity  CHN leading-edge  CHN total capacity
--   2018      1       5.0              0             40,586
--   2020      3       8.0              0             63,793
--   2022      4       9.0              0            349,125
--   2023      7       7.4              0            473,244
--   2024      6       6.7          5,084            490,005
--   2026      3       8.0         15,954            544,406
--
-- Key insight: the controls achieved their narrow goal and missed
-- the broad one. China's leading-edge capacity stayed at zero for
-- four years of escalation and remains marginal (16K wafers/month
-- vs Taiwan's 450K). But total Chinese capacity grew 13x over the
-- same period — the sanctions redirected China into mature nodes
-- rather than stopping its expansion.
-- ============================================================

WITH controls_by_year AS (
    SELECT
        year,
        COUNT(*)                      AS controls,
        ROUND(AVG(severity_score), 1) AS avg_severity
    FROM export_controls
    GROUP BY year
),

china_capacity AS (
    SELECT
        year,
        SUM(CASE WHEN process_node_nm <= 7 THEN monthly_wafer_capacity ELSE 0 END) AS china_leading_edge,
        SUM(monthly_wafer_capacity)                                                AS china_total_capacity
    FROM fab_capacity
    WHERE country_iso3 = 'CHN'
    GROUP BY year
)

SELECT
    c.year,
    COALESCE(ct.controls, 0) AS controls_imposed,
    ct.avg_severity,
    c.china_leading_edge,
    c.china_total_capacity
FROM china_capacity c
LEFT JOIN controls_by_year ct ON ct.year = c.year
WHERE c.year >= 2018
ORDER BY c.year;
