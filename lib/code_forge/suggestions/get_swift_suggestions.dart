import 'package:code_forge/code_forge/suggestion_model.dart';

/// Returns Swift-specific suggestions.
List<SuggestionModel> getSwiftSuggestions() {
  return [
    SuggestionModel(
      label: 'Function',
      description: 'Insert a Swift function',
      replacedOnClick: 'func functionName() {\n  \n}',
      triggeredAt: 'func',
    ),
    SuggestionModel(
      label: 'Function with Return',
      description: 'Insert a Swift function with return type',
      replacedOnClick: 'func functionName() -> ReturnType {\n  \n}',
      triggeredAt: 'func',
    ),
    SuggestionModel(
      label: 'Function with Parameters',
      description: 'Insert a Swift function with parameters',
      replacedOnClick:
          'func functionName(param1: Type1, param2: Type2) {\n  \n}',
      triggeredAt: 'func',
    ),
    SuggestionModel(
      label: 'Class',
      description: 'Insert a Swift class',
      replacedOnClick: 'class ClassName {\n  \n}',
      triggeredAt: 'class',
    ),
    SuggestionModel(
      label: 'Struct',
      description: 'Insert a Swift struct',
      replacedOnClick: 'struct StructName {\n  \n}',
      triggeredAt: 'struct',
    ),
    SuggestionModel(
      label: 'Enum',
      description: 'Insert a Swift enum',
      replacedOnClick: 'enum EnumName {\n  case value1\n  case value2\n}',
      triggeredAt: 'enum',
    ),
    SuggestionModel(
      label: 'Protocol',
      description: 'Insert a Swift protocol',
      replacedOnClick: 'protocol ProtocolName {\n  func method()\n}',
      triggeredAt: 'protocol',
    ),
    SuggestionModel(
      label: 'Extension',
      description: 'Insert a Swift extension',
      replacedOnClick: 'extension TypeName {\n  \n}',
      triggeredAt: 'extension',
    ),
    SuggestionModel(
      label: 'If Statement',
      description: 'Insert a Swift if statement',
      replacedOnClick: 'if condition {\n  \n}',
      triggeredAt: 'if',
    ),
    SuggestionModel(
      label: 'If-Else',
      description: 'Insert a Swift if-else statement',
      replacedOnClick: 'if condition {\n  \n} else {\n  \n}',
      triggeredAt: 'if',
    ),
    SuggestionModel(
      label: 'If Let',
      description: 'Insert a Swift if let statement',
      replacedOnClick: 'if let value = optional {\n  \n}',
      triggeredAt: 'if',
    ),
    SuggestionModel(
      label: 'Guard Statement',
      description: 'Insert a Swift guard statement',
      replacedOnClick: 'guard condition else {\n  return\n}',
      triggeredAt: 'guard',
    ),
    SuggestionModel(
      label: 'Switch Statement',
      description: 'Insert a Swift switch statement',
      replacedOnClick: 'switch value {\ncase pattern:\n  \ndefault:\n  \n}',
      triggeredAt: 'switch',
    ),
    SuggestionModel(
      label: 'For Loop',
      description: 'Insert a Swift for loop',
      replacedOnClick: 'for item in collection {\n  \n}',
      triggeredAt: 'for',
    ),
    SuggestionModel(
      label: 'While Loop',
      description: 'Insert a Swift while loop',
      replacedOnClick: 'while condition {\n  \n}',
      triggeredAt: 'while',
    ),
    SuggestionModel(
      label: 'Repeat-While',
      description: 'Insert a Swift repeat-while loop',
      replacedOnClick: 'repeat {\n  \n} while condition',
      triggeredAt: 'repeat',
    ),
    SuggestionModel(
      label: 'Array',
      description: 'Insert a Swift array',
      replacedOnClick: 'var array: [Type] = []',
      triggeredAt: 'var',
    ),
    SuggestionModel(
      label: 'Dictionary',
      description: 'Insert a Swift dictionary',
      replacedOnClick: 'var dict: [KeyType: ValueType] = [:]',
      triggeredAt: 'var',
    ),
    SuggestionModel(
      label: 'Optional',
      description: 'Insert a Swift optional',
      replacedOnClick: 'var optional: Type? = nil',
      triggeredAt: 'var',
    ),
    SuggestionModel(
      label: 'Optional Binding',
      description: 'Insert Swift optional binding',
      replacedOnClick: 'if let value = optional {\n  \n}',
      triggeredAt: 'if',
    ),
    SuggestionModel(
      label: 'Closure',
      description: 'Insert a Swift closure',
      replacedOnClick: '{ (param) -> ReturnType in\n  return value\n}',
      triggeredAt: '{',
    ),
    SuggestionModel(
      label: 'Defer',
      description: 'Insert a Swift defer statement',
      replacedOnClick: 'defer {\n  \n}',
      triggeredAt: 'defer',
    ),
  ];
}
