SELECT TOP(1) WITH TIES BOOK_TITLE.name, COUNT(*) AS number_of_books
FROM DEAL 
JOIN BOOK on DEAL.book_id = BOOK.book_id 
JOIN EDITION on BOOK.edition_id = EDITION.edition_id 
JOIN BOOK_TITLE on EDITION.book_title_id = BOOK_TITLE.book_title_id
WHERE (DATEPART(month, DEAL.lending_date) < 13 AND DATEPART(month, DEAL.lending_date) > 8 AND DATEPART(year, DEAL.lending_date) = 2020)
GROUP BY BOOK_TITLE.name
ORDER BY COUNT(*) DESC
