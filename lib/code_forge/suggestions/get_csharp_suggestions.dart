import 'package:code_forge/code_forge/suggestion_model.dart';

/// Returns C#-specific suggestions.
List<SuggestionModel> getCsharpSuggestions() {
  return [
    SuggestionModel(
      label: 'Class',
      description: 'Insert a C# class',
      replacedOnClick: 'public class ClassName\n{\n  \n}',
      triggeredAt: 'class',
    ),
    SuggestionModel(
      label: 'Abstract Class',
      description: 'Insert an abstract C# class',
      replacedOnClick: 'public abstract class ClassName\n{\n  \n}',
      triggeredAt: 'abstract',
    ),
    SuggestionModel(
      label: 'Interface',
      description: 'Insert a C# interface',
      replacedOnClick:
          'public interface IInterfaceName\n{\n  void Method();\n}',
      triggeredAt: 'interface',
    ),
    SuggestionModel(
      label: 'Struct',
      description: 'Insert a C# struct',
      replacedOnClick: 'public struct StructName\n{\n  \n}',
      triggeredAt: 'struct',
    ),
    SuggestionModel(
      label: 'Enum',
      description: 'Insert a C# enum',
      replacedOnClick: 'public enum EnumName\n{\n  Value1,\n  Value2,\n}',
      triggeredAt: 'enum',
    ),
    SuggestionModel(
      label: 'Method',
      description: 'Insert a C# method',
      replacedOnClick: 'public void MethodName()\n{\n  \n}',
      triggeredAt: 'public',
    ),
    SuggestionModel(
      label: 'Static Method',
      description: 'Insert a static C# method',
      replacedOnClick: 'public static void MethodName()\n{\n  \n}',
      triggeredAt: 'public static',
    ),
    SuggestionModel(
      label: 'Property',
      description: 'Insert a C# property',
      replacedOnClick: 'public Type PropertyName { get; set; }',
      triggeredAt: 'public',
    ),
    SuggestionModel(
      label: 'Auto Property',
      description: 'Insert a C# auto property',
      replacedOnClick: 'public Type PropertyName { get; set; } = defaultValue;',
      triggeredAt: 'public',
    ),
    SuggestionModel(
      label: 'Constructor',
      description: 'Insert a C# constructor',
      replacedOnClick: 'public ClassName()\n{\n  \n}',
      triggeredAt: 'public',
    ),
    SuggestionModel(
      label: 'If Statement',
      description: 'Insert a C# if statement',
      replacedOnClick: 'if (condition)\n{\n  \n}',
      triggeredAt: 'if',
    ),
    SuggestionModel(
      label: 'If-Else',
      description: 'Insert a C# if-else statement',
      replacedOnClick: 'if (condition)\n{\n  \n}\nelse\n{\n  \n}',
      triggeredAt: 'if',
    ),
    SuggestionModel(
      label: 'Switch Statement',
      description: 'Insert a C# switch statement',
      replacedOnClick:
          'switch (value)\n{\n  case pattern:\n    \n    break;\n  default:\n    \n}',
      triggeredAt: 'switch',
    ),
    SuggestionModel(
      label: 'Switch Expression',
      description: 'Insert a C# switch expression',
      replacedOnClick:
          'var result = value switch\n{\n  pattern => result,\n  _ => default\n};',
      triggeredAt: 'var',
    ),
    SuggestionModel(
      label: 'For Loop',
      description: 'Insert a C# for loop',
      replacedOnClick: 'for (int i = 0; i < length; i++)\n{\n  \n}',
      triggeredAt: 'for',
    ),
    SuggestionModel(
      label: 'Foreach Loop',
      description: 'Insert a C# foreach loop',
      replacedOnClick: 'foreach (var item in collection)\n{\n  \n}',
      triggeredAt: 'foreach',
    ),
    SuggestionModel(
      label: 'While Loop',
      description: 'Insert a C# while loop',
      replacedOnClick: 'while (condition)\n{\n  \n}',
      triggeredAt: 'while',
    ),
    SuggestionModel(
      label: 'Do-While Loop',
      description: 'Insert a C# do-while loop',
      replacedOnClick: 'do\n{\n  \n} while (condition);',
      triggeredAt: 'do',
    ),
    SuggestionModel(
      label: 'Try-Catch',
      description: 'Insert a C# try-catch block',
      replacedOnClick: 'try\n{\n  \n}\ncatch (Exception ex)\n{\n  \n}',
      triggeredAt: 'try',
    ),
    SuggestionModel(
      label: 'Try-Catch-Finally',
      description: 'Insert a C# try-catch-finally block',
      replacedOnClick:
          'try\n{\n  \n}\ncatch (Exception ex)\n{\n  \n}\nfinally\n{\n  \n}',
      triggeredAt: 'try',
    ),
    SuggestionModel(
      label: 'List',
      description: 'Insert a C# List',
      replacedOnClick: 'var list = new List<Type>();',
      triggeredAt: 'var',
    ),
    SuggestionModel(
      label: 'Dictionary',
      description: 'Insert a C# Dictionary',
      replacedOnClick: 'var dict = new Dictionary<KeyType, ValueType>();',
      triggeredAt: 'var',
    ),
    SuggestionModel(
      label: 'HashSet',
      description: 'Insert a C# HashSet',
      replacedOnClick: 'var set = new HashSet<Type>();',
      triggeredAt: 'var',
    ),
    SuggestionModel(
      label: 'Lambda',
      description: 'Insert a C# lambda expression',
      replacedOnClick: 'Func<Type, ReturnType> lambda = x => x;',
      triggeredAt: 'Func',
    ),
    SuggestionModel(
      label: 'LINQ Query',
      description: 'Insert a C# LINQ query',
      replacedOnClick:
          'var result = from item in collection\n            where condition\n            select item;',
      triggeredAt: 'var',
    ),
    SuggestionModel(
      label: 'LINQ Method',
      description: 'Insert a C# LINQ method',
      replacedOnClick:
          'var result = collection.Where(x => condition).ToList();',
      triggeredAt: 'var',
    ),
    SuggestionModel(
      label: 'Async Method',
      description: 'Insert an async C# method',
      replacedOnClick: 'public async Task MethodName()\n{\n  \n}',
      triggeredAt: 'public async',
    ),
    SuggestionModel(
      label: 'Await',
      description: 'Insert C# await',
      replacedOnClick: 'var result = await asyncMethod();',
      triggeredAt: 'var',
    ),
    SuggestionModel(
      label: 'Using Statement',
      description: 'Insert a C# using statement',
      replacedOnClick: 'using (var resource = new Resource())\n{\n  \n}',
      triggeredAt: 'using',
    ),
    SuggestionModel(
      label: 'Namespace',
      description: 'Insert a C# namespace',
      replacedOnClick: 'namespace NamespaceName\n{\n  \n}',
      triggeredAt: 'namespace',
    ),
  ];
}
