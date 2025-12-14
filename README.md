# Bank Customer Churn – Data Engineering Project

<img width="1729" height="775" alt="Intech Azure Data Engineering Architecture (2)" src="https://github.com/user-attachments/assets/a7e712c3-c71f-4037-8b4c-7b32563df2ee" />

## About This Project

This is my first independent **data engineering project**, where I built a complete pipeline to process and analyze the **Bank Customer Churn** dataset from Maven Analytics. The goal was to gain hands-on experience with **Azure Data Factory (ADF), Azure Data Lake Gen2, Databricks, and Synapse Analytics**, while following best practices in **security, cost management, and data governance**.

The project implements a **medallion architecture (Landing → Bronze → Silver → Gold)** to ensure data traceability, quality, and analytics readiness.

---

## Pipeline Overview

### 1. Data Ingestion

Data is ingested via **Azure Data Factory** from two sources:

- **Web / HTTP** – pulls the Bank Customer Churn dataset directly from Maven Analytics.  
- **Azure SQL Database** – adds fabricated data to test **Change Data Capture (CDC)** and validate the full medallion pipeline.

All ingested data lands in the **Landing container** within **Azure Data Lake Gen2**, which also contains folders for the medallion layers and supporting pipeline management:

