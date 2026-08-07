-- ============================================================
-- Case 05 — AI Boom & the Memory Crisis
-- Query 02: The Squeeze — Monthly Fab Utilization, Inventory, Price
-- Source:   Dataset 2 (Memory Crisis), 36 months
-- Output:   2_case_5.csv
-- ============================================================
-- The mechanism month by month, Jan 2024 -> Dec 2026:
--   fab utilization   50.6%  ->  94.3%
--   inventory weeks   14.80  ->   3.14
--   HBM per GPU (GB)   43.3  ->  286.3
--   price per GB      $10.87 -> $60.33
--   shortage-inflated   0.0% ->  98.2%
--
-- Every series moves monotonically in the direction the squeeze
-- predicts. Inventory below ~6 weeks is where shortage pricing
-- becomes near-universal.
-- ============================================================

SELECT
    substr(timestamp, 1, 7)                   AS month,
    ROUND(AVG(price_per_gb), 2)               AS avg_price_per_gb,
    ROUND(AVG(fab_utilization_rate) * 100, 1) AS fab_utilization_pct,
    ROUND(AVG(global_inventory_weeks), 2)     AS inventory_weeks,
    ROUND(AVG(gpu_hbm_trend_gb), 1)           AS hbm_per_gpu_gb,
    ROUND(SUM(CASE WHEN price_status = 'Shortage-Inflated' THEN 1.0 ELSE 0 END)
        * 100.0 / COUNT(*), 1)                AS shortage_inflated_pct
FROM memory_crisis
WHERE substr(timestamp, 1, 7) < '2027-01'
GROUP BY 1
ORDER BY 1;
