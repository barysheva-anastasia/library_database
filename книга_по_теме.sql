WITH Topics AS
	(
	SELECT BOOK_TITLE.name AS book_title, TOPIC.topic_id, TOPIC.name AS topic
		FROM TOPIC
		FULL JOIN BOOK_TOPIC ON TOPIC.topic_id = BOOK_TOPIC.topic_id
		FULL JOIN ORIGINAL_BOOK ON ORIGINAL_BOOK.original_book_id = BOOK_TOPIC.original_book_id
		FULL JOIN BOOK_TITLE ON BOOK_TITLE.original_book_id = ORIGINAL_BOOK.original_book_id
		WHERE TOPIC.topic_id = 5 
     UNION ALL 
	 SELECT BOOK_TITLE.name, TOPIC.topic_id, TOPIC.name 
		FROM TOPIC 
		JOIN BOOK_TOPIC ON TOPIC.topic_id = BOOK_TOPIC.topic_id
		JOIN ORIGINAL_BOOK ON ORIGINAL_BOOK.original_book_id = BOOK_TOPIC.original_book_id
		JOIN BOOK_TITLE ON BOOK_TITLE.original_book_id = ORIGINAL_BOOK.original_book_id
		INNER JOIN Topics  
		ON TOPIC.overtopic_id = Topics.topic_id
	)
select * from Topics