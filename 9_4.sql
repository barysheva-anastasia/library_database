--БД "Библиотека"
--При удалении книги, удалять все записи, связанные с ней DROP TRIGGER IF EXISTS TR_bookeditors_delete
USE LIBRARY
GO

DROP TRIGGER IF EXISTS TR_bookeditors_delete
GO

CREATE TRIGGER TR_bookeditors_delete
	ON BOOK_EDITORS
AFTER DELETE
	AS
		DELETE FROM CREATOR
		WHERE CREATOR.creator_id IN
		(
			SELECT editor_id
			FROM deleted
		)
		AND CREATOR.creator_id NOT IN
		(
			SELECT editor_id
			FROM BOOK_EDITORS
		)
		AND CREATOR.creator_id NOT IN
		(
			SELECT creator_id
			FROM BOOK_CREATORS
		)