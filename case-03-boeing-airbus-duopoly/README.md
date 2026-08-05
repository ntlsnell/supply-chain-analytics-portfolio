# Case 03 — Boeing vs Airbus: A Duopoly Under Stress
## ✨ Dashboard
[![Dashboard Preview](https://github.com/ntlsnell/supply-chain-analytics-portfolio/blob/main/case-03-boeing-airbus-duopoly/dashboards/boeing-airbus-duopoly.png?raw=true)](https://public.tableau.com/views/BoeingvsAirbusDuopolyUnderStress/Dashboard1)
🔗 [View Live Interactive Dashboard on Tableau Public](https://public.tableau.com/views/BoeingvsAirbusDuopolyUnderStress/Dashboard1)
## ✨ Business Context
Analysis of the commercial aviation duopoly through two consecutive shocks — the 737 MAX crisis and COVID-19 — tracking 17 years of order books, production backlogs, regional passenger traffic, and airline profitability across 30 carriers. The case examines how a manufacturing crisis compounds into a decade-long competitive gap, and why recovery from a global shock was so uneven.
## ✨ Methodology Note
- **Net orders, not gross orders**: net orders subtract cancellations, which is what makes the 737 MAX crisis visible as a negative number — gross orders would hide it entirely
- **Backlog as years of production**: dividing backlog by annual deliveries converts an abstract order count into a capacity measure — how many years of output each manufacturer has already sold
- **Business-model contrast over absolute margins**: airline margins in this dataset are modeled around real anchor points, so the analysis reads the *contrast between models*, not exact profitability values
- Order books, delivery counts, and incident records are anchored to real Boeing/Airbus reports and the ASN database; the 2019 (−87) and 2020 (−1,026) Boeing net order figures match published data
## ✨ Key Insights
- **Boeing's net orders went negative twice**: −87 in 2019 after the ET302 grounding and −1,026 in 2020 — cancellations outnumbered new orders, the single clearest measure of the 737 MAX crisis
- **The gap never closed**: in 2024 Airbus booked 1,456 narrowbody net orders against Boeing's 569 — a 2.5× difference five years after the grounding
- **Backlogs diverged from near-parity to a chasm**: 3,136 vs 3,216 aircraft in 2010, but 6,876 vs 9,730 by 2024 — Airbus has locked in roughly 2,850 more aircraft of future production
- **COMAC quietly became real**: the C919 backlog grew from 815 (2018) to 1,437 (2024) — a third player materialising while the duopoly was distracted
- **COVID hit every region equally, recovery split them**: all regions lost 69–75% of RPK in 2020, but by 2024 the Middle East stood 51.6% above its 2019 baseline while Latin America managed only +34.8%
- **Business model determined resilience**: low-cost carriers entered 2019 at 11.1% operating margin vs 5.9% for legacy, took the same ~−35% hit, and exited 2024 still ahead (11.9% vs 7.4%)
## ✨ Tools Used
- SQL (SQLite) — multi-table aggregation, conditional pivots, ratio metrics across 5 aviation tables
- Tableau Public — interactive dashboard with 4 visualizations (multi-measure line charts, diverging bars, grouped comparisons)
- GitHub — version control and portfolio hosting
## ✨ SQL Queries
- [The Narrowbody Battle — Net Orders 2010–2025](sql/01_duopoly_battle.sql)
- [Backlog & Production Capacity](sql/02_backlog_accumulation.sql)
- [COVID Collapse & Recovery Asymmetry by Region](sql/03_covid_traffic_recovery.sql)
- [Airline Resilience by Business Model](sql/04_airline_resilience.sql)
## ✨ Visualizations
1. Boeing's −1,026: When Cancellations Beat Orders — three-manufacturer net order lines with a zero reference line
2. Airbus Backlog Pulls Away: 3,200 to 9,730 — backlog divergence from near-parity
3. Everyone Fell 70%+. Not Everyone Came Back the Same — regional collapse vs recovery
4. Low-Cost Carriers Entered the Crisis Twice as Profitable — margins by business model, 2019 / 2020 / 2024
## ✨ Dataset
Source: [Global Aviation Industry 2010–2026 (Kaggle)](https://www.kaggle.com/datasets/sergionefedov/global-aviation-industry-2010-2026)
Tables used: fleet_orders (86 rows) + passenger_traffic (1,176 monthly rows) + airline_financials (497 rows, 30 airlines) + aviation_incidents (40 events)
Note: anchor data sourced from SEC filings, Boeing/Airbus order reports, IATA and ASN; interpolated values between anchors
