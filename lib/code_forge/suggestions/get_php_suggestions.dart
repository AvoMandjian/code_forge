import 'package:code_forge/code_forge/suggestion_model.dart';

/// Returns PHP-specific suggestions.
List<SuggestionModel> getPhpSuggestions() {
  return [
    SuggestionModel(
      label: 'Function',
      description: 'Insert a PHP function',
      replacedOnClick: 'function functionName() {\n  \n}',
      triggeredAt: 'function',
    ),
    SuggestionModel(
      label: 'Function with Parameters',
      description: 'Insert a PHP function with parameters',
      replacedOnClick: 'function functionName(\$param1, \$param2) {\n  \n}',
      triggeredAt: 'function',
    ),
    SuggestionModel(
      label: 'Class',
      description: 'Insert a PHP class',
      replacedOnClick: 'class ClassName {\n  \n}',
      triggeredAt: 'class',
    ),
    SuggestionModel(
      label: 'Class with Constructor',
      description: 'Insert a PHP class with constructor',
      replacedOnClick:
          'class ClassName {\n  public function __construct() {\n    \n  }\n}',
      triggeredAt: 'class',
    ),
    SuggestionModel(
      label: 'Method',
      description: 'Insert a PHP method',
      replacedOnClick: 'public function methodName() {\n  \n}',
      triggeredAt: 'public',
    ),
    SuggestionModel(
      label: 'Private Method',
      description: 'Insert a PHP private method',
      replacedOnClick: 'private function methodName() {\n  \n}',
      triggeredAt: 'private',
    ),
    SuggestionModel(
      label: 'Static Method',
      description: 'Insert a PHP static method',
      replacedOnClick: 'public static function methodName() {\n  \n}',
      triggeredAt: 'public static',
    ),
    SuggestionModel(
      label: 'If Statement',
      description: 'Insert a PHP if statement',
      replacedOnClick: 'if (\$condition) {\n  \n}',
      triggeredAt: 'if',
    ),
    SuggestionModel(
      label: 'If-Else',
      description: 'Insert a PHP if-else statement',
      replacedOnClick: 'if (\$condition) {\n  \n} else {\n  \n}',
      triggeredAt: 'if',
    ),
    SuggestionModel(
      label: 'Switch Statement',
      description: 'Insert a PHP switch statement',
      replacedOnClick:
          'switch (\$value) {\n  case pattern:\n    \n    break;\n  default:\n    \n}',
      triggeredAt: 'switch',
    ),
    SuggestionModel(
      label: 'For Loop',
      description: 'Insert a PHP for loop',
      replacedOnClick: 'for (\$i = 0; \$i < count; \$i++) {\n  \n}',
      triggeredAt: 'for',
    ),
    SuggestionModel(
      label: 'Foreach Loop',
      description: 'Insert a PHP foreach loop',
      replacedOnClick: 'foreach (\$array as \$item) {\n  \n}',
      triggeredAt: 'foreach',
    ),
    SuggestionModel(
      label: 'Foreach with Key',
      description: 'Insert a PHP foreach loop with key',
      replacedOnClick: 'foreach (\$array as \$key => \$value) {\n  \n}',
      triggeredAt: 'foreach',
    ),
    SuggestionModel(
      label: 'While Loop',
      description: 'Insert a PHP while loop',
      replacedOnClick: 'while (\$condition) {\n  \n}',
      triggeredAt: 'while',
    ),
    SuggestionModel(
      label: 'Do-While Loop',
      description: 'Insert a PHP do-while loop',
      replacedOnClick: 'do {\n  \n} while (\$condition);',
      triggeredAt: 'do',
    ),
    SuggestionModel(
      label: 'Try-Catch',
      description: 'Insert a PHP try-catch block',
      replacedOnClick: 'try {\n  \n} catch (Exception \$e) {\n  \n}',
      triggeredAt: 'try',
    ),
    SuggestionModel(
      label: 'Array',
      description: 'Insert a PHP array',
      replacedOnClick: '\$array = [];',
      triggeredAt: '\$',
    ),
    SuggestionModel(
      label: 'Associative Array',
      description: 'Insert a PHP associative array',
      replacedOnClick: '\$array = ["key" => "value"];',
      triggeredAt: '\$',
    ),
    SuggestionModel(
      label: 'Echo',
      description: 'Insert a PHP echo statement',
      replacedOnClick: 'echo "";',
      triggeredAt: 'echo',
    ),
    SuggestionModel(
      label: 'Return',
      description: 'Insert a PHP return statement',
      replacedOnClick: 'return \$value;',
      triggeredAt: 'return',
    ),
    SuggestionModel(
      label: 'Namespace',
      description: 'Insert a PHP namespace',
      replacedOnClick: 'namespace NamespaceName;',
      triggeredAt: 'namespace',
    ),
    SuggestionModel(
      label: 'Use Statement',
      description: 'Insert a PHP use statement',
      replacedOnClick: 'use Namespace\\ClassName;',
      triggeredAt: 'use',
    ),
  ];
}
