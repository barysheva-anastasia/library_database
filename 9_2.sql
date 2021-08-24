--БД "Библиотека"
--При удалении книги, удалять все записи, связанные с ней 
USE LIBRARY
GO

DROP TRIGGER IF EXISTS TR_booktitle_delete
GO

CREATE TRIGGER TR_booktitle_delete
	ON BOOK_TITLE
AFTER DELETE
	AS
		DELETE FROM ORIGINAL_BOOK
		WHERE original_book_id IN
		(
			SELECT original_book_id
			FROM deleted
		)
		AND original_book_id NOT IN
		(
			SELECT ORIGINAL_BOOK.original_book_id
			FROM ORIGINAL_BOOK
				JOIN BOOK_TITLE ON ORIGINAL_BOOK.original_book_id = BOOK_TITLE.original_book_id
		)