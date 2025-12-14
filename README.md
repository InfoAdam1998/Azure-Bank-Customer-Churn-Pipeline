# Bank Customer Churn – Data Engineering Project

<img width="1729" height="775" alt="Intech Azure Data Engineering Architecture (2)" src="https://github.com/user-attachments/assets/6ed23273-30c7-4319-8eaa-423f4f030670" />

## About This Project

This is my first independent data engineering project, where I built a complete pipeline to process and analyze the Bank Customer Churn dataset from Maven Analytics. The goal was to gain hands-on experience with **Azure Data Factory (ADF), Azure Databricks, and Synapse Analytics**, while following best practices in **security, cost management, and data governance**.

The project implements a **medallion architecture (Landing → Bronze → Silver → Gold)** to ensure data traceability, quality, and analytics readiness.

---

## Pipeline Overview

### Data Ingestion

Data is ingested via **Azure Data Factory** from two sources:

- **Web / HTTP** – pulls the Bank Customer Churn dataset directly from my **GitHub** dataset folder.  
- **Azure SQL Database** – adds fabricated data to test **Change Data Capture (CDC)** and validate the full medallion pipeline.

All ingested data lands in the **Landing container** within **Azure Data Lake Gen2**, which also contains folders for the medallion layers and supporting pipeline management:

Landing → Bronze → Silver → Gold  
Supporting: Checkpoints, Config, Failed, Synapse-fs

**Supporting Containers Explained:**

- **Failed:** Stores any corrupted or problematic files that cannot be processed.  
- **Config:** Contains JSON configuration files used to dynamically read datasets during ingestion and track CDC timestamps for incremental loads.  
- **Checkpoints:** Stores schema evolution information and Auto Loader checkpoints from Bronze for incremental ingestion and tracking.  

**Key Features:**

- Supports **full load** or **incremental CDC**.  
- Alerts and notifications via **Logic Apps**.  
- Fabricated SQL data expands the dataset beyond the original 3 countries.

---

### Medallion Architecture (Bronze → Silver → Gold)

**Bronze (Raw + Metadata):**

- Stores raw ingested data in **Delta format** for versioning and traceability.  
- Includes metadata for **batches, sources, and processing**.  
- Uses **Databricks Auto Loader** for automatic ingestion and schema evolution.  
- **Checkpoints** and schema evolution info are stored in the **Checkpoints container**.

**Silver (Cleaned/Enriched):**

- Cleans, transforms, and normalizes the data, type corrections, and enrichment.

**Gold (Curated / Analytics-ready):**

- Aggregates and partitions data by **country**.  
- Stored in **Delta format**, ready for **Synapse queries** and reporting.

**Security & Access:**

- Managed via **Service Principal** and **Azure Key Vault**.  
- Role-based access through **Entra ID** with **least privilege principles**.

---

### Synapse Analytics

- Gold tables are used to create **views partitioned by country** for fast queries.  
- Views are currently created manually. Future work includes **automating view creation** via stored procedures.

---

### Cost & Security Optimizations

- **Incremental loads** and **partitioned Delta tables** reduce storage and compute costs.  
- **Service Principals, Key Vault, and Entra ID** ensure secure access.  
- **Checkpoints** prevent reprocessing of old data.

---

### Version Control & CI/CD

- All code tracked in **GitHub** with feature branches merged into `main`.  
- **ARM templates** store infrastructure-as-code.  
- **CI** is in place and **CD** is planned for full automation.

---

## Plans to enhance this project

- Implement **SCD2** in Silver for historical data tracking.  
- Integrate **Unity Catalog** for enhanced governance.  
- Complete full **CI/CD** for Databricks, ADF, and Synapse artifacts.  
- Automate **dynamic Synapse view creation** based on Gold partitions.
