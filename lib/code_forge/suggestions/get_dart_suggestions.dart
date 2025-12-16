import 'package:code_forge/code_forge.dart';
import 'package:code_forge/code_forge/controller.dart';
import 'package:code_forge/code_forge/suggestion_model.dart';

/// Returns Dart-specific suggestions.
List<SuggestionModel> getDartSuggestions() {
  return [
    SuggestionModel(
      label: 'Function',
      description: 'Insert a Dart function',
      replacedOnClick: 'void functionName() {\n  \n}',
      triggeredAt: 'void',
    ),
    SuggestionModel(
      label: 'Async Function',
      description: 'Insert an async Dart function',
      replacedOnClick: 'Future<void> functionName() async {\n  \n}',
      triggeredAt: 'Future',
    ),
    SuggestionModel(
      label: 'Class',
      description: 'Insert a Dart class',
      replacedOnClick: 'class ClassName {\n  \n}',
      triggeredAt: 'class',
    ),
    SuggestionModel(
      label: 'Abstract Class',
      description: 'Insert an abstract Dart class',
      replacedOnClick: 'abstract class ClassName {\n  \n}',
      triggeredAt: 'abstract',
    ),
    SuggestionModel(
      label: 'Widget',
      description: 'Insert a Flutter widget',
      replacedOnClick: 'Widget widgetName() {\n  return Container();\n}',
      triggeredAt: 'Widget',
    ),
    SuggestionModel(
      label: 'StatelessWidget',
      description: 'Insert a Flutter StatelessWidget',
      replacedOnClick:
          'class WidgetName extends StatelessWidget {\n  @override\n  Widget build(BuildContext context) {\n    return Container();\n  }\n}',
      triggeredAt: 'StatelessWidget',
    ),
    SuggestionModel(
      label: 'StatefulWidget',
      description: 'Insert a Flutter StatefulWidget',
      replacedOnClick:
          'class WidgetName extends StatefulWidget {\n  @override\n  State<WidgetName> createState() => _WidgetNameState();\n}\n\nclass _WidgetNameState extends State<WidgetName> {\n  @override\n  Widget build(BuildContext context) {\n    return Container();\n  }\n}',
      triggeredAt: 'StatefulWidget',
    ),
    SuggestionModel(
      label: 'If Statement',
      description: 'Insert a Dart if statement',
      replacedOnClick: 'if (condition) {\n  \n}',
      triggeredAt: 'if',
    ),
    SuggestionModel(
      label: 'If-Else',
      description: 'Insert a Dart if-else statement',
      replacedOnClick: 'if (condition) {\n  \n} else {\n  \n}',
      triggeredAt: 'if',
    ),
    SuggestionModel(
      label: 'For Loop',
      description: 'Insert a Dart for loop',
      replacedOnClick: 'for (var i = 0; i < length; i++) {\n  \n}',
      triggeredAt: 'for',
    ),
    SuggestionModel(
      label: 'For-In Loop',
      description: 'Insert a Dart for-in loop',
      replacedOnClick: 'for (var item in collection) {\n  \n}',
      triggeredAt: 'for',
    ),
    SuggestionModel(
      label: 'While Loop',
      description: 'Insert a Dart while loop',
      replacedOnClick: 'while (condition) {\n  \n}',
      triggeredAt: 'while',
    ),
    SuggestionModel(
      label: 'Switch Statement',
      description: 'Insert a Dart switch statement',
      replacedOnClick:
          'switch (value) {\n  case pattern:\n    \n    break;\n  default:\n    \n}',
      triggeredAt: 'switch',
    ),
    SuggestionModel(
      label: 'Try-Catch',
      description: 'Insert a Dart try-catch block',
      replacedOnClick: 'try {\n  \n} catch (e) {\n  \n}',
      triggeredAt: 'try',
    ),
    SuggestionModel(
      label: 'List',
      description: 'Insert a Dart list',
      replacedOnClick: 'List<String> list = [];',
      triggeredAt: 'List',
    ),
    SuggestionModel(
      label: 'Map',
      description: 'Insert a Dart map',
      replacedOnClick: 'Map<String, dynamic> map = {};',
      triggeredAt: 'Map',
    ),
    SuggestionModel(
      label: 'Set',
      description: 'Insert a Dart set',
      replacedOnClick: 'Set<String> set = {};',
      triggeredAt: 'Set',
    ),
    SuggestionModel(
      label: 'Enum',
      description: 'Insert a Dart enum',
      replacedOnClick: 'enum EnumName {\n  value1,\n  value2,\n}',
      triggeredAt: 'enum',
    ),
    SuggestionModel(
      label: 'Extension',
      description: 'Insert a Dart extension',
      replacedOnClick: 'extension ExtensionName on Type {\n  \n}',
      triggeredAt: 'extension',
    ),
    SuggestionModel(
      label: 'Mixin',
      description: 'Insert a Dart mixin',
      replacedOnClick: 'mixin MixinName {\n  \n}',
      triggeredAt: 'mixin',
    ),
  ];
}
