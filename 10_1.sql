--10_1
USE LIBRARY
GO
SET STATISTICS IO ON
SET STATISTICS TIME ON
GO

DROP TABLE IF EXISTS Customers_without_index
SELECT *  INTO Customers_without_index FROM Customers
GO
DROP INDEX IF EXISTS Customer_nonclustered ON Customers
CREATE NONCLUSTERED INDEX Customer_nonclustered ON Customers(city) INCLUDE (contactname, phone);
GO

--Без индекса
SELECT 
	customerid,
	contactname,
	phone
FROM 
	Customers_without_index
WHERE 
	City = 'London'
GO

--С индексом
SELECT customerid, contactname, phone
FROM Customers
WITH (INDEX (Customer_nonclustered))
WHERE City = 'London'
GO

--без индекса
--Время ЦП = 281 мс, затраченное время = 1346 мс.
--с индексом
--Время ЦП = 344 мс, затраченное время = 1002 мс.