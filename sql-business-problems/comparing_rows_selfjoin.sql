-- SQL request(s)​​​​​​‌‌‌​​​​‌‌‌‌​​‌‌​​‌‌‌‌​​‌‌ below
/*
Highlight months where revenue was up month-over-month.
*/

-- Create a CTE to aggregate the revenue by month.
WITH monthly_revenue AS(
                        SELECT
                            DATE_TRUNC('month', orderdate) AS order_month,
                            SUM(revenue) AS revenue_month
                        FROM
                            subscriptions
                        GROUP BY
                            order_month
                        )

-- Create a self join to compare the data between months and get the month-over-month growth events.
SELECT
    curr.order_month AS current_month,
    prev.order_month AS previous_month,
    curr.revenue_month AS current_revenue,
    prev.revenue_month AS previous_revenue
FROM
    monthly_revenue AS curr
JOIN
    monthly_revenue AS prev
    ON
        prev.order_month = curr.order_month - 30
WHERE
    curr.revenue_month > prev.revenue_month