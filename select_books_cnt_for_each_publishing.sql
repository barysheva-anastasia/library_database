CREATE OR ALTER VIEW publishing_companies
AS (
SELECT
    PUBLISHING_COMPANY.publishing_company_id,
	PUBLISHING_COMPANY.name,
	COUNT(DISTINCT BOOK.book_id) AS books_number,
	COUNT(DISTINCT DEAL.deal_id) AS deals_number
FROM 
	PUBLISHING_COMPANY 
	JOIN EDITION ON EDITION.publishing_company_id = PUBLISHING_COMPANY.publishing_company_id 
	JOIN BOOK ON BOOK.edition_id = EDITION.edition_id
	LEFT JOIN DEAL ON DEAL.book_id = BOOK.book_id
GROUP BY 
    PUBLISHING_COMPANY.publishing_company_id,
	PUBLISHING_COMPANY.name
	)
GO


WITH Topics AS
	(
	SELECT 
		BOOK_TITLE.book_title_id,
		BOOK_TITLE.name AS book_title, 
		TOPIC.topic_id, 
		TOPIC.name AS topic
	FROM TOPIC
		FULL JOIN BOOK_TOPIC ON TOPIC.topic_id = BOOK_TOPIC.topic_id
		FULL JOIN ORIGINAL_BOOK ON ORIGINAL_BOOK.original_book_id = BOOK_TOPIC.original_book_id
		FULL JOIN BOOK_TITLE ON BOOK_TITLE.original_book_id = ORIGINAL_BOOK.original_book_id
		WHERE TOPIC.topic_id = 5 
     UNION ALL 
	 SELECT 
		BOOK_TITLE.book_title_id,
		BOOK_TITLE.name,
		TOPIC.topic_id, 
		TOPIC.name 
	FROM TOPIC 
		JOIN BOOK_TOPIC ON TOPIC.topic_id = BOOK_TOPIC.topic_id
		JOIN ORIGINAL_BOOK ON ORIGINAL_BOOK.original_book_id = BOOK_TOPIC.original_book_id
		JOIN BOOK_TITLE ON BOOK_TITLE.original_book_id = ORIGINAL_BOOK.original_book_id
		INNER JOIN Topics  
		ON TOPIC.overtopic_id = Topics.topic_id
	)
SELECT
	Topics.book_title
FROM Topics 
	JOIN EDITION ON Topics.book_title_id = EDITION.book_title_id
	JOIN PUBLISHING_COMPANY ON EDITION.publishing_company_id = PUBLISHING_COMPANY.publishing_company_id
WHERE PUBLISHING_COMPANY.publishing_company_id IN 
	(
	SELECT TOP(1) publishing_companies.publishing_company_id
	FROM publishing_companies
	ORDER BY books_number DESC
	)
