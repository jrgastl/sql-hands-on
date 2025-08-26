-- SQL request(s)​​​​​​‌‌​‌‌‌‌‌‌‌‌​​‌​​​​​​​‌​‌​ below
/* 
1. How much revenue does each product usually generate each month?
2. Which product had the most success throughout all of last year?
3. Did either product fluctuate greatly each month or was the month-to-month trend fairly consistent?

Minimum, maximum, average, and standard deviation of monthly revenue for each product for year 2022
*/

WITH revenue_distribution AS (
    SELECT
        p.productname, 
        SUM(s.revenue) AS monthly_rev, 
        DATE_TRUNC('month', s.orderdate) AS rev_month
    FROM subscriptions AS s
    INNER JOIN products AS p
        ON s.productid = p.productid
    WHERE s.orderdate BETWEEN '2022-01-01' AND '2022-12-31'
    GROUP BY p.productname, rev_month
    )

SELECT
    productname, 
    MIN(monthly_rev) AS min_rev,
    MAX(monthly_rev) AS max_rev,
    AVG(monthly_rev) AS avg_rev,
    STDDEV(monthly_rev) AS std_dev_rev
FROM revenue_distribution
GROUP BY productname;