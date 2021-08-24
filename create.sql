USE LIBRARY

DROP USER IF EXISTS test
DROP LOGIN test
DROP ROLE IF EXISTS test_role
DROP USER IF EXISTS test1
--REVOKE IMPERSONATE ON LOGIN::test1 to test  
DROP LOGIN test1

CREATE LOGIN test
	WITH PASSWORD = 'QWERTY';

CREATE LOGIN test1
	WITH PASSWORD = '1234';

CREATE USER test FOR LOGIN test

CREATE USER test1 FOR LOGIN test1
--
DENY IMPERSONATE ON LOGIN::test1 to test
--



GRANT SELECT, INSERT, UPDATE ON READER TO test                                            --GRANT1
GRANT SELECT, UPDATE ON DEAL(reader_id, lending_date, returning_date) TO test             --GRANT2
GRANT SELECT ON BOOK TO test                                                              --GRANT3

GRANT SELECT ON bad_readers TO test                                                       --GRANT4


CREATE ROLE test_role
GRANT UPDATE ON book_states(first_name) TO test_role
GRANT SELECT ON book_states TO test_role
ALTER ROLE test_role                                                                      --GRANT5
--add member test
drop member test

DENY INSERT, DELETE, UPDATE ON BOOK_STATES TO test
REVOKE INSERT, DELETE, UPDATE ON BOOK_STATES TO test















/*GRANT SELECT ON ORIGINAL_BOOK TO test_role
GRANT SELECT ON CREATOR TO test_role*/