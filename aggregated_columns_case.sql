-- SQL request(s)​​​​​​‌‌‌​​​​‌​‌​​‌‌​​​​‌‌‌​​‌‌ below
/*
 Tracker user activity in a customer support page through the different eventids.
    ViewedHelpCenterPage (eventid=1)
    ClickedFAQs (eventid=2)
    ClickedContactSupport (eventid=3)
    SubmittedTicket (eventid=4)
*/

SELECT
    fel.userid,
    SUM(CASE
            WHEN fel.eventid = 1 
            THEN 1
            ELSE 0
        END
        ) AS viewedhelpcenterpage,
    SUM(CASE
            WHEN fel.eventid = 2 
            THEN 1
            ELSE 0
        END
        ) AS clickedfaqs,
    SUM(CASE
            WHEN fel.eventid = 3 
            THEN 1
            ELSE 0
        END
        ) AS clickedcontactsupport,
    SUM(CASE
            WHEN fel.eventid = 4
            THEN 1
            ELSE 0
        END
        ) AS submittedticket
FROM
    frontendeventlog AS fel
JOIN
    frontendeventdefinitions AS fed
    ON fel.eventid = fed.eventid
WHERE
    fed.eventtype = 'Customer Support'
GROUP BY
    fel.userid