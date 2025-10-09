-- Use window functions to rank the book data and a CTE so the data can be further worked with
WITH rankedbooks AS (
    SELECT 
        COUNT(l.loanid) AS loancount,
        DENSE_RANK() OVER (ORDER BY COUNT(l.loanid) DESC) AS bookrank,
        b.title
    FROM books b
        JOIN loans l ON b.bookid = l.bookid
    GROUP BY
        b.title)

-- Futher filter the results and retrieve them
SELECT
    *
FROM rankedbooks
WHERE 
    bookrank <= 10
ORDER BY
    loancount DESC,
    title ASC