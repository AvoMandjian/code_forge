import 'package:code_forge/code_forge.dart';
import 'package:code_forge/code_forge/controller.dart';

/// Returns SQL-specific suggestions.
List<SuggestionModel> getSqlSuggestions() {
  return [
    SuggestionModel(
      label: 'SELECT',
      description: 'Insert a SELECT query',
      replacedOnClick: 'SELECT * FROM table_name WHERE condition;',
      triggeredAt: 'SELECT',
    ),
    SuggestionModel(
      label: 'SELECT DISTINCT',
      description: 'Insert a SELECT DISTINCT query',
      replacedOnClick: 'SELECT DISTINCT column FROM table_name;',
      triggeredAt: 'SELECT',
    ),
    SuggestionModel(
      label: 'SELECT JOIN',
      description: 'Insert a SELECT with JOIN',
      replacedOnClick:
          'SELECT * FROM table1 JOIN table2 ON table1.id = table2.id;',
      triggeredAt: 'SELECT',
    ),
    SuggestionModel(
      label: 'INSERT',
      description: 'Insert an INSERT statement',
      replacedOnClick:
          'INSERT INTO table_name (column1, column2) VALUES (value1, value2);',
      triggeredAt: 'INSERT',
    ),
    SuggestionModel(
      label: 'UPDATE',
      description: 'Insert an UPDATE statement',
      replacedOnClick:
          'UPDATE table_name SET column1 = value1 WHERE condition;',
      triggeredAt: 'UPDATE',
    ),
    SuggestionModel(
      label: 'DELETE',
      description: 'Insert a DELETE statement',
      replacedOnClick: 'DELETE FROM table_name WHERE condition;',
      triggeredAt: 'DELETE',
    ),
    SuggestionModel(
      label: 'CREATE TABLE',
      description: 'Insert a CREATE TABLE statement',
      replacedOnClick:
          'CREATE TABLE table_name (\n  id INT PRIMARY KEY,\n  column_name VARCHAR(255)\n);',
      triggeredAt: 'CREATE',
    ),
    SuggestionModel(
      label: 'ALTER TABLE',
      description: 'Insert an ALTER TABLE statement',
      replacedOnClick: 'ALTER TABLE table_name ADD column_name VARCHAR(255);',
      triggeredAt: 'ALTER',
    ),
    SuggestionModel(
      label: 'DROP TABLE',
      description: 'Insert a DROP TABLE statement',
      replacedOnClick: 'DROP TABLE table_name;',
      triggeredAt: 'DROP',
    ),
    SuggestionModel(
      label: 'WHERE',
      description: 'Insert a WHERE clause',
      replacedOnClick: 'WHERE column = value',
      triggeredAt: 'WHERE',
    ),
    SuggestionModel(
      label: 'ORDER BY',
      description: 'Insert an ORDER BY clause',
      replacedOnClick: 'ORDER BY column_name ASC',
      triggeredAt: 'ORDER',
    ),
    SuggestionModel(
      label: 'GROUP BY',
      description: 'Insert a GROUP BY clause',
      replacedOnClick: 'GROUP BY column_name',
      triggeredAt: 'GROUP',
    ),
    SuggestionModel(
      label: 'HAVING',
      description: 'Insert a HAVING clause',
      replacedOnClick: 'HAVING COUNT(*) > 1',
      triggeredAt: 'HAVING',
    ),
    SuggestionModel(
      label: 'INNER JOIN',
      description: 'Insert an INNER JOIN',
      replacedOnClick: 'INNER JOIN table2 ON table1.id = table2.id',
      triggeredAt: 'INNER',
    ),
    SuggestionModel(
      label: 'LEFT JOIN',
      description: 'Insert a LEFT JOIN',
      replacedOnClick: 'LEFT JOIN table2 ON table1.id = table2.id',
      triggeredAt: 'LEFT',
    ),
    SuggestionModel(
      label: 'RIGHT JOIN',
      description: 'Insert a RIGHT JOIN',
      replacedOnClick: 'RIGHT JOIN table2 ON table1.id = table2.id',
      triggeredAt: 'RIGHT',
    ),
    SuggestionModel(
      label: 'UNION',
      description: 'Insert a UNION statement',
      replacedOnClick: 'SELECT * FROM table1\nUNION\nSELECT * FROM table2;',
      triggeredAt: 'UNION',
    ),
    SuggestionModel(
      label: 'SUBQUERY',
      description: 'Insert a subquery',
      replacedOnClick:
          'SELECT * FROM table WHERE id IN (SELECT id FROM other_table);',
      triggeredAt: 'SELECT',
    ),
    SuggestionModel(
      label: 'INDEX',
      description: 'Insert a CREATE INDEX statement',
      replacedOnClick: 'CREATE INDEX index_name ON table_name (column_name);',
      triggeredAt: 'CREATE',
    ),
    SuggestionModel(
      label: 'TRANSACTION',
      description: 'Insert a transaction block',
      replacedOnClick: 'BEGIN TRANSACTION;\n  \nCOMMIT;',
      triggeredAt: 'BEGIN',
    ),
  ];
}
