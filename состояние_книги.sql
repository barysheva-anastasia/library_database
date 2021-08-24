--- Для книги "КЭД - странная теория света и вещества" показать все ее состояния за 5 последних лет.
CREATE OR ALTER VIEW book_states
AS (
SELECT 
	READER.last_name,
	READER.first_name, 
	READER.patronym, 
	DEAL.lending_date, 
	DEAL.returning_date
FROM READER 
	JOIN DEAL ON READER.reader_id = DEAL.reader_id 
	JOIN BOOK ON DEAL.book_id = BOOK.book_id 
	JOIN EDITION ON BOOK.edition_id = EDITION.edition_id 
	JOIN BOOK_TITLE ON EDITION.book_title_id = BOOK_TITLE.book_title_id
WHERE (BOOK_TITLE.name = 'КЭД - странная теория света и вещества' 
	AND (DATEDIFF(year, DEAL.lending_date, GETDATE()) < 5 OR DATEDIFF(year, DEAL.returning_date, GETDATE()) < 5))
)
GO
SELECT * FROM book_states