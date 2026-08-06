-- ============================================================
-- Case 04 — The Chip War: Export Controls & Fab Capacity Race
-- Query 01: Export Control Escalation by Policy Era
-- Source:   Dataset 5 (Global Semiconductor), table: export_controls
-- Output:   1_case_4.csv
-- ============================================================
-- Verified results (34 controls, 2018-2026):
--   Trump 1.0 (2019-20):  6 controls | avg severity 6.8 | max  9 | 6 US, 0 China
--   Biden (2021-24):     18 controls | avg severity 7.4 | max 10 | 12 US, 5 China, 1 NLD
--   Trump 2.0 (2025-26): 10 controls | avg severity 7.2 | max  9 | 8 US, 2 China
-- Key insight: the Biden era was the most aggressive phase of the
-- chip war — 3x the controls of Trump 1.0, the only period reaching
-- severity 10 (the Oct 2022 BIS package), and the only one with
-- allied participation (Netherlands / Japan equipment restrictions).
-- China's retaliation also began here: 5 counter-actions.
-- ============================================================

SELECT
    CASE WHEN is_trump_1_0 = 1 THEN '1. Trump 1.0 (2019-20)'
         WHEN is_biden = 1     THEN '2. Biden (2021-24)'
         WHEN is_trump_2_0 = 1 THEN '3. Trump 2.0 (2025-26)'
         ELSE '0. Other' END      AS policy_era,
    COUNT(*)                      AS controls,
    ROUND(AVG(severity_score), 1) AS avg_severity,
    MAX(severity_score)           AS max_severity,
    SUM(is_us_action)             AS us_actions,
    SUM(is_china_action)          AS china_actions,
    SUM(is_netherlands_action)    AS allied_actions
FROM export_controls
GROUP BY 1
ORDER BY 1;
