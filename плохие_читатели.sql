---Тема, название книги, фамилия читателя, дата возврата - для книг, у которых просрочен срок возврата, количество дней просрочки.
CREATE OR ALTER VIEW bad_readers
AS (
SELECT TOPIC.name AS topic, 
	BOOK_TITLE.book_title_id,
	BOOK_TITLE.name AS title,
	READER.last_name,
	DEAL.lending_date,
	DEAL.deal_id,
	DATEDIFF(day, DEAL.day_x_date, DEAL.returning_date) AS days
from BOOK_TITLE 
	JOIN ORIGINAL_BOOK ON BOOK_TITLE.original_book_id = ORIGINAL_BOOK.original_book_id
	JOIN BOOK_TOPIC ON BOOK_TOPIC.original_book_id = ORIGINAL_BOOK.original_book_id
	JOIN TOPIC ON BOOK_TOPIC.topic_id = TOPIC.topic_id
	JOIN EDITION ON EDITION.book_title_id = BOOK_TITLE.book_title_id
	JOIN BOOK ON BOOK.edition_id = EDITION.edition_id
	JOIN DEAL ON DEAL.book_id = BOOK.book_id
	JOIN READER ON DEAL.reader_id = READER.reader_id
WHERE (DEAL.day_x_date < DEAL.returning_date) )

GO

---вывести названия книг, которые задерживали не менее 50% читателей
WITH BadDeals AS
	(
	SELECT
		EDITION.book_title_id,
		BOOK_TITLE.name AS title,
		bad_readers.deal_id AS bad_deals,
		DEAL.deal_id AS deals
	FROM bad_readers
	FULL JOIN DEAL ON bad_readers.deal_id = DEAL.deal_id
	JOIN BOOK ON DEAL.book_id=BOOK.book_id
	JOIN EDITION ON BOOK.edition_id = EDITION.edition_id
	JOIN BOOK_TITLE ON EDITION.book_title_id = BOOK_TITLE.book_title_id
	),
	AllDeals AS
	(
	SELECT
		BadDeals.title,
		BadDeals.book_title_id,
		COUNT(BadDeals.bad_deals) AS badnum,
		COUNT(BadDeals.deals) num
	FROM BadDeals
	GROUP BY book_title_id, title
	)
SELECT 
	title 
FROM AllDeals
WHERE 2*badnum >= num
