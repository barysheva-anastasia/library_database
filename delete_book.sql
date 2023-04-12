DELETE FROM BOOK
WHERE BOOK.book_id IN (
	SELECT BOOK.book_id 
	FROM BOOK
	JOIN DEAL ON BOOK.book_id = DEAL.book_id
	WHERE (DEAL.returning_date IS NULL AND DATEDIFF(year, lending_date, GETDATE()) >= 1))
