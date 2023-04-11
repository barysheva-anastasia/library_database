USE LIBRARY

SELECT 
	sys.objects.name AS 'tables'
FROM 
	sys.objects
	JOIN sys.schemas  ON sys.objects.schema_id = sys.schemas.schema_id
	JOIN sys.database_principals ON sys.schemas.principal_id = sys.database_principals.principal_id
WHERE 
	sys.database_principals.name = 'dbo'
	AND sys.objects.type = 'U'
	AND sys.objects.name != 'sysdiagrams'
GO


SELECT
	OBJECT_NAME(sys.columns.object_id) AS table_name,
	sys.columns.name AS column_name,
	sys.columns.is_nullable,
	sys.types.name AS 'type_name',
	sys.types.max_length AS size

FROM sys.columns 
JOIN sys.objects ON sys.objects.object_id = sys.columns.object_id
JOIN sys.types ON sys.types.system_type_id = sys.columns.system_type_id
WHERE 
	sys.objects.type = 'U'
	AND OBJECTPROPERTY(sys.objects.object_id, 'OwnerId') = 1
	AND sys.objects.name != 'sysdiagrams'
ORDER BY table_name
GO


SELECT 
	con.name AS constraint_name,
	tab.name AS table_name,
	con.type
FROM sys.objects AS con
	JOIN sys.schemas ON sys.schemas.schema_id = con.schema_id
	JOIN sys.database_principals ON sys.database_principals.principal_id = sys.schemas.principal_id
	JOIN sys.objects AS tab ON tab.object_id = con.parent_object_id
WHERE ((con.type = 'F')
	OR (con.type = 'PK'))
	AND (OBJECTPROPERTY(con.object_id, 'OwnerId') = 1)
	AND (tab.name != 'sysdiagrams')
GO


SELECT 
	sys.foreign_keys.name,
	OBJECT_NAME(sys.foreign_keys.parent_object_id) AS parent_table_name,
	OBJECT_NAME(sys.foreign_keys.referenced_object_id) referenced_table_name
FROM 
	sys.foreign_keys
WHERE OBJECTPROPERTY(sys.foreign_keys.object_id, 'OwnerId') = 1
GO



SELECT
	name,
	OBJECT_DEFINITION(object_id) AS 'select'
FROM sys.views
WHERE OBJECTPROPERTY(sys.views.object_id, 'OwnerId') = 1
GO


SELECT
	name,
	OBJECT_NAME(parent_id) AS 'table'
FROM sys.triggers
WHERE OBJECTPROPERTY(sys.triggers.object_id, 'OwnerId') = 1
GO
