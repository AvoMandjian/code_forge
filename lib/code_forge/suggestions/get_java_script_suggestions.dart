import 'package:code_forge/code_forge.dart';
import 'package:code_forge/code_forge/controller.dart';
import 'package:code_forge/code_forge/suggestion_model.dart';

/// Returns JavaScript/TypeScript-specific suggestions.
List<SuggestionModel> getJavaScriptSuggestions() {
  return [
    SuggestionModel(
      label: 'Function',
      description: 'Insert a JavaScript function',
      replacedOnClick: 'function functionName() {\n  \n}',
      triggeredAt: 'function',
    ),
    SuggestionModel(
      label: 'Arrow Function',
      description: 'Insert an arrow function',
      replacedOnClick: 'const functionName = () => {\n  \n};',
      triggeredAt: 'const',
    ),
    SuggestionModel(
      label: 'Async Function',
      description: 'Insert an async function',
      replacedOnClick: 'async function functionName() {\n  \n}',
      triggeredAt: 'async',
    ),
    SuggestionModel(
      label: 'Async Arrow Function',
      description: 'Insert an async arrow function',
      replacedOnClick: 'const functionName = async () => {\n  \n};',
      triggeredAt: 'const',
    ),
    SuggestionModel(
      label: 'Class',
      description: 'Insert a JavaScript/TypeScript class',
      replacedOnClick: 'class ClassName {\n  constructor() {\n    \n  }\n}',
      triggeredAt: 'class',
    ),
    SuggestionModel(
      label: 'If Statement',
      description: 'Insert an if statement',
      replacedOnClick: 'if (condition) {\n  \n}',
      triggeredAt: 'if',
    ),
    SuggestionModel(
      label: 'If-Else',
      description: 'Insert an if-else statement',
      replacedOnClick: 'if (condition) {\n  \n} else {\n  \n}',
      triggeredAt: 'if',
    ),
    SuggestionModel(
      label: 'For Loop',
      description: 'Insert a for loop',
      replacedOnClick: 'for (let i = 0; i < length; i++) {\n  \n}',
      triggeredAt: 'for',
    ),
    SuggestionModel(
      label: 'For-Of Loop',
      description: 'Insert a for-of loop',
      replacedOnClick: 'for (const item of array) {\n  \n}',
      triggeredAt: 'for',
    ),
    SuggestionModel(
      label: 'For-In Loop',
      description: 'Insert a for-in loop',
      replacedOnClick: 'for (const key in object) {\n  \n}',
      triggeredAt: 'for',
    ),
    SuggestionModel(
      label: 'While Loop',
      description: 'Insert a while loop',
      replacedOnClick: 'while (condition) {\n  \n}',
      triggeredAt: 'while',
    ),
    SuggestionModel(
      label: 'Do-While Loop',
      description: 'Insert a do-while loop',
      replacedOnClick: 'do {\n  \n} while (condition);',
      triggeredAt: 'do',
    ),
    SuggestionModel(
      label: 'Switch Statement',
      description: 'Insert a switch statement',
      replacedOnClick:
          'switch (value) {\n  case pattern:\n    \n    break;\n  default:\n    \n}',
      triggeredAt: 'switch',
    ),
    SuggestionModel(
      label: 'Try-Catch',
      description: 'Insert a try-catch block',
      replacedOnClick: 'try {\n  \n} catch (error) {\n  \n}',
      triggeredAt: 'try',
    ),
    SuggestionModel(
      label: 'Try-Catch-Finally',
      description: 'Insert a try-catch-finally block',
      replacedOnClick: 'try {\n  \n} catch (error) {\n  \n} finally {\n  \n}',
      triggeredAt: 'try',
    ),
    SuggestionModel(
      label: 'Promise',
      description: 'Insert a Promise',
      replacedOnClick: 'new Promise((resolve, reject) => {\n  \n});',
      triggeredAt: 'Promise',
    ),
    SuggestionModel(
      label: 'Async-Await',
      description: 'Insert async-await pattern',
      replacedOnClick: 'const result = await asyncFunction();',
      triggeredAt: 'await',
    ),
    SuggestionModel(
      label: 'Array',
      description: 'Insert an array',
      replacedOnClick: 'const array = [];',
      triggeredAt: 'const',
    ),
    SuggestionModel(
      label: 'Object',
      description: 'Insert an object',
      replacedOnClick: 'const object = {};',
      triggeredAt: 'const',
    ),
    SuggestionModel(
      label: 'Map',
      description: 'Insert a Map',
      replacedOnClick: 'const map = new Map();',
      triggeredAt: 'const',
    ),
    SuggestionModel(
      label: 'Set',
      description: 'Insert a Set',
      replacedOnClick: 'const set = new Set();',
      triggeredAt: 'const',
    ),
    SuggestionModel(
      label: 'Template Literal',
      description: 'Insert a template literal',
      replacedOnClick: '`string \${variable}`',
      triggeredAt: '`',
    ),
    SuggestionModel(
      label: 'Export',
      description: 'Insert an export statement',
      replacedOnClick: 'export default functionName;',
      triggeredAt: 'export',
    ),
    SuggestionModel(
      label: 'Import',
      description: 'Insert an import statement',
      replacedOnClick: 'import functionName from "./module";',
      triggeredAt: 'import',
    ),
    SuggestionModel(
      label: 'Require',
      description: 'Insert a require statement',
      replacedOnClick: 'const module = require("./module");',
      triggeredAt: 'require',
    ),
    SuggestionModel(
      label: 'TypeScript Interface',
      description: 'Insert a TypeScript interface',
      replacedOnClick: 'interface InterfaceName {\n  property: type;\n}',
      triggeredAt: 'interface',
    ),
    SuggestionModel(
      label: 'TypeScript Type',
      description: 'Insert a TypeScript type alias',
      replacedOnClick: 'type TypeName = string;',
      triggeredAt: 'type',
    ),
    SuggestionModel(
      label: 'TypeScript Enum',
      description: 'Insert a TypeScript enum',
      replacedOnClick: 'enum EnumName {\n  Value1,\n  Value2,\n}',
      triggeredAt: 'enum',
    ),
  ];
}
