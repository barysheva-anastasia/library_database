CREATE OR ALTER VIEW good_readers
AS  
	WITH bad_reader AS
	(
	SELECT 
		READER.reader_id AS reader
	FROM 
		DEAL
		JOIN READER ON DEAL.reader_id = READER.reader_id
	WHERE 
		DEAL.day_x_date < ISNULL(DEAL.returning_date, GETDATE())
	) 
SELECT 
	READER.reader_id,
	READER.last_name,
	READER.first_name, 
	READER.patronym, 
	READER.passport,
	COUNT(*) num
FROM 
	DEAL
	JOIN READER ON DEAL.reader_id = READER.reader_id
	left join bad_reader on READER.reader_id = bad_reader.reader
WHERE 	
	bad_reader.reader is null
GROUP BY 
	READER.reader_id,
	READER.last_name, 
	READER.first_name, 
	READER.patronym,
	READER.passport 
GO

SELECT TOP(1) WITH TIES
READER.last_name, READER.first_name, COUNT(*) AS number_of_books
FROM READER 
	JOIN DEAL ON READER.reader_id = DEAL.reader_id
	INNER JOIN good_readers ON READER.reader_id = good_readers.reader_id
GROUP BY READER.last_name, READER.first_name
ORDER BY number_of_books DESC
