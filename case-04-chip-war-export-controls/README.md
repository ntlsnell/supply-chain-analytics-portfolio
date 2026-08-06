# Case 04 — The Chip War: Export Controls & Fab Capacity Race
## ✨ Dashboard
[![Dashboard Preview](https://github.com/ntlsnell/supply-chain-analytics-portfolio/blob/main/case-04-chip-war-export-controls/dashboards/chip-war-export-controls.png?raw=true)](https://public.tableau.com/views/TheChipWarExportControlsFabCapacityRace/Dashboard1)
🔗 [View Live Interactive Dashboard on Tableau Public](https://public.tableau.com/views/TheChipWarExportControlsFabCapacityRace/Dashboard1)
## ✨ Business Context
Analysis of the US-China semiconductor conflict as a supply chain problem: 34 export control actions from the Huawei Entity List to Section 232 chip tariffs, measured against what actually happened to fab capacity, geographic concentration, and industry revenue. The central question is whether export controls achieved their objective — and the answer depends entirely on how that objective is defined.
## ✨ Methodology Note
- **Window functions for share-of-global**: `SUM(SUM(capacity)) OVER (PARTITION BY year)` computes each country's share of leading-edge output per year in a single pass, without a self-join
- **Leading-edge defined as ≤7nm** — the actual boundary of US export restrictions, which makes the sanctions target measurable rather than approximate
- **Two-table CTE join** aligns annual control counts with China's own capacity build-out, separating the sanctioned segment (≤7nm) from total capacity
- **Small-base segments excluded** from growth ranking (<$5bn revenue in 2019) — otherwise a segment growing from $0.1bn to $2bn would outrank the entire AI trade
- Company revenues, fab capacities, and control events are anchored to 10-K filings, SEMI World Fab Forecast summaries, and BIS/Federal Register notices; operating margins are modeled and used only for context
## ✨ Key Insights
- **The Biden administration ran the most aggressive phase of the chip war** — 18 control actions vs 6 under Trump 1.0, the only period reaching maximum severity (the October 2022 BIS package), the only one with allied participation (Netherlands and Japan equipment restrictions), and the first to trigger Chinese counter-actions
- **Escalation volume and escalation severity are different stories**: 2022 saw only 4 actions but at an average severity of 9.0, while 2023 brought 7 actions at 7.4 — after the decisive blow came routine tightening
- **Taiwan produced up to 63.9% of the world's advanced chips** (2023) — a concentration that only begins to ease by 2026 (44.4%) as CHIPS Act fabs come online, growing US leading-edge capacity 8.5× from its 2024 level
- **Sanctions worked narrowly and missed broadly**: China's leading-edge capacity stayed at zero through four years of escalation and remains marginal (15,954 wafers/month against Taiwan's 450,218), but China's *total* capacity grew 13× over the same period — the controls redirected Chinese expansion into mature nodes rather than stopping it
- **The AI boom did not lift the industry evenly**: GPU designers grew 930% ($12.7bn → $130.5bn) and lithography equipment 133%, while the CPU incumbent segment *shrank 26%* — the only decline in the industry
## ✨ Tools Used
- SQL (SQLite) — window functions, multi-table CTE joins, process-node filtering, conditional pivots
- Tableau Public — interactive dashboard with 4 visualizations (stacked area, slope chart, dual-axis bar/line, dual-axis area)
- GitHub — version control and portfolio hosting
## ✨ SQL Queries
- [Export Control Escalation by Policy Era](sql/01_export_controls_escalation.sql)
- [Leading-Edge Capacity Race by Country](sql/02_leading_edge_race.sql)
- [Who Won the AI Era — Revenue Growth by Segment](sql/03_segment_winners.sql)
- [Did the Controls Work? Controls vs China Capacity](sql/04_controls_vs_china_capacity.sql)
## ✨ Visualizations
1. Taiwan Made Two-Thirds of the World's Advanced Chips — stacked area of leading-edge capacity by country, 2019–2026
2. Chip War Escalation: Volume vs Severity — control counts as bars against average severity as a line
3. The AI Boom Did Not Lift Everyone — slope chart of segment revenue, 2019 vs 2024
4. Sanctions Worked Narrowly, Missed Broadly — China's leading-edge capacity against its total capacity
## ✨ Dataset
Source: [Global Semiconductor Industry 2010–2026 (Kaggle)](https://www.kaggle.com/datasets/sergionefedov/global-semiconductor-industry-2010-2026)
Tables used: export_controls (34 events) + fab_capacity (capacity by node and country) + chip_companies_financials (40 companies, 16 years)
Note: anchor data from 10-K filings, SEMI World Fab Forecast, BIS public notices; interpolated between anchor points
