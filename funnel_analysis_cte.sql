-- SQL request(s)​​​​​​‌‌‌​​​​‌​​​​​‌​​‌​​‌‌‌‌‌​ below
/*
In a subscription service, the statusid shows how far a customer went in the payment process.
The target of the exercise is to idenfify how many subscriptions reached each one of the payment 
process steps and understand what were user mistakes and what were vendor mistakes.
*/

-- Get the maximum status reached by each subscription
WITH maxstatus_per_sub AS (
							SELECT 
								MAX(statusid) AS maxstatus,
								subscriptionid
							FROM 
								paymentstatuslog
							GROUP BY 
								subscriptionid
							),

-- Join the maximum and current status of each subscription and identify the situation
	paymentfunnel_per_sub AS (
								SELECT 
									s.subscriptionid, 
									m.maxstatus,
									s.currentstatus,
									CASE 
										WHEN m.maxstatus = 1 THEN 'PaymentWidgetOpened'
										WHEN m.maxstatus = 2 THEN 'PaymentEntered'
										WHEN m.maxstatus = 3 AND s.currentstatus = 0 THEN 'User Error with Payment Submission'
										WHEN m.maxstatus = 3 AND s.currentstatus != 0 THEN 'Payment Submitted'
										WHEN m.maxstatus = 4 AND s.currentstatus = 0 THEN 'Payment Processing Error with Vendor'
										WHEN m.maxstatus = 4 AND s.currentstatus != 0 THEN 'Payment Success'
										WHEN m.maxstatus = 5 THEN 'Complete'
										WHEN m.maxstatus IS NULL THEN 'User did not start payment process'
									END AS paymentfunnelstage	
								FROM 
									maxstatus_per_sub AS m
								RIGHT JOIN 
									subscriptions AS s
									ON m.subscriptionid = s.subscriptionid
								)

-- Finally check how many subscription are in each stage of the payment process
SELECT 
	paymentfunnelstage,
	count(subscriptionid) AS subscriptions
FROM
	paymentfunnel_per_sub
GROUP BY 
	paymentfunnelstage;