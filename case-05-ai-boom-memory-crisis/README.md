# Case 05 — AI Boom & the Memory Crisis
## ✨ Dashboard
[![Dashboard Preview](https://github.com/ntlsnell/supply-chain-analytics-portfolio/blob/main/case-05-ai-boom-memory-crisis/dashboards/ai-boom-memory-crisis.png?raw=true)](https://public.tableau.com/views/AIBoomandtheMemoryCrisis/Dashboard1)
🔗 [View Live Interactive Dashboard on Tableau Public](https://public.tableau.com/views/AIBoomandtheMemoryCrisis/Dashboard1)
## ✨ Business Context
A cross-dataset analysis tracing one causal chain end to end: AI accelerator shipments consume high-bandwidth memory, HBM production consumes fab capacity, fab capacity shortages drain consumer memory inventory, and consumer memory prices multiply. The chain is built by joining two independent Kaggle datasets from different authors — one covering the semiconductor industry, one covering the consumer memory market — on their only shared dimension.
## ✨ Methodology Note
- **Cross-dataset join**: the two datasets share no keys, no IDs, and no common entities — only the calendar. The analysis aggregates the semiconductor data by year and the 10,000-record memory market data by year, then joins on that dimension. This is the central technical contribution of the case
- **HBM demand is derived, not given**: `SUM(shipments × memory_gb)` converts an AI-market table into a memory-supply pressure metric in petabytes — no such column exists in either source
- **Conditional pivot** turns the long price table into two comparable series (HBM3 vs commodity DRAM) and derives the premium multiple between them
- **Partial period excluded**: January 2027 contains only 5 records and would distort yearly averages
- **Thin cells excluded**: segment × generation combinations below 50 kits are dropped from the pricing comparison
- Both datasets are synthetic, but built on real anchors — NVIDIA shipment estimates, TrendForce contract pricing, and documented 2024–2026 memory market dynamics. The case reads *directional relationships*, not point forecasts
## ✨ Key Insights
- **The squeeze is fully visible month by month** (Jan 2024 → Dec 2026): fab utilization 50.6% → 94.3%, inventory 14.8 → 3.1 weeks, price per GB $10.87 → $60.33, and shortage-inflated listings from 0% to 98.2% — every series moves monotonically in the direction the mechanism predicts
- **Below roughly 6 weeks of inventory, shortage pricing becomes near-universal** — a threshold visible in the data rather than assumed
- **HBM demand kept climbing even as AI chip shipments plateaued**: shipments were flat between 2024 and 2025 (4.90M → 4.88M) while HBM demand grew 384 → 450 petabytes. Memory per accelerator rose from 43 GB to 286 GB — the pressure comes from appetite per chip, not chip count
- **The two memory markets moved in opposite directions**: HBM3 stacks rose from $188 to $841 (+346%) while commodity DDR4 fell from $3.93 to $2.19 (−44%). The premium widened from 48× to 384× — same fabs, same wafers, opposite economics, which is precisely why capacity migrated
- **Prices kept rising after HBM demand cooled in 2026** — drained inventory takes longer to rebuild than demand takes to fall
- **Enterprise buyers pay a consistent ~1.8× premium per GB at every generation** (DDR4 $16.62 vs $9.40, DDR5 $36.60 vs $20.77, DDR6 preview $147.75 vs $84.67) and are shortage-priced 13 percentage points more often — scarce supply flows to whoever will pay for it
## ✨ Tools Used
- SQL (SQLite) — cross-dataset CTE join, derived demand metrics, conditional pivots, multi-dimensional aggregation
- Tableau Public — interactive dashboard with 4 visualizations (dual-axis scissors chart, combined bar/line, area with trend line, grouped comparison)
- GitHub — version control and portfolio hosting
## ✨ SQL Queries
- [AI Chip Demand vs Consumer Memory Market — cross-dataset join](sql/01_ai_demand_vs_memory_market.sql)
- [The Squeeze — Monthly Fab Utilization, Inventory, Price](sql/02_the_squeeze_monthly.sql)
- [HBM vs Commodity DRAM — The Great Divergence](sql/03_hbm_vs_commodity_dram.sql)
- [Who Pays for the Shortage — Segment × Generation](sql/04_who_pays.sql)
## ✨ Visualizations
1. As Inventory Drained, Memory Prices Multiplied 5× — dual-axis scissors chart; the two lines cross in mid-2025, the turning point of the market
2. HBM Demand from AI Chips vs Consumer Memory Prices — the cross-dataset result: HBM demand bars against consumer price line
3. HBM Premium Grew from 48× to 384× Commodity DRAM — premium multiple over time with a trend line showing the 2026 plateau
4. Enterprise Pays 1.8× per GB at Every Generation — segment pricing across DDR4, DDR5 and DDR6 preview
## ✨ Datasets
This case joins **two independent datasets**:
- [Global Semiconductor Industry 2010–2026 (Kaggle)](https://www.kaggle.com/datasets/sergionefedov/global-semiconductor-industry-2010-2026) — tables: ai_chip_market (AI accelerator shipments and specs), chip_prices (monthly HBM3, DRAM, GPU pricing)
- [Ultimate Memory Crisis: Hardware Market Dynamics (Kaggle)](https://www.kaggle.com/datasets/moaz1911/ultimate-memory-crisis-hardware-market-dynamics) — 10,000 memory kit records with pricing, fab utilization, inventory levels and shortage status, Jan 2024 – Dec 2026
