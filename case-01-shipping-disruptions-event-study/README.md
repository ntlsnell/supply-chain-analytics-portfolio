# Case 01 — Global Shipping Disruptions: 25-Year Event Study
## ✨ Dashboard
[![Dashboard Preview](https://github.com/ntlsnell/supply-chain-analytics-portfolio/blob/main/case-01-shipping-disruptions-event-study/dashboards/shipping-disruptions-event-study.png?raw=true)](https://public.tableau.com/views/GlobalShippingDisruptions25YearEventStudy/Dashboard1)
🔗 [View Live Interactive Dashboard on Tableau Public](https://public.tableau.com/views/GlobalShippingDisruptions25YearEventStudy/Dashboard1)
## ✨ Business Context
Event study of 58 major supply chain disruptions over 25 years (2001–2025) — pandemics, geopolitical conflicts, tariff wars, natural disasters, financial crises — and their measurable impact on global container shipping rates. For each extreme event, the analysis compares average container rates ($/40ft) in the 3 months before vs 3 months after, quantifying both the shock magnitude and the recovery time by disruption type.
## ✨ Methodology Note
- **Data verification first**: container rates in the dataset were verified against real Freightos (FBX) history — the $11,340 peak in September 2021 matches reality. The Baltic Dry Index column was excluded from the analysis: its historical shape is stylised (the 2008 supercycle is missing)
- **14 raw disruption types grouped into 8 families** for readable analysis (e.g., geopolitical + political → Geopolitical)
- **Event-study window**: ±3 months around the event month; events after 2024-09 excluded (rate data ends 2024-12, no full after-window)
- **Weighted averages computed in SQL**, not in the BI layer — averaging pre-aggregated group means would inflate Policy & Tariff recovery from 17.4 to 18.9 months (a classic average-of-averages trap)
- Some effects materialise outside the ±3m window: Red Sea attacks (Dec 2023) show only +0.5% in-window, while the rate spike arrived in mid-2024 — a reminder that fixed windows can miss delayed impacts
## ✨ Key Insights
- **Policy pain lasts 9x longer than physical shocks** — natural & energy disruptions recover in 1.9 months on average, policy & tariff disruptions take 17.4 months
- **The COVID escalation chain is visible in rates**: Wuhan lockdown +30.2% → pandemic declared +61.0% → PPE crisis +60.7% → container equipment shortage +20.4% → post-COVID demand surge +30.7% → peak $11,377/40ft (Nov 2021)
- **The deflation was as sharp as the inflation** — Shanghai lockdown (−30.7%) and the Russia commodity shock (−15.4%) mark the turn; by 2024 rates normalised to ~$2,500
- **Logistics & demand shocks hit rates hardest** — average absolute rate impact of 76.3%, vs 13.3% for geopolitical events
- **Geopolitical disruptions are the most frequent** (12 of 58 events) but individually milder — frequency, not magnitude, is their risk profile
- **A 25-year perspective**: container rates spent two decades in a $1,600–$3,000 band; COVID compressed a decade of volatility into 30 months
## ✨ Tools Used
- SQL (SQLite) — event-study window joins, CASE-based type grouping, weighted aggregation
- Tableau Public — interactive dashboard with 4 visualizations (dual-axis timeline with event markers, diverging bars)
- GitHub — version control and portfolio hosting
## ✨ SQL Queries
- [Disruption Landscape — 8 Families](sql/01_disruption_landscape.sql)
- [Container Rate Event Study — 3m Before vs After](sql/02_event_study_container_rates.sql)
- [Recovery Time by Family & Severity](sql/03_recovery_analysis.sql)
- [25-Year Rates Timeline with Event Markers](sql/04_rates_timeline.sql)
## ✨ Visualizations
1. 25 Years of Container Rates — dual-axis line chart with 13 extreme events marked directly on the rate curve
2. Container Rate Shocks — diverging bar chart, 3 months before vs after each extreme event
3. Disruption Landscape — 58 events grouped into 8 families by frequency
4. Recovery Time by Family — the 9x policy-vs-physical contrast
## ✨ Dataset
Source: [Global Supply Chain & Trade Disruptions — 25 Years (Kaggle)](https://www.kaggle.com/datasets/sergionefedov/global-supply-chain-and-trade-disruptions-25-years)
Tables used: shipping_rates (300 monthly rows, 2000–2024) + disruption_events (58 events, 2001–2025)
Note: synthetic dataset built on real event anchors; rate series verified against public freight-rate history before use
