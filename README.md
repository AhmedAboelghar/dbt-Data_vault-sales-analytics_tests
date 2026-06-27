# Data Vault Sales Analytics Pipeline

This project demonstrates a robust data engineering pipeline using **dbt (data build tool)** and **Data Vault 2.0** modeling techniques. The project focuses on transforming raw sales data into a structured, historical, and auditable format.

## 🚀 Project Overview
The objective of this project was to design a scalable data architecture that ensures data integrity and observability. By using the Data Vault 2.0 methodology, we separate business keys from descriptive data, allowing for easier schema evolution and historical tracking.

## 🛠 What I Implemented
*   **Data Modeling:** Implemented Data Vault 2.0 architecture including:
    *   **Hubs:** For core business entities (e.g., Customers, Products).
    *   **Links:** To capture relationships between entities.
    *   **Satellites:** To track historical changes and descriptive attributes.
*   **Transformations:** Developed modular SQL models using **dbt** to orchestrate the ELT pipeline.
*   **Data Quality:** 
    *   Applied dbt tests (unique, not_null, accepted_values) to ensure data accuracy.
    *   Integrated **Elementary Data** for automated data observability, anomaly detection, and test result reporting.
*   **Version Control:** Managed the development lifecycle using Git and GitHub, adhering to professional coding standards.

## ⚙️ Tech Stack
*   **Database:** PostgreSQL
*   **Orchestration:** dbt (data build tool)
*   **Data Quality:** Elementary Data Monitoring
*   **Modeling Strategy:** Data Vault 2.0
*   **Version Control:** Git & GitHub

## 📂 Project Structure
```text
.
├── models/
│   ├── hubs/         # Business keys
│   ├── links/        # Relationships
│   ├── satellites/   # Descriptive data & history
│   └── marts/        # Final business-ready tables
├── tests/            # Custom dbt tests
├── dbt_project.yml   # Project configuration
└── README.md         # Project documentation
