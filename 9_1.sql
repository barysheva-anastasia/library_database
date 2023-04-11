USE LIBRARY
GO

DROP TRIGGER IF EXISTS TR_edition_delete
GO

CREATE TRIGGER TR_edition_delete
	ON EDITION
INSTEAD OF DELETE
	AS
		DELETE FROM BOOK_EDITORS
		WHERE BOOK_EDITORS.edition_id IN
		(
			SELECT edition_id
			FROM deleted
		)
		DELETE FROM EDITION
		WHERE EDITION.edition_id IN
		(
			SELECT edition_id
			FROM deleted
		)
		DELETE FROM BOOK_TITLE
		WHERE book_title_id IN
		(
			SELECT book_title_id
			FROM deleted
		)
