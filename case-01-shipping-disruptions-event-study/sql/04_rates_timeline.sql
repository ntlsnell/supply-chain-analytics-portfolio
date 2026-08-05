-- ============================================================
-- Case 01 — Global Shipping Disruptions: 25-Year Event Study
-- Query 04: 25-Year Rates Timeline with Extreme Event Markers
-- Source:   Dataset 1, tables: shipping_rates + disruption_events
-- Output:   4_case_1.csv
-- ============================================================
-- 300 monthly rows (2000-01 ... 2024-12), 13 months flagged with
-- extreme events. Container rate journey: ~$1,600 baseline ->
-- $11,340 peak (2021-09) -> ~$2,500 normalisation (2024).
-- NOTE: baltic_dry_index intentionally NOT used — its historical
-- shape in this dataset is stylised (2008 supercycle missing).
-- Container rates verified against real FBX history.
-- ============================================================

WITH extreme_months AS (
    SELECT substr(date,1,7)                    AS event_month,
           GROUP_CONCAT(event_name, ' | ')     AS extreme_events
    FROM disruption_events
    WHERE severity = 'extreme'
    GROUP BY 1
)

SELECT
    r.date,
    r.container_rate_usd_40ft,
    r.supply_chain_pressure_index,
    ROUND(r.on_time_delivery_pct * 100, 1)                AS on_time_delivery_pct,
    CASE WHEN e.event_month IS NOT NULL THEN 1 ELSE 0 END AS has_extreme_event,
    e.extreme_events
FROM shipping_rates r
LEFT JOIN extreme_months e ON e.event_month = r.date
ORDER BY r.date;
