-- ============================================================
-- Case 05 — AI Boom & the Memory Crisis
-- Query 03: HBM vs Commodity DRAM — The Great Divergence
-- Source:   Dataset 5 (Global Semiconductor), table: chip_prices
-- Output:   3_case_5.csv
-- ============================================================
-- Conditional pivot turns a long price table into two comparable
-- series and derives the premium multiple between them.
--
-- Verified results:
--   2022-01: HBM3 $188.37 | DDR4 $3.93 | premium  48x
--   2026-04: HBM3 $840.99 | DDR4 $2.19 | premium 384x
--
-- The two memory markets moved in opposite directions: HBM prices
-- 4.5x while commodity DRAM nearly halved. Same fabs, same wafers,
-- opposite economics — which is exactly why capacity migrated.
-- ============================================================

SELECT
    year_month,
    ROUND(MAX(CASE WHEN product = 'HBM3_stack'    THEN price END), 2) AS hbm3_stack_usd,
    ROUND(MAX(CASE WHEN product = 'DRAM_DDR4_8Gb' THEN price END), 2) AS dram_ddr4_usd,
    ROUND(MAX(CASE WHEN product = 'HBM3_stack'    THEN price END)
        / NULLIF(MAX(CASE WHEN product = 'DRAM_DDR4_8Gb' THEN price END), 0), 0) AS hbm_premium_multiple
FROM chip_prices
WHERE product IN ('HBM3_stack', 'DRAM_DDR4_8Gb')
  AND year_month >= '2022-01'
GROUP BY year_month
HAVING hbm3_stack_usd IS NOT NULL
ORDER BY year_month;
