-- SQL request(s)​​​​​​‌‌‌​​​​‌​‌​​‌​‌‌​​​‌‌‌​​‌ below
/*
Reach out to customers that meet one of the following criteria:
    Customer with more than 5000 registered users
    Only have one product subscription
*/

-- Aggregate the instances according to the criteria then use CASE to assess if they meet the conditions.
SELECT
    customerid,
    COUNT(productid) AS num_products,
    SUM(numberofusers) AS total_users,
    CASE
        WHEN COUNT(productid) = 1 
        OR SUM(numberofusers) >= 5000 
        THEN 1
        ELSE 0
    END AS upsell_opportunity
FROM 
    subscriptions
GROUP BY
    customerid