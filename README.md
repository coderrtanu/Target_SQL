# Target Brazil E-Commerce SQL Analytics Project

## 📌 Project Overview
This repository contains an end-to-end SQL data analytics project exploring a real-world e-commerce dataset containing over 100,000+ Target orders from Brazil spanning from 2016 to 2018. 

The objective of this project is to analyze operational data across multiple relational tables—including orders, payments, customers, products, and logistics—to uncover actionable insights that can optimize retail operations, delivery performance, revenue growth, and consumer behavior.

## 💾 Dataset Access
The analysis is conducted using the Target Brazil e-commerce dataset. Due to file size constraints on GitHub, the raw data files are hosted externally:

* **Download Link:** You can access and download the complete relational dataset via the [Google Drive Dataset Folder]
  (https://drive.google.com/drive/folder...)
* **Environment Setup:** The tables can be directly imported into the [Google Cloud Console BigQuery Sandbox](https://console.cloud.google.com/bigquery) for execution.


## 📊 Dataset Relational Schema
The analysis is performed on a relational schema comprising 8 interconnected tables linked by unique identifiers (Foreign Keys):
* `customers` — Customer location details (city, state).
* `orders` — Baseline timestamps for order purchases, approvals, and deliveries.
* `order_items` — Product IDs, seller connections, pricing, and freight values.
* `payments` — Transaction structures, payment types (e.g., credit card, voucher, UPI), and installments.
* `products` — Product dimensions, weights, and category classifications.
* `geolocation`, `order_reviews`, `sellers` — Supporting geospatial and feedback data.

---

## 🔍 Business Insights & Analytical Breakdown

### 1. Exploratory Data Analysis & Baseline Operational Period
* **Objective:** Understand the structural bounds and timeline of the transactional dataset.
* Key Finding: Determined that the dataset chronicles e-commerce operations starting from **September 4, 2016, through October 17, 2018**. 

### 2. Temporal Demand & Seasonality Trends
* **Objective:** Identify chronological consumer behaviors to optimize marketing and inventory allocation.
* **Key Findings:** * **Monthly Seasonality:** Order counts reach their peak during the months of **August** and **May**.
  * **Hourly Peak Demand:** Order placements are heavily concentrated during **afternoon hours** (specifically peaking around 4:00 PM) compared to early morning drop-offs.

### 3. Regional Distribution of Consumers
* **Objective:** Map customer density across Brazilian cities and states to locate primary revenue hubs.
* **Key Finding:** Evaluated distinct geographic clusters highlighting the highest customer acquisition concentration within specific metropolitan states.

### 4. Economic Impact & Year-over-Year Revenue Growth
* **Objective:** Measure monetary movement and transaction volume scaling across consecutive years.
* **Key Finding:** Utilizing the `LEAD()` window function to isolate and compare identical periods (January to August) between 2017 and 2018 revealed a massive **136.98% increase in total order payment value** year-over-year.

### 5. Logistics Optimization & Delivery Performance
* **Objective:** Calculate delivery times, evaluate freight expenses, and measure delivery deviations against logistics estimates.
* **Key Findings:**
  * Categorized average shipping/freight costs per state to spot high-overhead regions.
  * Formulated actual vs. estimated delivery variances. The analysis explicitly surfaces both high-efficiency orders (arriving weeks early) and critical supply chain bottlenecks (orders arriving significantly past customer expectations).

### 6. Payment Method & Installment Behaviors
* **Objective:** Assess financial payment profiles and credit utilization among shoppers.
* **Key Finding:** Tracked month-on-month shifts across payment preferences and structured an distribution of order volumes categorized by chosen installment lengths.
