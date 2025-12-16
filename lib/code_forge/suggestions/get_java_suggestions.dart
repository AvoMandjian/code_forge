import 'package:code_forge/code_forge.dart';
import 'package:code_forge/code_forge/controller.dart';
import 'package:code_forge/code_forge/suggestion_model.dart';

/// Returns Java-specific suggestions.
List<SuggestionModel> getJavaSuggestions() {
  return [
    SuggestionModel(
      label: 'Class',
      description: 'Insert a Java class',
      replacedOnClick: 'public class ClassName {\n  \n}',
      triggeredAt: 'class',
    ),
    SuggestionModel(
      label: 'Abstract Class',
      description: 'Insert an abstract Java class',
      replacedOnClick: 'public abstract class ClassName {\n  \n}',
      triggeredAt: 'abstract',
    ),
    SuggestionModel(
      label: 'Interface',
      description: 'Insert a Java interface',
      replacedOnClick: 'public interface InterfaceName {\n  \n}',
      triggeredAt: 'interface',
    ),
    SuggestionModel(
      label: 'Enum',
      description: 'Insert a Java enum',
      replacedOnClick: 'public enum EnumName {\n  VALUE1,\n  VALUE2,\n}',
      triggeredAt: 'enum',
    ),
    SuggestionModel(
      label: 'Method',
      description: 'Insert a Java method',
      replacedOnClick: 'public void methodName() {\n  \n}',
      triggeredAt: 'public',
    ),
    SuggestionModel(
      label: 'Static Method',
      description: 'Insert a static Java method',
      replacedOnClick: 'public static void methodName() {\n  \n}',
      triggeredAt: 'public static',
    ),
    SuggestionModel(
      label: 'Main Method',
      description: 'Insert a Java main method',
      replacedOnClick: 'public static void main(String[] args) {\n  \n}',
      triggeredAt: 'public static',
    ),
    SuggestionModel(
      label: 'Constructor',
      description: 'Insert a Java constructor',
      replacedOnClick: 'public ClassName() {\n  \n}',
      triggeredAt: 'public',
    ),
    SuggestionModel(
      label: 'Getter',
      description: 'Insert a Java getter method',
      replacedOnClick: 'public Type getProperty() {\n  return property;\n}',
      triggeredAt: 'public',
    ),
    SuggestionModel(
      label: 'Setter',
      description: 'Insert a Java setter method',
      replacedOnClick:
          'public void setProperty(Type property) {\n  this.property = property;\n}',
      triggeredAt: 'public',
    ),
    SuggestionModel(
      label: 'If Statement',
      description: 'Insert a Java if statement',
      replacedOnClick: 'if (condition) {\n  \n}',
      triggeredAt: 'if',
    ),
    SuggestionModel(
      label: 'If-Else',
      description: 'Insert a Java if-else statement',
      replacedOnClick: 'if (condition) {\n  \n} else {\n  \n}',
      triggeredAt: 'if',
    ),
    SuggestionModel(
      label: 'Switch Statement',
      description: 'Insert a Java switch statement',
      replacedOnClick:
          'switch (value) {\n  case pattern:\n    \n    break;\n  default:\n    \n}',
      triggeredAt: 'switch',
    ),
    SuggestionModel(
      label: 'For Loop',
      description: 'Insert a Java for loop',
      replacedOnClick: 'for (int i = 0; i < length; i++) {\n  \n}',
      triggeredAt: 'for',
    ),
    SuggestionModel(
      label: 'Enhanced For Loop',
      description: 'Insert a Java enhanced for loop',
      replacedOnClick: 'for (Type item : collection) {\n  \n}',
      triggeredAt: 'for',
    ),
    SuggestionModel(
      label: 'While Loop',
      description: 'Insert a Java while loop',
      replacedOnClick: 'while (condition) {\n  \n}',
      triggeredAt: 'while',
    ),
    SuggestionModel(
      label: 'Do-While Loop',
      description: 'Insert a Java do-while loop',
      replacedOnClick: 'do {\n  \n} while (condition);',
      triggeredAt: 'do',
    ),
    SuggestionModel(
      label: 'Try-Catch',
      description: 'Insert a Java try-catch block',
      replacedOnClick: 'try {\n  \n} catch (Exception e) {\n  \n}',
      triggeredAt: 'try',
    ),
    SuggestionModel(
      label: 'Try-Catch-Finally',
      description: 'Insert a Java try-catch-finally block',
      replacedOnClick:
          'try {\n  \n} catch (Exception e) {\n  \n} finally {\n  \n}',
      triggeredAt: 'try',
    ),
    SuggestionModel(
      label: 'ArrayList',
      description: 'Insert a Java ArrayList',
      replacedOnClick: 'List<Type> list = new ArrayList<>();',
      triggeredAt: 'List',
    ),
    SuggestionModel(
      label: 'HashMap',
      description: 'Insert a Java HashMap',
      replacedOnClick: 'Map<KeyType, ValueType> map = new HashMap<>();',
      triggeredAt: 'Map',
    ),
    SuggestionModel(
      label: 'HashSet',
      description: 'Insert a Java HashSet',
      replacedOnClick: 'Set<Type> set = new HashSet<>();',
      triggeredAt: 'Set',
    ),
    SuggestionModel(
      label: 'Lambda',
      description: 'Insert a Java lambda expression',
      replacedOnClick: '(param) -> { return value; }',
      triggeredAt: '(',
    ),
    SuggestionModel(
      label: 'Stream',
      description: 'Insert a Java stream operation',
      replacedOnClick:
          'collection.stream().filter(x -> condition).collect(Collectors.toList());',
      triggeredAt: 'collection',
    ),
    SuggestionModel(
      label: 'Annotation',
      description: 'Insert a Java annotation',
      replacedOnClick: '@AnnotationName',
      triggeredAt: '@',
    ),
    SuggestionModel(
      label: 'Override',
      description: 'Insert @Override annotation',
      replacedOnClick: '@Override\npublic void methodName() {\n  \n}',
      triggeredAt: '@Override',
    ),
  ];
}
