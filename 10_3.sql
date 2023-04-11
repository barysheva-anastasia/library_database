SET STATISTICS IO ON
SET STATISTICS TIME ON
GO

DROP INDEX IF EXISTS Non_Customers ON Customers
DROP INDEX IF EXISTS Non_Orders ON Orders
DROP INDEX IF EXISTS Non_Products ON Products
DROP INDEX IF EXISTS Non_OrderDetails ON OrderDetails
GO

DROP TABLE IF EXISTS Customers_without_index
DROP TABLE IF EXISTS Orders_without_index
DROP TABLE IF EXISTS OrderDetails_without_index
DROP TABLE IF EXISTS Products_without_index
GO

SELECT *  INTO Customers_without_index FROM Customers
SELECT *  INTO Orders_without_index FROM Orders
SELECT *  INTO OrderDetails_without_index FROM OrderDetails
SELECT *  INTO Products_without_index FROM Products
GO

CREATE NONCLUSTERED INDEX Non_Customers ON Customers(City)
CREATE NONCLUSTERED INDEX Non_Orders ON Orders(EmployeeID)
CREATE NONCLUSTERED INDEX Non_Products ON Products (UnitsInStock)
CREATE NONCLUSTERED INDEX Non_OrderDetails ON OrderDetails (Discount)
GO


SELECT 
	Customers_without_index.CustomerID, 
	EmployeeID, 
	City, 
	Products_without_index.ProductID, 
	Products_without_index.UnitsInStock, 
	OrderDetails_without_index.Discount
FROM Customers_without_index 
	JOIN Orders_without_index ON Customers_without_index.CustomerID = Orders_without_index.CustomerID
	JOIN OrderDetails_without_index ON Orders_without_index.OrderID = OrderDetails_without_index.OrderID
	JOIN Products_without_index ON OrderDetails_without_index.ProductID = Products_without_index.ProductID
WHERE
	  EmployeeID = 1 AND
	  City = 'London' AND
	  OrderDetails_without_index.Discount = 0 AND
	  Products_without_index.UnitsInStock < 20
GO


SELECT Customers.CustomerID, EmployeeID, City, Products.ProductID, Products.UnitsInStock, OrderDetails.Discount
FROM Customers 
	JOIN Orders ON Customers.CustomerID = Orders.CustomerID
	JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID 
	JOIN Products ON OrderDetails.ProductID = Products.ProductID
WHERE 
	  EmployeeID = 1 AND
	  City = 'London' AND
	  OrderDetails.Discount = 0 AND
	  Products.UnitsInStock < 20
GO
