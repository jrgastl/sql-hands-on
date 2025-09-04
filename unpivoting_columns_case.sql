-- SQL request(s)​​​​​​‌‌‌​​​​‌‌‌​​‌​​​​‌​‌​​​‌​ below
/*
Calculate the percent of canceled subscriptions that reported 'Expensive' as one of their cancelations reasons
*/

WITH all_cancelation_reasons AS (
                                SELECT
                                    subscriptionid,
                                    cancelationreason1 AS cancelationreason
                                FROM
                                    cancelations
                                WHERE
                                    cancelationreason1 IS NOT NULL

                                UNION

                                SELECT
                                    subscriptionid,
                                    cancelationreason2
                                FROM
                                    cancelations
                                WHERE
                                    cancelationreason2 IS NOT NULL

                                UNION

                                SELECT
                                    subscriptionid,
                                    cancelationreason3
                                FROM
                                    cancelations
                                WHERE
                                    cancelationreason3 IS NOT NULL
                                )

SELECT
    CAST(
        SUM(
            CASE   
                WHEN cancelationreason = 'Expensive'
                THEN 1
            END) AS FLOAT
        ) / COUNT(DISTINCT(subscriptionid)) AS percent_expensive
FROM
    all_cancelation_reasons;