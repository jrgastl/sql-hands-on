-- SQL request(s)​​​​​​‌‌‌​​​​‌‌‌‌​​‌​‌‌​‌‌‌‌‌‌​ below
/*
Create an e-mail list of the sales department to report to managers or to the employee themself if they don't have e-mail.
*/

SELECT
    employees.employeeid AS employeeid,
    employees.name AS employee_name,
    managers.name AS manager_name,
    CASE
        WHEN employees.managerid IS NULL THEN employees.email
        ELSE managers.email
    END AS contact_email
FROM
    employees
LEFT JOIN
    employees AS managers
    ON
    employees.managerid = managers.employeeid
WHERE
    employees.department = 'Sales';