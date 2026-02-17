import 'package:code_forge/code_forge/suggestion_model.dart';

/// Returns Dart-specific suggestions.
List<SuggestionModel> getDartSuggestions() {
  return [
    SuggestionModel(
      label: 'Function',
      description: 'Insert a Dart function',
      replacedOnClick: 'void functionName() {\n  \n}',
      openingTag: 'void',
      closingTag: '}',
    ),
    SuggestionModel(
      label: 'Async Function',
      description: 'Insert an async Dart function',
      replacedOnClick: 'Future<void> functionName() async {\n  \n}',
      openingTag: 'Future',
      closingTag: '}',
    ),
    SuggestionModel(
      label: 'Class',
      description: 'Insert a Dart class',
      replacedOnClick: 'class ClassName {\n  \n}',
      openingTag: 'class',
      closingTag: '}',
    ),
    SuggestionModel(
      label: 'Abstract Class',
      description: 'Insert an abstract Dart class',
      replacedOnClick: 'abstract class ClassName {\n  \n}',
      openingTag: 'abstract',
      closingTag: '}',
    ),
    SuggestionModel(
      label: 'Widget',
      description: 'Insert a Flutter widget',
      replacedOnClick: 'Widget widgetName() {\n  return Container();\n}',
      openingTag: 'Widget',
      closingTag: '}',
    ),
    SuggestionModel(
      label: 'StatelessWidget',
      description: 'Insert a Flutter StatelessWidget',
      replacedOnClick:
          'class WidgetName extends StatelessWidget {\n  @override\n  Widget build(BuildContext context) {\n    return Container();\n  }\n}',
      openingTag: 'StatelessWidget',
      closingTag: '}',
    ),
    SuggestionModel(
      label: 'StatefulWidget',
      description: 'Insert a Flutter StatefulWidget',
      replacedOnClick:
          'class WidgetName extends StatefulWidget {\n  @override\n  State<WidgetName> createState() => _WidgetNameState();\n}\n\nclass _WidgetNameState extends State<WidgetName> {\n  @override\n  Widget build(BuildContext context) {\n    return Container();\n  }\n}',
      openingTag: 'StatefulWidget',
      closingTag: '}',
    ),
    SuggestionModel(
      label: 'If Statement',
      description: 'Insert a Dart if statement',
      replacedOnClick: 'if (condition) {\n  \n}',
      openingTag: 'if',
      closingTag: '}',
    ),
    SuggestionModel(
      label: 'If-Else',
      description: 'Insert a Dart if-else statement',
      replacedOnClick: 'if (condition) {\n  \n} else {\n  \n}',
      openingTag: 'if',
      closingTag: '}',
    ),
    SuggestionModel(
      label: 'For Loop',
      description: 'Insert a Dart for loop',
      replacedOnClick: 'for (var i = 0; i < length; i++) {\n  \n}',
      openingTag: 'for',
      closingTag: '}',
    ),
    SuggestionModel(
      label: 'For-In Loop',
      description: 'Insert a Dart for-in loop',
      replacedOnClick: 'for (var item in collection) {\n  \n}',
      openingTag: 'for',
      closingTag: '}',
    ),
    SuggestionModel(
      label: 'While Loop',
      description: 'Insert a Dart while loop',
      replacedOnClick: 'while (condition) {\n  \n}',
      openingTag: 'while',
      closingTag: '}',
    ),
    SuggestionModel(
      label: 'Switch Statement',
      description: 'Insert a Dart switch statement',
      replacedOnClick:
          'switch (value) {\n  case pattern:\n    \n    break;\n  default:\n    \n}',
      openingTag: 'switch',
      closingTag: '}',
    ),
    SuggestionModel(
      label: 'Try-Catch',
      description: 'Insert a Dart try-catch block',
      replacedOnClick: 'try {\n  \n} catch (e) {\n  \n}',
      openingTag: 'try',
      closingTag: '}',
    ),
    SuggestionModel(
      label: 'List',
      description: 'Insert a Dart list',
      replacedOnClick: 'List<String> list = [];',
      openingTag: 'List',
      closingTag: ';',
    ),
    SuggestionModel(
      label: 'Map',
      description: 'Insert a Dart map',
      replacedOnClick: 'Map<String, dynamic> map = {};',
      openingTag: 'Map',
      closingTag: ';',
    ),
    SuggestionModel(
      label: 'Set',
      description: 'Insert a Dart set',
      replacedOnClick: 'Set<String> set = {};',
      openingTag: 'Set',
      closingTag: ';',
    ),
    SuggestionModel(
      label: 'Enum',
      description: 'Insert a Dart enum',
      replacedOnClick: 'enum EnumName {\n  value1,\n  value2,\n}',
      openingTag: 'enum',
      closingTag: '}',
    ),
    SuggestionModel(
      label: 'Extension',
      description: 'Insert a Dart extension',
      replacedOnClick: 'extension ExtensionName on Type {\n  \n}',
      openingTag: 'extension',
      closingTag: '}',
    ),
    SuggestionModel(
      label: 'Mixin',
      description: 'Insert a Dart mixin',
      replacedOnClick: 'mixin MixinName {\n  \n}',
      openingTag: 'mixin',
      closingTag: '}',
    ),
  ];
}
