--БД "Библиотека"
--При удалении книги, удалять все записи, связанные с ней 
USE LIBRARY
GO

DROP TRIGGER IF EXISTS TR_bookcreators_delete
GO

CREATE TRIGGER TR_bookcreators_delete
	ON BOOK_CREATORS
AFTER DELETE
	AS
		DELETE FROM CREATOR
		WHERE CREATOR.creator_id IN
		(
			SELECT creator_id
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