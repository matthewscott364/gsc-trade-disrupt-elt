# GSC Trade Disrupt ELT

A modern end-to-end Analytics Engineering project focused on global supply chain disruption analytics using SQLite, dbt Core, and Tableau.

This project models real-world supply chain disruption scenarios including:
- geopolitical instability
- freight market volatility
- port congestion
- global trade dependencies
- industry vulnerability exposure

The platform follows a layered ELT warehouse architecture using:
- Bronze (raw ingestion)
- Silver (staging + intermediate transformations)
- Gold (analytics-ready marts)

---

# Architecture Overview

```text
Raw CSV Files
    ↓
SQLite Warehouse
    ↓
dbt Sources
    ↓
Staging Models
    ↓
Intermediate Business Logic
    ↓
Fact & Dimension Tables
    ↓
Reporting Marts
    ↓
Tableau Dashboards
```

---

# Tech Stack

| Technology | Purpose |
|---|---|
| SQLite | Local analytical warehouse |
| dbt Core | ELT transformations & lineage |
| SQL | Data modeling & transformations |
| Python | Data cleaning/preprocessing |
| Pandas | CSV preprocessing |
| Tableau | Business intelligence dashboards |
| Git/GitHub | Version control |
| VS Code | Development environment |

---

# Project Structure

```text
gsc-trade-disrupt-elt/
├── analyses/*
├── data/*
├── data_usable/*
├── macros/*
├── models/
│   ├── staging/
│   ├── intermediate/
│   └── marts/
│       ├── core/
│       └── reporting/
├── seeds/*
├── snapshots/*
├── tests/*
├── data_clean_1.ipynb
├── data_clean_2.ipynb
├── data_clean_3.ipynb
├── data_clean_4.ipynb
├── data_clean_5.ipynb
├── data_ingest.ipynb
├── gsc_trade_disrupt.db
├── dbt_project.yml
├── profiles.yml
└── README.md
```

---

# ERD Diagram

---

# Data Sources

The warehouse is built using multiple supply chain datasets:

| Dataset | Description |
|---|---|
| gsc_disruption_events_clean | Global disruption events |
| gsc_shipping_rates_clean | Freight/shipping market metrics |
| gsc_trade_flows_clean | Import/export trade relationships |
| gsc_congestion_clean | Port congestion metrics |
| gsc_industry_exposure_clean | Industry vulnerability & dependency data |

---

# dbt Model Layers

## Staging Layer (`stg_`)

Purpose:
- standardize column naming
- type casting
- reusable transformations
- null handling
- lightweight business logic

Examples:

```text
stg_gsc_disruption_events
stg_gsc_shipping_rates
stg_gsc_trade_flows
stg_gsc_port_congestion
stg_gsc_industry_exposure
```

---

## Intermediate Layer (`int_gsc_`)

Reusable business logic and analytical processing.

Examples:

```text
int_gsc_disruption_impact
int_gsc_trade_risk_scores
int_gsc_port_stress
int_gsc_health
```

These models:
- combine multiple datasets
- calculate reusable KPIs
- aggregate operational metrics
- create supply chain risk scoring logic

---

## Core Warehouse Layer

### Fact Tables (`fct_`)

```text
fct_disruptions
fct_shipping_metrics
fct_port_congestion
fct_trade_flows
```

### Dimension Tables (`dim_`)

```text
dim_date
dim_region
dim_industry
dim_trade_lane
```

This layer follows dimensional modeling principles using a star-schema style architecture.

---

## Reporting Layer (`mart_gsc_`)

Analytics-ready marts designed for BI dashboards and executive reporting.

```text
mart_gsc_supply_chain_risk
mart_gsc_shipping_market
mart_gsc_port_operations
mart_gsc_global_supply_chain_summary
```

These marts provide:
- supply chain risk analytics
- freight market insights
- congestion monitoring
- executive KPI reporting

---

# Example Business Questions

This warehouse is designed to answer questions such as:

- Which industries are most vulnerable to global disruptions?
- Which trade lanes have the highest supply chain risk?
- How does port congestion affect freight pricing?
- Which regions experience the highest disruption severity?
- How are freight markets changing over time?
- What is the overall global supply chain health score?

---

# Running the Project

## Install Dependencies

```bash
pip install dbt-core dbt-sqlite pandas
```

---

## Run dbt Models

Run all models:

```bash
dbt run
```

Run specific layers:

```bash
dbt run --select staging
dbt run --select intermediate
dbt run --select marts.core
dbt run --select marts.reporting
```

---

## Run Tests

```bash
dbt test
```

---

## Generate Documentation

```bash
dbt docs generate
dbt docs serve
```

Open:

```text
http://localhost:8080
```

to view:
- dbt lineage graph
- DAG dependencies
- model documentation
- warehouse architecture

---

# Dimensional Modeling

The project uses a dimensional modeling approach with:
- fact tables for measurable events
- dimension tables for reusable business entities
- reporting marts for BI consumption

This mirrors real-world Analytics Engineering and Data Warehouse practices.

---

# Future Improvements

Potential future enhancements:

- Incremental dbt models
- Airflow orchestration
- dbt snapshots
- Data quality monitoring
- CI/CD pipelines
- Cloud warehouse migration
- DuckDB/Snowflake support
- Advanced Tableau dashboards
- Great Expectations integration

---

# Portfolio Focus

This project was designed as an Analytics Engineering portfolio project demonstrating:

- ELT pipeline architecture
- dbt modeling best practices
- dimensional modeling
- analytical warehouse design
- supply chain analytics
- business intelligence engineering
- SQL transformation workflows
- end-to-end data platform development

---

# Author

Created by Matthew Scott

- GitHub: https://github.com/matthewscott364
- LinkedIn: https://www.linkedin.com/in/matthewscott364
