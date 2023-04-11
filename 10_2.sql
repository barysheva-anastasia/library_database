SET STATISTICS IO ON
SET STATISTICS TIME ON
GO

DROP INDEX IF EXISTS Customer_clustered ON Customers
DROP INDEX IF EXISTS Orders_clustered ON Orders
DROP INDEX IF EXISTS Orders_nonclustered ON Orders
DROP INDEX IF EXISTS Customer_nonclustered ON Customers
GO

DROP TABLE IF EXISTS Customers_without_index
DROP TABLE IF EXISTS Orders_without_index
SELECT *  INTO Customers_without_index FROM Customers
SELECT *  INTO Orders_without_index FROM Orders
GO

CREATE NONCLUSTERED INDEX Orders_nonclustered ON Orders(shippeddate, freight) INCLUDE (customerid);
CREATE NONCLUSTERED INDEX Customer_nonclustered ON Customers(city) INCLUDE (companyname, customerid);
GO


SELECT 
	companyname, 
	shippeddate, 
	freight
FROM 
	Customers_without_index
	INNER JOIN Orders_without_index
		ON Orders_without_index.customerid = Customers_without_index.customerid
WHERE 
	Customers_without_index.city = 'London'
	AND Orders_without_index.shippeddate BETWEEN '19960101' AND '19971231'
	AND Orders_without_index.freight > 250


SELECT 
	companyname,
	shippeddate, 
	freight
FROM Customers
	INNER JOIN Orders
		ON Orders.customerid = Customers.customerid
WHERE Customers.city = 'London'
	AND Orders.shippeddate BETWEEN '19960101' AND '19971231'
	AND Orders.freight > 250
