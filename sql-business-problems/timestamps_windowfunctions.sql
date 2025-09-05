-- SQL request(s)​​​​​​‌‌‌​​​‌​​​‌​​‌​​‌‌‌‌​‌​​‌ below
/*
Pull payment funnel data for subscription number 38844 and calculate how long the user was in each status of the payment process before moving to the next.
*/

-- Getting the next event time with LEAD window function and then calculate the duration of each event.
SELECT
    statusmovementid,
    subscriptionid,
    statusid,
    movementdate,
    LEAD(movementdate, 1) OVER (
                            PARTITION BY subscriptionid
                            ORDER BY movementdate
    ) AS nextstatusmovementdate,
    LEAD(movementdate, 1) OVER (
                            PARTITION BY subscriptionid
                            ORDER BY movementdate
    ) - movementdate AS timeinstatus
FROM
    paymentstatuslog
WHERE
    subscriptionid = '38844'