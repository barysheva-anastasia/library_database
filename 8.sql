USE LIBRARY

--	выбрать имена всех таблиц, владелец которых - назначенный пользователь базы данных
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


--выбрать имя таблицы, имя столбца таблицы, признак того, допускает ли данный столбец 
--null-значения, название типа данных столбца таблицы, размер этого типа данных (в байтах) - для всех таблиц,
--владелец которых - назначенный пользователь базы данных
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


--	выбрать название ограничения целостности (первичные и внешние ключи), 
--имя таблицы, в которой оно находится, признак того, что это за ограничение 
--('PK' для первичного ключа и 'F' для внешнего) - для всех ограничений целостности, 
--владелец которых - назначенный пользователь базы данных
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



--выбрать название внешнего ключа, имя таблицы, содержащей внешний ключ, имя таблицы, содержащей его 
--родительский ключ - для всех внешних ключей, владелец которых - назначенный пользователь базы данных
SELECT 
	sys.foreign_keys.name,
	OBJECT_NAME(sys.foreign_keys.parent_object_id) AS parent_table_name,
	OBJECT_NAME(sys.foreign_keys.referenced_object_id) referenced_table_name
FROM 
	sys.foreign_keys
WHERE OBJECTPROPERTY(sys.foreign_keys.object_id, 'OwnerId') = 1
GO



--выбрать название представления, SQL-запрос, создающий это 
--представление - для всех представлений, владелец которых - назначенный пользователь базы данных
SELECT
	name,
	OBJECT_DEFINITION(object_id) AS 'select'
FROM sys.views
WHERE OBJECTPROPERTY(sys.views.object_id, 'OwnerId') = 1
GO

--выбрать название триггера, имя таблицы, для которой определен 
--триггер - для всех триггеров, владелец которых - назначенный пользователь базы данных
SELECT
	name,
	OBJECT_NAME(parent_id) AS 'table'
FROM sys.triggers
WHERE OBJECTPROPERTY(sys.triggers.object_id, 'OwnerId') = 1
GO