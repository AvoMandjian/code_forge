import 'package:code_forge/code_forge.dart';
import 'package:code_forge/code_forge/controller.dart';

/// Returns Python-specific suggestions.
List<SuggestionModel> getPythonSuggestions() {
  return [
    SuggestionModel(
      label: 'Function',
      description: 'Insert a Python function',
      replacedOnClick: 'def function_name():\n    pass',
      triggeredAt: 'def',
    ),
    SuggestionModel(
      label: 'Async Function',
      description: 'Insert an async Python function',
      replacedOnClick: 'async def function_name():\n    pass',
      triggeredAt: 'async',
    ),
    SuggestionModel(
      label: 'Class',
      description: 'Insert a Python class',
      replacedOnClick: 'class ClassName:\n    pass',
      triggeredAt: 'class',
    ),
    SuggestionModel(
      label: 'If Statement',
      description: 'Insert a Python if statement',
      replacedOnClick: 'if condition:\n    pass',
      triggeredAt: 'if',
    ),
    SuggestionModel(
      label: 'If-Else',
      description: 'Insert a Python if-else statement',
      replacedOnClick: 'if condition:\n    pass\nelse:\n    pass',
      triggeredAt: 'if',
    ),
    SuggestionModel(
      label: 'Elif',
      description: 'Insert a Python elif statement',
      replacedOnClick:
          'if condition:\n    pass\nelif other_condition:\n    pass',
      triggeredAt: 'elif',
    ),
    SuggestionModel(
      label: 'For Loop',
      description: 'Insert a Python for loop',
      replacedOnClick: 'for item in iterable:\n    pass',
      triggeredAt: 'for',
    ),
    SuggestionModel(
      label: 'While Loop',
      description: 'Insert a Python while loop',
      replacedOnClick: 'while condition:\n    pass',
      triggeredAt: 'while',
    ),
    SuggestionModel(
      label: 'Try-Except',
      description: 'Insert a Python try-except block',
      replacedOnClick: 'try:\n    pass\nexcept Exception as e:\n    pass',
      triggeredAt: 'try',
    ),
    SuggestionModel(
      label: 'Try-Finally',
      description: 'Insert a Python try-finally block',
      replacedOnClick: 'try:\n    pass\nfinally:\n    pass',
      triggeredAt: 'try',
    ),
    SuggestionModel(
      label: 'With Statement',
      description: 'Insert a Python with statement',
      replacedOnClick: 'with open("file.txt") as f:\n    pass',
      triggeredAt: 'with',
    ),
    SuggestionModel(
      label: 'List Comprehension',
      description: 'Insert a Python list comprehension',
      replacedOnClick: '[x for x in iterable]',
      triggeredAt: '[',
    ),
    SuggestionModel(
      label: 'Dictionary Comprehension',
      description: 'Insert a Python dictionary comprehension',
      replacedOnClick: '{k: v for k, v in items}',
      triggeredAt: '{',
    ),
    SuggestionModel(
      label: 'Lambda',
      description: 'Insert a Python lambda function',
      replacedOnClick: 'lambda x: x',
      triggeredAt: 'lambda',
    ),
    SuggestionModel(
      label: 'Decorator',
      description: 'Insert a Python decorator',
      replacedOnClick: '@decorator\ndef function_name():\n    pass',
      triggeredAt: '@',
    ),
    SuggestionModel(
      label: 'Generator',
      description: 'Insert a Python generator function',
      replacedOnClick: 'def generator_name():\n    yield value',
      triggeredAt: 'def',
    ),
    SuggestionModel(
      label: 'Property',
      description: 'Insert a Python property',
      replacedOnClick:
          '@property\ndef property_name(self):\n    return self._value',
      triggeredAt: '@property',
    ),
    SuggestionModel(
      label: 'Static Method',
      description: 'Insert a Python static method',
      replacedOnClick: '@staticmethod\ndef method_name():\n    pass',
      triggeredAt: '@staticmethod',
    ),
    SuggestionModel(
      label: 'Class Method',
      description: 'Insert a Python class method',
      replacedOnClick: '@classmethod\ndef method_name(cls):\n    pass',
      triggeredAt: '@classmethod',
    ),
    SuggestionModel(
      label: 'Import',
      description: 'Insert a Python import statement',
      replacedOnClick: 'import module',
      triggeredAt: 'import',
    ),
    SuggestionModel(
      label: 'From Import',
      description: 'Insert a Python from-import statement',
      replacedOnClick: 'from module import item',
      triggeredAt: 'from',
    ),
  ];
}
