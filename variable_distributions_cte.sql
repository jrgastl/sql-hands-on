-- SQL request(s)​​​​​​‌‌​‌‌‌‌‌‌‌‌​​‌​​‌​​​​‌‌‌​ below
/*
1. Show how many users have clicked how many times in marketing campaing email link
2. Eventid 5 identifies successfully reached users.
*/

-- CTE creation to aggregate number of successfully click events per user
WITH clicksperuser AS (
                        SELECT 
                            userid,
                            count(eventid) AS num_link_clicks
                        FROM
                            frontendeventlog
                        WHERE 
                            eventid = 5
                        GROUP BY 
                            userid
                        )

-- Query on the CTE to aggregate number of users per number of clicks
SELECT 
    num_link_clicks,
    count(userid) AS num_users
FROM
    clicksperuser
GROUP BY 
    num_link_clicks;