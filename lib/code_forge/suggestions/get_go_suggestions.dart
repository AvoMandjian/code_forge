import 'package:code_forge/code_forge.dart';
import 'package:code_forge/code_forge/controller.dart';

/// Returns Go-specific suggestions.
List<SuggestionModel> getGoSuggestions() {
  return [
    SuggestionModel(
      label: 'Function',
      description: 'Insert a Go function',
      replacedOnClick: 'func functionName() {\n  \n}',
      triggeredAt: 'func',
    ),
    SuggestionModel(
      label: 'Function with Return',
      description: 'Insert a Go function with return type',
      replacedOnClick: 'func functionName() returnType {\n  \n}',
      triggeredAt: 'func',
    ),
    SuggestionModel(
      label: 'Function with Parameters',
      description: 'Insert a Go function with parameters',
      replacedOnClick: 'func functionName(param1 type1, param2 type2) {\n  \n}',
      triggeredAt: 'func',
    ),
    SuggestionModel(
      label: 'Multiple Return Values',
      description: 'Insert a Go function with multiple return values',
      replacedOnClick:
          'func functionName() (type1, type2) {\n  return value1, value2\n}',
      triggeredAt: 'func',
    ),
    SuggestionModel(
      label: 'Method',
      description: 'Insert a Go method',
      replacedOnClick: 'func (r Receiver) methodName() {\n  \n}',
      triggeredAt: 'func',
    ),
    SuggestionModel(
      label: 'Struct',
      description: 'Insert a Go struct',
      replacedOnClick: 'type StructName struct {\n  FieldName string\n}',
      triggeredAt: 'type',
    ),
    SuggestionModel(
      label: 'Interface',
      description: 'Insert a Go interface',
      replacedOnClick: 'type InterfaceName interface {\n  MethodName()\n}',
      triggeredAt: 'type',
    ),
    SuggestionModel(
      label: 'If Statement',
      description: 'Insert a Go if statement',
      replacedOnClick: 'if condition {\n  \n}',
      triggeredAt: 'if',
    ),
    SuggestionModel(
      label: 'If-Else',
      description: 'Insert a Go if-else statement',
      replacedOnClick: 'if condition {\n  \n} else {\n  \n}',
      triggeredAt: 'if',
    ),
    SuggestionModel(
      label: 'If with Initialization',
      description: 'Insert a Go if with initialization',
      replacedOnClick: 'if err := function(); err != nil {\n  \n}',
      triggeredAt: 'if',
    ),
    SuggestionModel(
      label: 'Switch Statement',
      description: 'Insert a Go switch statement',
      replacedOnClick: 'switch value {\ncase pattern:\n  \ndefault:\n  \n}',
      triggeredAt: 'switch',
    ),
    SuggestionModel(
      label: 'For Loop',
      description: 'Insert a Go for loop',
      replacedOnClick: 'for i := 0; i < length; i++ {\n  \n}',
      triggeredAt: 'for',
    ),
    SuggestionModel(
      label: 'For Range',
      description: 'Insert a Go for range loop',
      replacedOnClick: 'for index, value := range collection {\n  \n}',
      triggeredAt: 'for',
    ),
    SuggestionModel(
      label: 'Infinite Loop',
      description: 'Insert a Go infinite loop',
      replacedOnClick: 'for {\n  \n}',
      triggeredAt: 'for',
    ),
    SuggestionModel(
      label: 'Defer',
      description: 'Insert a Go defer statement',
      replacedOnClick: 'defer function()',
      triggeredAt: 'defer',
    ),
    SuggestionModel(
      label: 'Goroutine',
      description: 'Insert a Go goroutine',
      replacedOnClick: 'go function()',
      triggeredAt: 'go',
    ),
    SuggestionModel(
      label: 'Channel',
      description: 'Insert a Go channel',
      replacedOnClick: 'ch := make(chan type)',
      triggeredAt: 'ch',
    ),
    SuggestionModel(
      label: 'Select',
      description: 'Insert a Go select statement',
      replacedOnClick: 'select {\ncase msg := <-ch:\n  \ndefault:\n  \n}',
      triggeredAt: 'select',
    ),
    SuggestionModel(
      label: 'Slice',
      description: 'Insert a Go slice',
      replacedOnClick: 'slice := []type{}',
      triggeredAt: 'slice',
    ),
    SuggestionModel(
      label: 'Map',
      description: 'Insert a Go map',
      replacedOnClick: 'm := make(map[keyType]valueType)',
      triggeredAt: 'm',
    ),
    SuggestionModel(
      label: 'Error Handling',
      description: 'Insert Go error handling',
      replacedOnClick: 'if err != nil {\n  return err\n}',
      triggeredAt: 'if',
    ),
    SuggestionModel(
      label: 'Main Function',
      description: 'Insert a Go main function',
      replacedOnClick: 'func main() {\n  \n}',
      triggeredAt: 'func main',
    ),
    SuggestionModel(
      label: 'Package',
      description: 'Insert a Go package declaration',
      replacedOnClick: 'package main',
      triggeredAt: 'package',
    ),
    SuggestionModel(
      label: 'Import',
      description: 'Insert a Go import statement',
      replacedOnClick: 'import "package"',
      triggeredAt: 'import',
    ),
  ];
}
