-- Delete statement with a subquery to get information from a second table
DELETE FROM reservations
WHERE customerID = (
    SELECT 
        customerID
    FROM customers
    WHERE firstname = 'Loretta' AND
        lastname = 'Hundey' AND
        phone = '310-730-8619'
    ) AND
    date::date = '2024-05-15';

-- Showall the data that matches the name and year, to confirm the data was removed
SELECT
    r.reservationid,
    r.date,
    c.firstname,
    c.lastname,
FROM reservations r
    JOIN customers c ON c.customerid = r.customerid
WHERE
    YEAR(r.date) = '2024' AND
    c.firstname = 'Loretta' AND
    c.lastname = 'Hundey';