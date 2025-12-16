import 'package:code_forge/code_forge.dart';
import 'package:code_forge/code_forge/controller.dart';
import 'package:code_forge/code_forge/suggestion_model.dart';

/// Returns Rust-specific suggestions.
List<SuggestionModel> getRustSuggestions() {
  return [
    SuggestionModel(
      label: 'Function',
      description: 'Insert a Rust function',
      replacedOnClick: 'fn function_name() {\n  \n}',
      triggeredAt: 'fn',
    ),
    SuggestionModel(
      label: 'Function with Return',
      description: 'Insert a Rust function with return type',
      replacedOnClick: 'fn function_name() -> ReturnType {\n  \n}',
      triggeredAt: 'fn',
    ),
    SuggestionModel(
      label: 'Function with Parameters',
      description: 'Insert a Rust function with parameters',
      replacedOnClick:
          'fn function_name(param1: Type1, param2: Type2) {\n  \n}',
      triggeredAt: 'fn',
    ),
    SuggestionModel(
      label: 'Struct',
      description: 'Insert a Rust struct',
      replacedOnClick: 'struct StructName {\n  field: Type,\n}',
      triggeredAt: 'struct',
    ),
    SuggestionModel(
      label: 'Tuple Struct',
      description: 'Insert a Rust tuple struct',
      replacedOnClick: 'struct StructName(Type1, Type2);',
      triggeredAt: 'struct',
    ),
    SuggestionModel(
      label: 'Enum',
      description: 'Insert a Rust enum',
      replacedOnClick: 'enum EnumName {\n  Variant1,\n  Variant2,\n}',
      triggeredAt: 'enum',
    ),
    SuggestionModel(
      label: 'Trait',
      description: 'Insert a Rust trait',
      replacedOnClick: 'trait TraitName {\n  fn method(&self);\n}',
      triggeredAt: 'trait',
    ),
    SuggestionModel(
      label: 'Impl Block',
      description: 'Insert a Rust impl block',
      replacedOnClick: 'impl StructName {\n  fn method(&self) {\n    \n  }\n}',
      triggeredAt: 'impl',
    ),
    SuggestionModel(
      label: 'If Statement',
      description: 'Insert a Rust if statement',
      replacedOnClick: 'if condition {\n  \n}',
      triggeredAt: 'if',
    ),
    SuggestionModel(
      label: 'If-Else',
      description: 'Insert a Rust if-else statement',
      replacedOnClick: 'if condition {\n  \n} else {\n  \n}',
      triggeredAt: 'if',
    ),
    SuggestionModel(
      label: 'If Let',
      description: 'Insert a Rust if let statement',
      replacedOnClick: 'if let Some(value) = option {\n  \n}',
      triggeredAt: 'if',
    ),
    SuggestionModel(
      label: 'Match Expression',
      description: 'Insert a Rust match expression',
      replacedOnClick: 'match value {\n  pattern => \n}',
      triggeredAt: 'match',
    ),
    SuggestionModel(
      label: 'While Loop',
      description: 'Insert a Rust while loop',
      replacedOnClick: 'while condition {\n  \n}',
      triggeredAt: 'while',
    ),
    SuggestionModel(
      label: 'While Let',
      description: 'Insert a Rust while let loop',
      replacedOnClick: 'while let Some(value) = option {\n  \n}',
      triggeredAt: 'while',
    ),
    SuggestionModel(
      label: 'For Loop',
      description: 'Insert a Rust for loop',
      replacedOnClick: 'for item in iterable {\n  \n}',
      triggeredAt: 'for',
    ),
    SuggestionModel(
      label: 'Loop',
      description: 'Insert a Rust infinite loop',
      replacedOnClick: 'loop {\n  \n}',
      triggeredAt: 'loop',
    ),
    SuggestionModel(
      label: 'Vector',
      description: 'Insert a Rust vector',
      replacedOnClick: 'let vec: Vec<Type> = vec![];',
      triggeredAt: 'let',
    ),
    SuggestionModel(
      label: 'HashMap',
      description: 'Insert a Rust HashMap',
      replacedOnClick:
          'use std::collections::HashMap;\nlet mut map = HashMap::new();',
      triggeredAt: 'use',
    ),
    SuggestionModel(
      label: 'Option',
      description: 'Insert a Rust Option',
      replacedOnClick: 'let option: Option<Type> = Some(value);',
      triggeredAt: 'let',
    ),
    SuggestionModel(
      label: 'Result',
      description: 'Insert a Rust Result',
      replacedOnClick: 'let result: Result<Type, Error> = Ok(value);',
      triggeredAt: 'let',
    ),
    SuggestionModel(
      label: 'Unwrap',
      description: 'Insert Rust unwrap',
      replacedOnClick: 'let value = option.unwrap();',
      triggeredAt: 'let',
    ),
    SuggestionModel(
      label: 'Question Mark',
      description: 'Insert Rust question mark operator',
      replacedOnClick: 'let value = function()?;',
      triggeredAt: 'let',
    ),
    SuggestionModel(
      label: 'Closure',
      description: 'Insert a Rust closure',
      replacedOnClick: 'let closure = |param| { value };',
      triggeredAt: 'let',
    ),
    SuggestionModel(
      label: 'Main Function',
      description: 'Insert a Rust main function',
      replacedOnClick: 'fn main() {\n  \n}',
      triggeredAt: 'fn main',
    ),
    SuggestionModel(
      label: 'Main with Result',
      description: 'Insert a Rust main function returning Result',
      replacedOnClick:
          'fn main() -> Result<(), Box<dyn std::error::Error>> {\n  Ok(())\n}',
      triggeredAt: 'fn main',
    ),
  ];
}
