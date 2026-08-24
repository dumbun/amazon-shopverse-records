-- What is the total revenue, order count and average order value across the entire dataset?
SELECT ROUND(SUM(TotalAmount), 2) AS total_revenue,
       COUNT(*) AS order_count,
       ROUND(AVG(TotalAmount), 2) AS avg_order_value
FROM   shopverse_records;

-- Which are the Top 10 products by revenue and units sold?
SELECT   ProductID,
         ProductName,
         SUM(TotalAmount) AS revenue,
         sum(Quantity) as quantity_sold,
         RANK() OVER (ORDER BY SUM(TotalAmount),sum(Quantity) DESC) AS top_product_rank
FROM     shopverse_records
GROUP BY ProductID, ProductName
LIMIT 10;


-- Which Payment Method is most popular? Show the count of orders and total revenue for each payment method, sorted by revenue.
select PaymentMethod ,
        count(*) as number_of_orders,
          sum(TotalAmount) as total_revenue 
      from shopverse_records
group by PaymentMethod
order by total_revenue desc;

-- How does monthly revenue trend in 2023, and what is the YoY growth rate?
WITH monthly_revenue AS (
    SELECT
        YEAR(OrderDate)  AS yr,
        MONTH(OrderDate) AS month_num,
        DATE_FORMAT(OrderDate, '%Y-%m') AS month,
        SUM(TotalAmount) AS revenue
    FROM shopverse_records
    GROUP BY YEAR(OrderDate), MONTH(OrderDate), DATE_FORMAT(OrderDate, '%Y-%m')
)
SELECT
    curr.month,
    curr.revenue AS revenue_current,
    prev.revenue AS revenue_prior_year,
    CONCAT(ROUND((curr.revenue - prev.revenue) / prev.revenue * 100, 2), ' %') AS yoy_growth_pct
FROM monthly_revenue AS curr
JOIN monthly_revenue AS prev
    ON curr.month_num = prev.month_num
    AND curr.yr = prev.yr + 1
ORDER BY curr.month;



-- Which customers spent the most
SELECT
    ROW_NUMBER() OVER(ORDER BY SUM(TotalAmount) DESC) AS spend_rank,
    CustomerID,
    SUM(TotalAmount) AS total_spent
FROM shopverse_records
GROUP BY CustomerID
LIMIT 10;

-- who returned in both 2023 and 2024?
WITH returning_customers AS (
    SELECT
        c2023.CustomerID,
        MAX(c2023.CustomerName) AS CustomerName
    FROM (
        SELECT CustomerID, CustomerName
        FROM shopverse_records
        WHERE YEAR(OrderDate) = 2023
    ) AS c2023
    JOIN (
        SELECT DISTINCT CustomerID
        FROM shopverse_records
        WHERE YEAR(OrderDate) = 2024
    ) AS c2024
        ON c2023.CustomerID = c2024.CustomerID
    GROUP BY c2023.CustomerID
)
SELECT CustomerID, CustomerName
FROM returning_customers;



-- What is the return / cancellation rate by category?

SELECT
    Category,
    COUNT(*) AS total_orders,
    SUM(CASE 
            WHEN OrderStatus IN ('Returned', 'Cancelled') THEN 1 
            ELSE 0 
        END) AS returned_or_cancelled,
    ROUND(
        SUM(CASE 
                WHEN OrderStatus IN ('Returned', 'Cancelled') THEN 1 
                ELSE 0 
            END)
        / COUNT(*) * 100,
        2
    ) AS return_cancel_rate_pct
FROM shopverse_records
GROUP BY Category
ORDER BY return_cancel_rate_pct DESC;


-- Which day of the week shows the highest average order value?

SELECT
    DAYNAME(OrderDate) AS day_of_week,
    COUNT(*) AS total_orders,
    ROUND(AVG(TotalAmount), 2) AS avg_order_value
FROM shopverse_records
GROUP BY DAYNAME(OrderDate), DAYOFWEEK(OrderDate)
ORDER BY avg_order_value DESC;

DROP VIEW IF EXISTS year_month_revenue;

CREATE VIEW year_month_revenue AS (
    SELECT
        DATE_FORMAT(OrderDate, '%Y-%m') AS year_and_month,
        YEAR(OrderDate) AS year,
        MONTH(OrderDate) AS month,
        SUM(TotalAmount) AS total_revenue
    FROM shopverse_records
    GROUP BY
        DATE_FORMAT(OrderDate, '%Y-%m'),
        YEAR(OrderDate),
        MONTH(OrderDate)
);


-- How does cumulative revenue grow month over month?
SELECT
    year_and_month,
    SUM(total_revenue) OVER (ORDER BY year_and_month) AS cumulative_revenue
FROM year_month_revenue;

-- What is the 3-month rolling average revenue?
SELECT
    year_and_month,
    ROUND(
        AVG(total_revenue) OVER (
            ORDER BY year_and_month
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ),
        2
    ) AS rolling_3mo_avg
FROM year_month_revenue
ORDER BY year_and_month;

-- Find the yearly total revenue and the YoY growth percentage from previous year. 
WITH yearly_revenue AS (
    SELECT
        year,
        SUM(total_revenue) AS total_revenue
    FROM year_month_revenue
    GROUP BY year
)
SELECT
    year,
    total_revenue,
    CONCAT(COALESCE(ROUND(
        (total_revenue - LAG(total_revenue) OVER (ORDER BY year))
        / LAG(total_revenue) OVER (ORDER BY year) * 100,
        2
    ),0),' %') AS yoy_growth_pct
FROM yearly_revenue
ORDER BY year;

-- Showing the country wise ranks
SELECT 
    Country,
    SUM(TotalAmount) AS totalAmount,
    ROW_NUMBER() OVER (ORDER BY  SUM(TotalAmount)) AS country_ranks
FROM shopverse_records
GROUP BY Country