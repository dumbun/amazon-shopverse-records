# Amazon Shopverse Records — SQL Data Analysis

An end-to-end SQL project that builds a MySQL database for a mock e-commerce dataset ("Amazon Shopverse Records"), loads raw transaction data, validates and cleans it, and runs a series of business analyses covering revenue, customers, products, and trends.

## Project Overview

This project simulates a real-world analytics workflow on an e-commerce orders dataset:

1. **Schema design** — define a relational table to hold order-level transaction data.
2. **Data loading** — bulk-load a CSV export into the database.
3. **Data exploration & quality checks** — validate row counts, nulls, duplicates, spacing/formatting issues, and standardization of categorical fields.
4. **Business analysis** — answer key business questions using aggregations, window functions, and views.
5. **Presentation** — findings summarized in an accompanying slide deck.

## Repository Structure

| File                                         | Description                                                                                                                                                                                                                        |
| -------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `schema.sql`                                 | Creates the `AmazonShopverseRecords` database and the `shopverse_records` table, including primary key and index definitions.                                                                                                      |
| `data_loading.sql`                           | Loads the source CSV into `shopverse_records` using `LOAD DATA LOCAL INFILE`, with pre-load server variable checks.                                                                                                                |
| `exploration.sql`                            | Data quality checks — row counts, null checks, date sanity checks, whitespace checks, category/country/payment method standardization, and duplicate order detection.                                                              |
| `analysis.sql`                               | Core business analysis queries — revenue, top products, payment method breakdown, monthly/yearly trends, customer spend and retention, return/cancellation rates, day-of-week performance, rolling averages, and country rankings. |
| `Amazon_Shopverse_Records_Presentation.pptx` | Slide deck summarizing key findings from the analysis.                                                                                                                                                                             |
| `LICENSE.txt`                                | MIT License.                                                                                                                                                                                                                       |

## Dataset

The `shopverse_records` table models one row per order, with the following fields:

- **Order info**: `OrderID`, `OrderDate`, `OrderStatus`
- **Customer info**: `CustomerID`, `CustomerName`, `City`, `State`, `Country`
- **Product info**: `ProductID`, `ProductName`, `Category`, `Brand`, `SellerID`
- **Transaction info**: `Quantity`, `UnitPrice`, `Discount`, `Tax`, `ShippingCost`, `TotalAmount`, `PaymentMethod`

> **Note:** The dataset itself (CSV) is not included in this repository. Update the file path in `data_loading.sql` to point to your local copy before running it.

## Setup & Usage

Run the scripts in the following order using a MySQL client:

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

- MySQL Server (5.7+ or 8.0+ recommended for window function support)
- `local_infile` enabled on both the server and client, since `data_loading.sql` uses `LOAD DATA LOCAL INFILE`
- A MySQL client (CLI, MySQL Workbench, DBeaver, etc.)

## Key Questions Answered

The analysis in `analysis.sql` addresses questions such as:

- What is the total revenue, order count, and average order value?
- Which products generate the most revenue and units sold?
- Which payment methods are most popular, by order count and revenue?
- How does monthly revenue trend, and what is the year-over-year growth rate?
- Who are the top-spending customers, and who returned as customers across 2023 and 2024?
- What is the return/cancellation rate by product category?
- Which day of the week has the highest average order value?
- How does cumulative revenue grow month over month, and what is the 3-month rolling average?
- How do countries rank by total revenue?

## Data Quality Checks

`exploration.sql` covers standard pre-analysis validation:

- Total row count
- Null checks across all columns
- Orders with future-dated `OrderDate` values
- Leading/trailing whitespace in `ProductName` and `Category`
- Distinct value inspection for `Category`, `Country`, and `PaymentMethod` (to catch inconsistent labeling)
- Duplicate `OrderID` detection

## License

This project is licensed under the MIT License — see [LICENSE.txt](LICENSE.txt) for details.

## Author

Vamshi Krishna Kamsali
