import 'package:code_forge/code_forge.dart';
import 'package:code_forge/code_forge/controller.dart';

/// Returns Kotlin-specific suggestions.
List<SuggestionModel> getKotlinSuggestions() {
  return [
    SuggestionModel(
      label: 'Function',
      description: 'Insert a Kotlin function',
      replacedOnClick: 'fun functionName() {\n  \n}',
      triggeredAt: 'fun',
    ),
    SuggestionModel(
      label: 'Function with Return',
      description: 'Insert a Kotlin function with return type',
      replacedOnClick: 'fun functionName(): ReturnType {\n  \n}',
      triggeredAt: 'fun',
    ),
    SuggestionModel(
      label: 'Function with Parameters',
      description: 'Insert a Kotlin function with parameters',
      replacedOnClick:
          'fun functionName(param1: Type1, param2: Type2) {\n  \n}',
      triggeredAt: 'fun',
    ),
    SuggestionModel(
      label: 'Class',
      description: 'Insert a Kotlin class',
      replacedOnClick: 'class ClassName {\n  \n}',
      triggeredAt: 'class',
    ),
    SuggestionModel(
      label: 'Data Class',
      description: 'Insert a Kotlin data class',
      replacedOnClick: 'data class ClassName(\n  val property: Type\n)',
      triggeredAt: 'data class',
    ),
    SuggestionModel(
      label: 'Sealed Class',
      description: 'Insert a Kotlin sealed class',
      replacedOnClick: 'sealed class ClassName {\n  \n}',
      triggeredAt: 'sealed',
    ),
    SuggestionModel(
      label: 'Interface',
      description: 'Insert a Kotlin interface',
      replacedOnClick: 'interface InterfaceName {\n  fun method()\n}',
      triggeredAt: 'interface',
    ),
    SuggestionModel(
      label: 'Object',
      description: 'Insert a Kotlin object',
      replacedOnClick: 'object ObjectName {\n  \n}',
      triggeredAt: 'object',
    ),
    SuggestionModel(
      label: 'If Expression',
      description: 'Insert a Kotlin if expression',
      replacedOnClick: 'if (condition) {\n  \n}',
      triggeredAt: 'if',
    ),
    SuggestionModel(
      label: 'If-Else',
      description: 'Insert a Kotlin if-else expression',
      replacedOnClick: 'if (condition) {\n  \n} else {\n  \n}',
      triggeredAt: 'if',
    ),
    SuggestionModel(
      label: 'When Expression',
      description: 'Insert a Kotlin when expression',
      replacedOnClick: 'when (value) {\n  pattern -> \n}',
      triggeredAt: 'when',
    ),
    SuggestionModel(
      label: 'For Loop',
      description: 'Insert a Kotlin for loop',
      replacedOnClick: 'for (item in collection) {\n  \n}',
      triggeredAt: 'for',
    ),
    SuggestionModel(
      label: 'While Loop',
      description: 'Insert a Kotlin while loop',
      replacedOnClick: 'while (condition) {\n  \n}',
      triggeredAt: 'while',
    ),
    SuggestionModel(
      label: 'Do-While Loop',
      description: 'Insert a Kotlin do-while loop',
      replacedOnClick: 'do {\n  \n} while (condition)',
      triggeredAt: 'do',
    ),
    SuggestionModel(
      label: 'Try-Catch',
      description: 'Insert a Kotlin try-catch block',
      replacedOnClick: 'try {\n  \n} catch (e: Exception) {\n  \n}',
      triggeredAt: 'try',
    ),
    SuggestionModel(
      label: 'List',
      description: 'Insert a Kotlin list',
      replacedOnClick: 'val list: List<Type> = listOf()',
      triggeredAt: 'val',
    ),
    SuggestionModel(
      label: 'Mutable List',
      description: 'Insert a Kotlin mutable list',
      replacedOnClick: 'val list = mutableListOf<Type>()',
      triggeredAt: 'val',
    ),
    SuggestionModel(
      label: 'Map',
      description: 'Insert a Kotlin map',
      replacedOnClick: 'val map: Map<KeyType, ValueType> = mapOf()',
      triggeredAt: 'val',
    ),
    SuggestionModel(
      label: 'Set',
      description: 'Insert a Kotlin set',
      replacedOnClick: 'val set: Set<Type> = setOf()',
      triggeredAt: 'val',
    ),
    SuggestionModel(
      label: 'Lambda',
      description: 'Insert a Kotlin lambda',
      replacedOnClick: '{ param -> value }',
      triggeredAt: '{',
    ),
    SuggestionModel(
      label: 'Extension Function',
      description: 'Insert a Kotlin extension function',
      replacedOnClick: 'fun Type.extensionFunction() {\n  \n}',
      triggeredAt: 'fun',
    ),
    SuggestionModel(
      label: 'Null Safety',
      description: 'Insert Kotlin null safety',
      replacedOnClick: 'val value = nullable?.property',
      triggeredAt: 'val',
    ),
    SuggestionModel(
      label: 'Elvis Operator',
      description: 'Insert Kotlin elvis operator',
      replacedOnClick: 'val value = nullable ?: defaultValue',
      triggeredAt: 'val',
    ),
  ];
}
