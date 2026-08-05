-- ============================================================
-- Case 02 — Tariff Wars & Trade Flow Shifts
-- Query 01: Tariff Policy Eras — Trump 1.0 / Biden / Trump 2.0
-- Source:   Dataset 1, table: tariff_timeline (71 events, 2018+)
-- Output:   1_case_2.csv
-- ============================================================
-- Verified results:
--   Trump 1.0 (2018-20): 18 events | avg 31.4% | max 212% | 4 retaliations
--   Biden (2021-24):     11 events | avg 23.0% | max 100% | 0 retaliations
--   Trump 2.0 (2025+):   42 events | avg 28.8% | max 145% | 6 retaliations
-- Key insight: Trump 2.0 fired 42 tariff actions in ~1.5 years —
-- more than both previous eras combined. The regime change is
-- frequency, not just rates.
-- NOTE: estimated_value_usd_bn is not populated for 2025+ events,
-- so era comparison deliberately avoids that column.
-- ============================================================

SELECT
    CASE WHEN is_trump_1_0 = 1 THEN '1. Trump 1.0 (2018-20)'
         WHEN is_biden = 1     THEN '2. Biden (2021-24)'
         WHEN is_trump_2_0 = 1 THEN '3. Trump 2.0 (2025+)'
         ELSE '0. Other' END       AS tariff_era,
    COUNT(*)                       AS tariff_events,
    ROUND(AVG(tariff_rate_pct), 1) AS avg_tariff_rate_pct,
    MAX(tariff_rate_pct)           AS max_tariff_rate_pct,
    SUM(is_retaliation)            AS retaliation_events,
    SUM(is_section_301)            AS section_301_events,
    SUM(is_section_232)            AS section_232_events
FROM tariff_timeline
GROUP BY 1
ORDER BY 1;
