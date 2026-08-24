# 🛒 Amazon Shopverse Records — SQL Data Analysis

An end-to-end SQL analytics project built on a mock e-commerce dataset, **Amazon Shopverse Records**. It walks through designing a relational schema, loading raw order data, validating and cleaning it, and answering real business questions with SQL — covering revenue, customers, products, and trends.

![MySQL](https://img.shields.io/badge/MySQL-5.7%2B%20%2F%208.0%2B-4479A1?logo=mysql&logoColor=white)
![License](https://img.shields.io/badge/license-MIT-green)

---

## 📌 Project Overview

This project simulates a real-world analytics workflow on an e-commerce orders dataset, from raw data to business insight:

1. **Schema design** — a relational table to hold order-level transaction data.
2. **Data loading** — bulk-load a CSV export into MySQL.
3. **Data exploration & quality checks** — row counts, nulls, duplicates, whitespace issues, and standardization of categorical fields.
4. **Business analysis** — revenue, customer, product, and trend questions answered with aggregations, window functions, and views.
5. **Presentation** — key findings summarized in an accompanying slide deck.

---

## 📂 Repository Structure

| File | Description |
|---|---|
| `schema.sql` | Creates the `AmazonShopverseRecords` database and `shopverse_records` table, with primary key and index definitions. |
| `data_loading.sql` | Loads the source CSV into `shopverse_records` via `LOAD DATA LOCAL INFILE`, with pre-load server variable checks. |
| `exploration.sql` | Data quality checks — row counts, null checks, date sanity checks, whitespace checks, category/country/payment-method standardization, and duplicate order detection. |
| `analysis.sql` | Core business analysis — revenue, top products, payment method breakdown, monthly/yearly trends, customer spend & retention, return/cancellation rates, day-of-week performance, rolling averages, and country rankings. |
| `amazon shopverse records.csv` | Raw source dataset. |
| `results/` | Query outputs / exported results. |
| `Amazon_Shopverse_Records_Presentation.pptx` | Slide deck summarizing key findings. |
| `LICENSE.txt` | MIT License. |

---

## 🗃️ Dataset

The `shopverse_records` table models one row per order:

| Category | Fields |
|---|---|
| **Order info** | `OrderID`, `OrderDate`, `OrderStatus` |
| **Customer info** | `CustomerID`, `CustomerName`, `City`, `State`, `Country` |
| **Product info** | `ProductID`, `ProductName`, `Category`, `Brand`, `SellerID` |
| **Transaction info** | `Quantity`, `UnitPrice`, `Discount`, `Tax`, `ShippingCost`, `TotalAmount`, `PaymentMethod` |

> ⚠️ **Note:** The dataset CSV is included in the repo, but paths are local — update the file path in `data_loading.sql` to point to your own copy before running it.

---

## ⚙️ Setup & Usage

Run the scripts in order using a MySQL client:

```sql
-- 1. Create the database and table
SOURCE schema.sql;

-- 2. Load the data (update the CSV path in this file first)
SOURCE data_loading.sql;

-- 3. Run data quality checks
SOURCE exploration.sql;

-- 4. Run the business analysis
SOURCE analysis.sql;
```

### Prerequisites

- MySQL Server **5.7+** (8.0+ recommended for window function support)
- `local_infile` enabled on **both** the server and client — `data_loading.sql` uses `LOAD DATA LOCAL INFILE`
- A MySQL client (CLI, MySQL Workbench, DBeaver, etc.)

---

## ❓ Key Questions Answered

`analysis.sql` digs into questions such as:

- 💰 What is the total revenue, order count, and average order value?
- 📦 Which products generate the most revenue and units sold?
- 💳 Which payment methods are most popular, by order count and revenue?
- 📈 How does monthly revenue trend, and what's the year-over-year growth rate?
- 👤 Who are the top-spending customers, and who returned across 2023 and 2024?
- 🔄 What is the return/cancellation rate by product category?
- 📅 Which day of the week has the highest average order value?
- 📊 How does cumulative revenue grow month over month, and what's the 3-month rolling average?
- 🌍 How do countries rank by total revenue?

---

## ✅ Data Quality Checks

`exploration.sql` covers standard pre-analysis validation:

- Total row count
- Null checks across all columns
- Orders with future-dated `OrderDate` values
- Leading/trailing whitespace in `ProductName` and `Category`
- Distinct value inspection for `Category`, `Country`, and `PaymentMethod` (catching inconsistent labeling)
- Duplicate `OrderID` detection

---

## 📄 License

Licensed under the [MIT License](LICENSE.txt).

## ✍️ Author

**Vamshi Krishna Kamsali**
