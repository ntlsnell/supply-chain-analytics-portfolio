-- ============================================================
-- Case 05 — AI Boom & the Memory Crisis
-- Query 04: Who Pays for the Shortage — Segment x Generation
-- Source:   Dataset 2 (Memory Crisis), 10,000 memory kits
-- Output:   4_case_5.csv
-- ============================================================
-- Verified results (avg price per GB / avg kit price / shortage share):
--   Enterprise/AI  DDR6 preview  $147.75 | $20,784 | 66.1%
--   Consumer       DDR6 preview   $84.67 |  $2,709 | 58.5%
--   Enterprise/AI  DDR5           $36.60 |  $7,228 | 65.0%
--   Consumer       DDR5           $20.77 |    $666 | 52.5%
--   Enterprise/AI  DDR4           $16.62 |  $1,440 | 65.6%
--   Consumer       DDR4            $9.40 |    $176 | 52.5%
--
-- Two findings: enterprise pays a consistent ~1.8x premium per GB
-- at every generation, and enterprise kits are shortage-priced
-- ~13 p.p. more often than consumer ones — scarce supply is
-- allocated to the buyers who will pay for it.
-- Cells below 50 kits excluded as statistically thin.
-- ============================================================

SELECT
    market_segment,
    generation,
    COUNT(*)                    AS kits,
    ROUND(AVG(price_per_gb), 2) AS avg_price_per_gb,
    ROUND(AVG(price_usd), 0)    AS avg_kit_price_usd,
    ROUND(SUM(CASE WHEN price_status = 'Shortage-Inflated' THEN 1.0 ELSE 0 END)
        * 100.0 / COUNT(*), 1)  AS shortage_inflated_pct
FROM memory_crisis
WHERE substr(timestamp, 1, 7) < '2027-01'
GROUP BY market_segment, generation
HAVING COUNT(*) >= 50
ORDER BY avg_price_per_gb DESC;
