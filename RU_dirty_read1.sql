--READ UNCOMMITTED
--dirty read 1

USE LIBRARY
GO

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
BEGIN TRAN

UPDATE READER
SET passport = '3315111111'
WHERE (last_name = '��������') 
	and (first_name = '���������') 
	and (patronym = '����������')

ROLLBACK