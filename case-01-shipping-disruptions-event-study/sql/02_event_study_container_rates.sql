-- ============================================================
-- Case 01 — Global Shipping Disruptions: 25-Year Event Study
-- Query 02: Container Rate Event Study — 3m before vs 3m after
-- Source:   Dataset 1, tables: disruption_events + shipping_rates
-- Output:   2_case_1.csv
-- ============================================================
-- For each EXTREME event, compares avg container rate ($/40ft)
-- in the 3 months before vs 3 months after the event month.
-- Events after 2024-09 excluded (rates end 2024-12 -> no full
-- after-window).
--
-- Verified results (13 events) — the COVID escalation chain:
--   Wuhan lockdown        2020-01   +30.2%
--   Pandemic declared     2020-03   +61.0%
--   PPE crisis            2020-04   +60.7%
--   Post-COVID surge      2021-01   +30.7%
--   FBX peak $11,377      2021-11    +8.0%
--   Shanghai lockdown     2022-04   -30.7%  (deflation begins)
-- ============================================================

WITH ev AS (
    SELECT event_name, substr(date,1,7) AS event_month, date
    FROM disruption_events
    WHERE severity = 'extreme'
      AND substr(date,1,7) <= '2024-09'
)

SELECT
    ev.event_name,
    ev.event_month,
    ROUND(AVG(CASE WHEN r.date >= strftime('%Y-%m', date(ev.date, '-3 months'))
                    AND r.date <  ev.event_month
              THEN r.container_rate_usd_40ft END), 0) AS rate_3m_before,
    ROUND(AVG(CASE WHEN r.date >  ev.event_month
                    AND r.date <= strftime('%Y-%m', date(ev.date, '+3 months'))
              THEN r.container_rate_usd_40ft END), 0) AS rate_3m_after,
    ROUND((AVG(CASE WHEN r.date >  ev.event_month
                     AND r.date <= strftime('%Y-%m', date(ev.date, '+3 months'))
               THEN r.container_rate_usd_40ft END)
         / AVG(CASE WHEN r.date >= strftime('%Y-%m', date(ev.date, '-3 months'))
                     AND r.date <  ev.event_month
               THEN r.container_rate_usd_40ft END) - 1) * 100, 1) AS rate_change_pct

FROM ev
JOIN shipping_rates r
  ON r.date >= strftime('%Y-%m', date(ev.date, '-3 months'))
 AND r.date <= strftime('%Y-%m', date(ev.date, '+3 months'))
GROUP BY ev.event_name, ev.event_month
ORDER BY ev.event_month;
