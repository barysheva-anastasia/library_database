USE LIBRARY
GO

DROP TRIGGER IF EXISTS TR_originalbook_delete
GO

CREATE TRIGGER TR_originalbook_delete
	ON ORIGINAL_BOOK
INSTEAD OF DELETE
	AS
		DELETE FROM BOOK_CREATORS
		WHERE original_book_id IN
		(
			SELECT original_book_id
			FROM deleted
		)
		DELETE FROM BOOK_TOPIC
		WHERE original_book_id IN
		(
			SELECT original_book_id
			FROM deleted
		)
		DELETE FROM ORIGINAL_BOOK
		WHERE original_book_id IN
		(
			SELECT original_book_id
			FROM deleted
		)
