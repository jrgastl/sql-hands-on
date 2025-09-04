-- SQL request(s)​​​​​​‌‌‌​​​‌​​​‌​​‌​​‌‌‌‌​‌​​‌ below
/*
Pull payment funnel data for subscription number 38844 and calculate how long the user was in each status of the payment process before moving to the next.
*/
SELECT
    statusmovementid,
    subscriptionid,
    statusid,
    movementdate,
    LEAD(movementdate) OVER (
                            PARTITION BY subscriptionid
                            ORDER BY movementdate
    ) AS nextstatusmovementdate,
    LEAD(movementdate) OVER (
                            PARTITION BY subscriptionid
                            ORDER BY movementdate
    ) - movementdate AS timeinstatus
FROM
    paymentstatuslog
WHERE
    subscriptionid = '38844'