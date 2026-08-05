# Case 02 — Tariff Wars & Trade Flow Shifts
## ✨ Dashboard
[![Dashboard Preview](https://github.com/ntlsnell/supply-chain-analytics-portfolio/blob/main/case-02-tariff-wars-trade-flows/dashboards/tariff-wars-trade-flows.png?raw=true)](https://public.tableau.com/views/TariffWarsTradeFlowShifts/Dashboard1)
🔗 [View Live Interactive Dashboard on Tableau Public](https://public.tableau.com/views/TariffWarsTradeFlowShifts/Dashboard1)
## ✨ Business Context
Analysis of how three waves of US tariff policy (Trump 1.0, Biden, Trump 2.0) reshaped trade flows across 50 international corridors over 25 years. The case tracks 71 real tariff policy events — Section 232, Section 301, IEEPA actions and retaliations — against yearly corridor-level trade values, quantifying who lost, who gained, and whether tariffs actually changed trade trajectories.
## ✨ Methodology Note
- **Corridor-level data, not total bilateral trade**: each exporter-importer pair in the dataset represents a single category corridor (e.g., China → USA covers the manufacturing corridor: electronics, machinery, textiles). Time dynamics and cross-period comparisons are meaningful; absolute values are not country totals
- **Difference-in-differences framing**: the tariff impact query compares growth of the tariffed corridor (China → USA) against all other US corridors, before (2010–2017) vs during (2018–2024) the tariff era — isolating target-specific impact from general trade slowdown
- **Era comparison avoids the estimated_value column** — it is not populated for 2025+ events, so comparing eras on covered trade value would understate Trump 2.0
- Tariff policy events are real (Federal Register / BIS anchors); trade values are modeled around real corridor dynamics
## ✨ Key Insights
- **Trump 2.0 fired 42 tariff actions in ~1.5 years — more than both previous eras combined** (Trump 1.0: 18 events over 3 years, Biden: 11 over 4). The regime change is frequency, not just rates
- **Peak rates tell their own story**: 212% max under Trump 1.0, 145% under Trump 2.0, and retaliations rose from 4 to 6 — trading partners now answer faster
- **The China corridor never recovered**: effective tariff jumped 2.5% → 12% (2018) → 22% (2019+); corridor value fell from $146B (2017) to $124B (2018) and still sat at $128B in 2024
- **China is the only shrinking corridor into the US** (−12.5% from 2017 to 2024) while Mexico grew +27.8% to $508B, Japan +16.4%, Vietnam +13.0% — trade rerouted, it didn't disappear
- **Tariffs bit their target specifically**: the China corridor flipped from +1.7% to −1.5% average annual growth under tariffs, while all other US corridors barely moved (2.1% → 1.7%)
## ✨ Tools Used
- SQL (SQLite) — era classification with policy flags, difference-in-differences aggregation, period comparisons
- Tableau Public — interactive dashboard with 4 visualizations (dual-axis tariff overlay, diverging bars)
- GitHub — version control and portfolio hosting
## ✨ SQL Queries
- [Tariff Policy Eras — Trump 1.0 / Biden / Trump 2.0](sql/01_tariff_eras.sql)
- [China → USA Corridor Under Escalating Tariffs](sql/02_us_china_corridor.sql)
- [US Import Corridors — Winners & Losers 2017 vs 2024](sql/03_us_import_shifts.sql)
- [Did Tariffs Bite? Growth Before vs During the Tariff Era](sql/04_tariff_impact_growth.sql)
## ✨ Visualizations
1. China → USA: The Corridor That Never Recovered — dual-axis chart, corridor value line against the tariff escalation area
2. Trump 2.0 — More Tariff Actions Than Both Previous Eras Combined — era comparison with rate details in tooltips
3. US Import Corridors 2017→2024: One Loser — diverging bar, 12 winners and a single decliner
4. Tariffs Flipped China Corridor Growth Negative — 2×2 difference-in-differences comparison
## ✨ Dataset
Source: [Global Supply Chain & Trade Disruptions — 25 Years (Kaggle)](https://www.kaggle.com/datasets/sergionefedov/global-supply-chain-and-trade-disruptions-25-years)
Tables used: tariff_timeline (71 policy events, 2018–2026) + trade_flows (1,250 corridor-year records, 50 corridors, 2000–2024)
Note: synthetic dataset built on real policy anchors; corridor-level values, dynamics verified against real decoupling patterns
