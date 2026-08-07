-- ============================================================
-- Case 05 — AI Boom & the Memory Crisis  [CROSS-DATASET]
-- Query 01: AI Chip Demand vs Consumer Memory Market
-- Sources:  Dataset 5 (Global Semiconductor) -> ai_chip_market
--           Dataset 2 (Memory Crisis)        -> memory_crisis
-- Output:   1_case_5.csv
-- ============================================================
-- THE FLAGSHIP QUERY of this portfolio: it joins two independent
-- Kaggle datasets on their only shared dimension — the calendar
-- year — to trace one causal chain end to end.
--
-- HBM demand is derived, not given: shipments x memory_gb per chip,
-- converted to petabytes. That single expression turns an AI-market
-- table into a memory-supply pressure metric.
--
-- Verified results:
--  year | AI chips  | HBM PB | $/GB  | fab util | inv weeks | shortage
--  2024 | 4,904,042 | 384.5  | 11.66 |  57.4%   |   13.0    |   0.0%
--  2025 | 4,876,006 | 450.3  | 30.19 |  72.4%   |    9.0    |  84.9%
--  2026 | 2,935,334 | 285.0  | 53.98 |  87.6%   |    5.0    |  97.8%
--
-- Reading: AI shipments plateau after 2024, but HBM demand keeps
-- climbing (more memory per chip), fabs fill up, inventory drains,
-- and consumer memory prices multiply 4.6x while the share of
-- shortage-inflated listings goes from zero to near-total.
--
-- NOTE: 2027-01 excluded — only 5 records, a partial month that
-- would distort the yearly average.
-- ============================================================

WITH ai_demand AS (
    SELECT
        year,
        SUM(estimated_shipments_units)                                   AS ai_chips_shipped,
        ROUND(SUM(estimated_shipments_units * memory_gb) / 1000000.0, 1) AS hbm_demand_pb,
        ROUND(SUM(estimated_revenue_usd_m) / 1000.0, 1)                  AS ai_revenue_bn
    FROM ai_chip_market
    GROUP BY year
),

memory_market AS (
    SELECT
        CAST(substr(timestamp, 1, 4) AS INTEGER)  AS year,
        COUNT(*)                                  AS kits_tracked,
        ROUND(AVG(price_per_gb), 2)               AS avg_price_per_gb,
        ROUND(AVG(fab_utilization_rate) * 100, 1) AS avg_fab_utilization_pct,
        ROUND(AVG(global_inventory_weeks), 1)     AS avg_inventory_weeks,
        ROUND(SUM(CASE WHEN price_status = 'Shortage-Inflated' THEN 1.0 ELSE 0 END)
            * 100.0 / COUNT(*), 1)                AS shortage_inflated_pct
    FROM memory_crisis
    WHERE substr(timestamp, 1, 7) < '2027-01'
    GROUP BY 1
)

SELECT
    a.year,
    a.ai_chips_shipped,
    a.hbm_demand_pb,
    a.ai_revenue_bn,
    m.avg_price_per_gb,
    m.avg_fab_utilization_pct,
    m.avg_inventory_weeks,
    m.shortage_inflated_pct
FROM ai_demand a
INNER JOIN memory_market m ON m.year = a.year
ORDER BY a.year;
