import 'package:code_forge/code_forge.dart';
import 'package:code_forge/code_forge/controller.dart';
import 'package:code_forge/code_forge/suggestion_model.dart';

/// Returns C/C++-specific suggestions.
List<SuggestionModel> getCppSuggestions() {
  return [
    SuggestionModel(
      label: 'Function',
      description: 'Insert a C/C++ function',
      replacedOnClick: 'returnType functionName() {\n  \n}',
      triggeredAt: 'void',
    ),
    SuggestionModel(
      label: 'Function with Parameters',
      description: 'Insert a C/C++ function with parameters',
      replacedOnClick:
          'returnType functionName(type param1, type param2) {\n  \n}',
      triggeredAt: 'void',
    ),
    SuggestionModel(
      label: 'Class',
      description: 'Insert a C++ class',
      replacedOnClick: 'class ClassName {\npublic:\n  \nprivate:\n  \n};',
      triggeredAt: 'class',
    ),
    SuggestionModel(
      label: 'Struct',
      description: 'Insert a C/C++ struct',
      replacedOnClick: 'struct StructName {\n  type field;\n};',
      triggeredAt: 'struct',
    ),
    SuggestionModel(
      label: 'Namespace',
      description: 'Insert a C++ namespace',
      replacedOnClick: 'namespace NamespaceName {\n  \n}',
      triggeredAt: 'namespace',
    ),
    SuggestionModel(
      label: 'Include',
      description: 'Insert a C/C++ include directive',
      replacedOnClick: '#include <header.h>',
      triggeredAt: '#include',
    ),
    SuggestionModel(
      label: 'Include Local',
      description: 'Insert a local include directive',
      replacedOnClick: '#include "header.h"',
      triggeredAt: '#include',
    ),
    SuggestionModel(
      label: 'Define',
      description: 'Insert a C/C++ define macro',
      replacedOnClick: '#define MACRO_NAME value',
      triggeredAt: '#define',
    ),
    SuggestionModel(
      label: 'Ifdef',
      description: 'Insert a C/C++ ifdef directive',
      replacedOnClick: '#ifdef MACRO_NAME\n  \n#endif',
      triggeredAt: '#ifdef',
    ),
    SuggestionModel(
      label: 'Main Function',
      description: 'Insert a C/C++ main function',
      replacedOnClick: 'int main() {\n  \n  return 0;\n}',
      triggeredAt: 'int main',
    ),
    SuggestionModel(
      label: 'Main with Args',
      description: 'Insert a C/C++ main function with arguments',
      replacedOnClick: 'int main(int argc, char* argv[]) {\n  \n  return 0;\n}',
      triggeredAt: 'int main',
    ),
    SuggestionModel(
      label: 'If Statement',
      description: 'Insert a C/C++ if statement',
      replacedOnClick: 'if (condition) {\n  \n}',
      triggeredAt: 'if',
    ),
    SuggestionModel(
      label: 'If-Else',
      description: 'Insert a C/C++ if-else statement',
      replacedOnClick: 'if (condition) {\n  \n} else {\n  \n}',
      triggeredAt: 'if',
    ),
    SuggestionModel(
      label: 'Switch Statement',
      description: 'Insert a C/C++ switch statement',
      replacedOnClick:
          'switch (value) {\n  case pattern:\n    \n    break;\n  default:\n    \n}',
      triggeredAt: 'switch',
    ),
    SuggestionModel(
      label: 'For Loop',
      description: 'Insert a C/C++ for loop',
      replacedOnClick: 'for (int i = 0; i < n; i++) {\n  \n}',
      triggeredAt: 'for',
    ),
    SuggestionModel(
      label: 'While Loop',
      description: 'Insert a C/C++ while loop',
      replacedOnClick: 'while (condition) {\n  \n}',
      triggeredAt: 'while',
    ),
    SuggestionModel(
      label: 'Do-While Loop',
      description: 'Insert a C/C++ do-while loop',
      replacedOnClick: 'do {\n  \n} while (condition);',
      triggeredAt: 'do',
    ),
    SuggestionModel(
      label: 'Try-Catch',
      description: 'Insert a C++ try-catch block',
      replacedOnClick: 'try {\n  \n} catch (const std::exception& e) {\n  \n}',
      triggeredAt: 'try',
    ),
    SuggestionModel(
      label: 'Pointer',
      description: 'Insert a C/C++ pointer declaration',
      replacedOnClick: 'type* pointer;',
      triggeredAt: 'type',
    ),
    SuggestionModel(
      label: 'Reference',
      description: 'Insert a C++ reference',
      replacedOnClick: 'type& reference = variable;',
      triggeredAt: 'type',
    ),
    SuggestionModel(
      label: 'Template',
      description: 'Insert a C++ template',
      replacedOnClick: 'template<typename T>\nclass ClassName {\n  \n};',
      triggeredAt: 'template',
    ),
    SuggestionModel(
      label: 'Vector',
      description: 'Insert a C++ vector',
      replacedOnClick: 'std::vector<type> vec;',
      triggeredAt: 'std::vector',
    ),
    SuggestionModel(
      label: 'Map',
      description: 'Insert a C++ map',
      replacedOnClick: 'std::map<keyType, valueType> map;',
      triggeredAt: 'std::map',
    ),
    SuggestionModel(
      label: 'Smart Pointer',
      description: 'Insert a C++ smart pointer',
      replacedOnClick: 'std::unique_ptr<type> ptr;',
      triggeredAt: 'std::unique_ptr',
    ),
    SuggestionModel(
      label: 'Lambda',
      description: 'Insert a C++ lambda function',
      replacedOnClick: 'auto lambda = [](type param) { return value; };',
      triggeredAt: 'auto',
    ),
    SuggestionModel(
      label: 'Enum',
      description: 'Insert a C/C++ enum',
      replacedOnClick: 'enum EnumName {\n  VALUE1,\n  VALUE2,\n};',
      triggeredAt: 'enum',
    ),
    SuggestionModel(
      label: 'Enum Class',
      description: 'Insert a C++ enum class',
      replacedOnClick: 'enum class EnumName {\n  VALUE1,\n  VALUE2,\n};',
      triggeredAt: 'enum class',
    ),
  ];
}
