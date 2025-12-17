import 'package:code_forge/code_forge.dart';
import 'package:code_forge/code_forge/controller.dart';
import 'package:code_forge/code_forge/suggestion_model.dart';

/// Returns SQL-specific suggestions.
List<SuggestionModel> getSqlSuggestions() {
  return [
    SuggestionModel(
      label: 'SELECT',
      description: '<p>Insert a SELECT query</p>',
      replacedOnClick: 'SELECT * FROM table_name WHERE condition;',
      triggeredAt: 'SELECT',
    ),
    SuggestionModel(
      label: 'SELECT DISTINCT',
      description: '<p>Insert a SELECT DISTINCT query</p>',
      replacedOnClick: 'SELECT DISTINCT column FROM table_name;',
      triggeredAt: 'SELECT',
    ),
    SuggestionModel(
      label: 'SELECT JOIN',
      description: '<p>Insert a SELECT with JOIN</p>',
      replacedOnClick:
          'SELECT * FROM table1 JOIN table2 ON table1.id = table2.id;',
      triggeredAt: 'SELECT',
    ),
    SuggestionModel(
      label: 'INSERT',
      description: '<p>Insert an INSERT statement</p>',
      replacedOnClick:
          'INSERT INTO table_name (column1, column2) VALUES (value1, value2);',
      triggeredAt: 'INSERT',
    ),
    SuggestionModel(
      label: 'UPDATE',
      description: '<p>Insert an UPDATE statement</p>',
      replacedOnClick:
          'UPDATE table_name SET column1 = value1 WHERE condition;',
      triggeredAt: 'UPDATE',
    ),
    SuggestionModel(
      label: 'DELETE',
      description: '<p>Insert a DELETE statement</p>',
      replacedOnClick: 'DELETE FROM table_name WHERE condition;',
      triggeredAt: 'DELETE',
    ),
    SuggestionModel(
      label: 'CREATE TABLE',
      description: '<p>Insert a CREATE TABLE statement</p>',
      replacedOnClick:
          'CREATE TABLE table_name (\n  id INT PRIMARY KEY,\n  column_name VARCHAR(255)\n);',
      triggeredAt: 'CREATE',
    ),
    SuggestionModel(
      label: 'ALTER TABLE',
      description: '<p>Insert an ALTER TABLE statement</p>',
      replacedOnClick: 'ALTER TABLE table_name ADD column_name VARCHAR(255);',
      triggeredAt: 'ALTER',
    ),
    SuggestionModel(
      label: 'DROP TABLE',
      description: '<p>Insert a DROP TABLE statement</p>',
      replacedOnClick: 'DROP TABLE table_name;',
      triggeredAt: 'DROP',
    ),
    SuggestionModel(
      label: 'WHERE',
      description: '<p>Insert a WHERE clause</p>',
      replacedOnClick: 'WHERE column = value',
      triggeredAt: 'WHERE',
    ),
    SuggestionModel(
      label: 'ORDER BY',
      description: '<p>Insert an ORDER BY clause</p>',
      replacedOnClick: 'ORDER BY column_name ASC',
      triggeredAt: 'ORDER',
    ),
    SuggestionModel(
      label: 'GROUP BY',
      description: '<p>Insert a GROUP BY clause</p>',
      replacedOnClick: 'GROUP BY column_name',
      triggeredAt: 'GROUP',
    ),
    SuggestionModel(
      label: 'HAVING',
      description: '<p>Insert a HAVING clause</p>',
      replacedOnClick: 'HAVING COUNT(*) > 1',
      triggeredAt: 'HAVING',
    ),
    SuggestionModel(
      label: 'INNER JOIN',
      description: '<p>Insert an INNER JOIN</p>',
      replacedOnClick: 'INNER JOIN table2 ON table1.id = table2.id',
      triggeredAt: 'INNER',
    ),
    SuggestionModel(
      label: 'LEFT JOIN',
      description: '<p>Insert a LEFT JOIN</p>',
      replacedOnClick: 'LEFT JOIN table2 ON table1.id = table2.id',
      triggeredAt: 'LEFT',
    ),
    SuggestionModel(
      label: 'RIGHT JOIN',
      description: '<p>Insert a RIGHT JOIN</p>',
      replacedOnClick: 'RIGHT JOIN table2 ON table1.id = table2.id',
      triggeredAt: 'RIGHT',
    ),
    SuggestionModel(
      label: 'UNION',
      description: '<p>Insert a UNION statement</p>',
      replacedOnClick: 'SELECT * FROM table1\nUNION\nSELECT * FROM table2;',
      triggeredAt: 'UNION',
    ),
    SuggestionModel(
      label: 'SUBQUERY',
      description: '<p>Insert a subquery</p>',
      replacedOnClick:
          'SELECT * FROM table WHERE id IN (SELECT id FROM other_table);',
      triggeredAt: 'SELECT',
    ),
    SuggestionModel(
      label: 'INDEX',
      description: '<p>Insert a CREATE INDEX statement</p>',
      replacedOnClick: 'CREATE INDEX index_name ON table_name (column_name);',
      triggeredAt: 'CREATE',
    ),
    SuggestionModel(
      label: 'TRANSACTION',
      description: '<p>Insert a transaction block</p>',
      replacedOnClick: 'BEGIN TRANSACTION;\n  \nCOMMIT;',
      triggeredAt: 'BEGIN',
    ),
  ];
}
