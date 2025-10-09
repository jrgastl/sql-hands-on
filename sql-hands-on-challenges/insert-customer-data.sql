-- Adding values to the table. Using subquery to retrive customer id from another table.
INSERT INTO reservations (customerid, date, partysize)
    VALUES(
        (SELECT customerid FROM customers WHERE email = 'cgoldwater15@landonhotel.com'),
        '2025-04-12 18:00:00',
        '7'
    );

-- Show added values
SELECT 
    c.firstname,
    c.lastname,
    r.reservationid,
    r.date
FROM Reservations r
    JOIN customers c ON r.customerid = c.customerid
WHERE
    c.email = 'cgoldwater15@landonhotel.com' AND
    r.date LIKE '2025-04-12%'