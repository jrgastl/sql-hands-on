-- SQL request(s)​​​​​​‌‌‌​​​​‌‌‌​​​‌‌‌‌‌‌​​​​‌‌ below
/*
Task: Count the number of active subscriptions that will expire in each year
*/

-- Create a CTE to combine the tables.
WITH all_subscriptions AS (
							SELECT 
								customerid,
								expirationdate,
								active
							FROM
								subscriptionsproduct1

							UNION

							SELECT
								customerid,
								expirationdate,
								active
							FROM
								subscriptionsproduct2
							)

-- Then filter the CTE to get the total of active subscriptions.
SELECT
	DATE_TRUNC('year', expirationdate) AS exp_year,
	COUNT(*) AS subscriptions
FROM
	all_subscriptions
WHERE
	active = 1
GROUP BY
	exp_year