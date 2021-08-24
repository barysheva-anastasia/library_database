SELECT
	ORIGINAL_BOOK.original_book_id,
	CREATOR.creator_id
FROM ORIGINAL_BOOK
	JOIN BOOK_CREATORS ON ORIGINAL_BOOK.original_book_id = BOOK_CREATORS.original_book_id
	JOIN CREATOR ON CREATOR.creator_id = BOOK_CREATORS.creator_id