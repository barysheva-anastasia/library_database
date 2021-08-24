--GRANT1
EXEC AS USER = 'test'

SELECT * FROM READER

BEGIN TRAN
INSERT INTO READER VALUES('Охотников', 'Никита', 'Владимирович', 'onv@phystech.edu', '+79000000029', '3315100029');
SELECT * FROM READER
ROLLBACK

BEGIN TRAN
UPDATE READER
SET passport = '3315123456'
WHERE last_name = 'Барышева'
SELECT * FROM READER
ROLLBACK

--GRANT2
SELECT reader_id FROM DEAL

BEGIN TRAN
UPDATE DEAL
SET lending_date = '27-3-2020'
WHERE reader_id = 1
ROLLBACK

--GRANT3
SELECT * FROM BOOK

--GRANT4
SELECT * FROM bad_readers

--GRANT5
BEGIN TRAN
UPDATE book_states
SET first_name = 'Настя'
WHERE last_name = 'Барышева'
select * from book_states
rollback

--CHECK1
SELECT language
FROM LANGUAGE

--CHECK2
SELECT book_id
FROM DEAL

--CHECK3
BEGIN TRAN
UPDATE BOOK
SET edition_id = 2
WHERE book_id = 3
select * from BOOK
rollback

REVERT