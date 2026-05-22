# E-Commerce Relational Database Architecture & Analytics

## 📌 Project Overview
This project focuses on designing and implementing a fully normalized B2C relational database schema for an e-commerce platform using MySQL. It includes 6 core entities, data constraints to ensure structural integrity, over 200 rows of relational data, and targeted analytical business queries.

## 🛠️ Tech Stack
- **Database Engine:** MySQL
- **Design Tools:** MySQL Workbench
- **Query Language:** SQL (DDL & DML)

## 📊 Core Business Insights Answered
The analytical script contains optimized queries that pull critical business metrics:
1. **Revenue Operations:** Calculates total revenue from successfully completed payments.
2. **Geographic Performance:** Evaluates average order values and total volume segmented by city.
3. **Inventory Management:** Identifies high-risk low-stock items (<30 units remaining).
4. **User Cohorts:** Isolates VIP customer lists who purchase above the global average order baseline.

## 📁 How to Run the Script
1. Clone this repository.
2. Open `schema_and_queries.sql` in MySQL Workbench.
3. Execute the entire script to build the database, populate the records, and generate the analytical reports.
