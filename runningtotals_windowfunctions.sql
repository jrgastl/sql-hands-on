-- SQL request(s)​​​​​​‌‌‌​​​‌​​​‌​​​‌‌‌​​​‌​​​​ below
/*
Calculate the running total of sales revenue and the percentage of quoata achieved by each sales employee on each date they make a sales.
*/
SELECT
    s.salesemployeeid,
    s.saledate,
    s.saleamount,
    SUM(s.saleamount) OVER (
                            PARTITION BY s.salesemployeeid
                            ORDER BY s.saledate
                            ) AS running_total,
    CAST(
        SUM(s.saleamount) OVER (
                                PARTITION BY s.salesemployeeid 
                                ORDER BY s.saledate
                                ) AS FLOAT
         ) / e.quota AS percent_quota
FROM
    sales AS s
LEFT JOIN
    employees e
    ON
        s.salesemployeeid = e.employeeid
ORDER BY    
    s.salesemployeeid