USE LIBRARY
GO

DROP TRIGGER IF EXISTS TR_book_delete
GO

CREATE TRIGGER TR_book_delete
	ON BOOK
INSTEAD OF DELETE
	AS
		DELETE FROM DEAL
		WHERE DEAL.book_id IN
		(
			SELECT book_id
			FROM deleted
		)
		DELETE FROM BOOK
		WHERE BOOK.book_id IN
		(
			SELECT deleted.book_id
			FROM deleted
		)
		DELETE FROM EDITION
				WHERE EDITION.edition_id NOT IN
				(
					SELECT EDITION.edition_id
					FROM EDITION
						JOIN BOOK ON EDITION.edition_id = BOOK.edition_id
					WHERE BOOK.book_id IN
					(
						SELECT deleted.book_id
						FROM deleted 
					)
				)
				AND EDITION.edition_id IN
				(
					SELECT EDITION.edition_id
					FROM EDITION
						JOIN deleted ON EDITION.edition_id = deleted.edition_id
				)
go

--------------------------------------------

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
go
-------------------------------------------------
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
go
--------------------------------------------------------------------------------
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
go
-----------------------------------------------------
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
go
----------------------------------------------------

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
go
----------------------------------------------		

BEGIN TRAN
DELETE FROM BOOK
WHERE book_id = 1
ROLLBACK

BEGIN TRAN
DELETE FROM BOOK
WHERE location_id = 2
ROLLBACK
