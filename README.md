# Bank Customer Churn – Azure Data Engineering Project

<img width="1729" height="775" alt="Intech Azure Data Engineering Architecture (2)" src="https://github.com/user-attachments/assets/9998c7e2-d602-455f-8ae5-90981deba063" />

## Project Overview

This repository contains an **end-to-end Azure data engineering pipeline** built to ingest, process, and serve analytics-ready data using modern, production-style patterns.

The project processes the **Bank Customer Churn dataset** and demonstrates how to design a scalable and secure data platform using **Azure Data Factory, Azure Data Lake Gen2, Databricks, and Synapse Analytics**.

The architecture follows the **medallion pattern (Landing → Bronze → Silver → Gold)**.

---

## Architecture & Design

**Core components:**

- **Azure Data Factory (ADF)** – orchestration, ingestion, and CDC handling  
- **Azure Data Lake Gen2** – centralized storage for all pipeline layers  
- **Azure Databricks** – transformation, schema evolution, and Delta Lake management  
- **Azure Synapse Analytics** – analytics and reporting layer  

**Architecture Pattern:**  
Medallion architecture with Delta Lake (Landing → Bronze → Silver → Gold)

---

## Data Ingestion

Data is ingested using **Azure Data Factory** from multiple sources:

- **HTTP source** – pulls the churn dataset from a GitHub-hosted data source  
- **Azure SQL Database** – injects fabricated records to validate **Change Data Capture (CDC)** functionality

All data lands in the **Landing layer** of ADLS Gen2.

**Ingestion features:**

- Supports **full loads** and **incremental CDC**
- Schema evolution handled via **Databricks Auto Loader**
- Alerts and pipeline notifications via **Logic Apps**

---

## Data Processing (Medallion Layers)

### Bronze – Raw + Metadata
- Raw ingested data stored in **Delta format**
- Metadata captured for source, batch, and processing information
- Auto Loader used for incremental ingestion and schema evolution
- Checkpoints stored to guarantee idempotent processing

### Silver – Cleaned & Enriched
- Data cleansing and normalization
- Type corrections and enrichment logic applied
- Designed as the foundation for downstream analytics

### Gold – Analytics Ready
- Curated datasets aggregated and **partitioned by country**
- Stored in **Delta format** for optimized query performance
- Consumed directly by Synapse Analytics

---

## Analytics Layer (Synapse)

- Gold tables exposed through **country-partitioned views**

---

## Security & Cost Optimization

- Secure access using **Service Principals and Azure Key Vault**
- Role-based access via **Microsoft Entra ID** (least-privilege)
- **Incremental processing and Delta partitioning** to reduce compute and storage costs
- Checkpoints prevent unnecessary reprocessing

---

## Version Control & CI/CD

- Source-controlled in **GitHub** using feature branches and pull requests
- **ARM templates** are generated and stored for Continuous Integration.

---

## Future Enhancements

- Implement **Slowly Changing Dimensions (SCD Type 2)** in Silver
- Integrate **Unity Catalog** for improved governance
- Complete end-to-end **CI/CD automation**
- Automate dynamic Synapse view creation using a stored procedure based on Gold partitions
