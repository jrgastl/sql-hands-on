-- Update LOANS table using a subquery to get the correct bookid
UPDATE loans SET 
    returneddate = '2024-09-09'
WHERE
    bookid IN (SELECT bookid FROM books WHERE barcode IN ('6435968624','5677520613','8730298424')) AND
    returneddate IS NULL;

-- Show the updated values
SELECT
    returneddate,
    barcode
FROM loans
    JOIN books ON loans.bookid = books.bookid
WHERE
    barcode IN ('6435968624','5677520613','8730298424')
ORDER BY
    returneddate DESC,
    barcode DESC
LIMIT 8