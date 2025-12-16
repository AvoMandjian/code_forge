import 'package:code_forge/code_forge.dart';
import 'package:code_forge/code_forge/controller.dart';

/// Returns Ruby-specific suggestions.
List<SuggestionModel> getRubySuggestions() {
  return [
    SuggestionModel(
      label: 'Method',
      description: 'Insert a Ruby method',
      replacedOnClick: 'def method_name\n  \nend',
      triggeredAt: 'def',
    ),
    SuggestionModel(
      label: 'Method with Parameters',
      description: 'Insert a Ruby method with parameters',
      replacedOnClick: 'def method_name(param1, param2)\n  \nend',
      triggeredAt: 'def',
    ),
    SuggestionModel(
      label: 'Class',
      description: 'Insert a Ruby class',
      replacedOnClick: 'class ClassName\n  \nend',
      triggeredAt: 'class',
    ),
    SuggestionModel(
      label: 'Module',
      description: 'Insert a Ruby module',
      replacedOnClick: 'module ModuleName\n  \nend',
      triggeredAt: 'module',
    ),
    SuggestionModel(
      label: 'If Statement',
      description: 'Insert a Ruby if statement',
      replacedOnClick: 'if condition\n  \nend',
      triggeredAt: 'if',
    ),
    SuggestionModel(
      label: 'If-Else',
      description: 'Insert a Ruby if-else statement',
      replacedOnClick: 'if condition\n  \nelse\n  \nend',
      triggeredAt: 'if',
    ),
    SuggestionModel(
      label: 'Unless',
      description: 'Insert a Ruby unless statement',
      replacedOnClick: 'unless condition\n  \nend',
      triggeredAt: 'unless',
    ),
    SuggestionModel(
      label: 'Case Statement',
      description: 'Insert a Ruby case statement',
      replacedOnClick: 'case value\nwhen pattern\n  \nelse\n  \nend',
      triggeredAt: 'case',
    ),
    SuggestionModel(
      label: 'Each Loop',
      description: 'Insert a Ruby each loop',
      replacedOnClick: 'array.each do |item|\n  \nend',
      triggeredAt: 'each',
    ),
    SuggestionModel(
      label: 'Map',
      description: 'Insert a Ruby map',
      replacedOnClick: 'array.map { |item| item }',
      triggeredAt: 'array',
    ),
    SuggestionModel(
      label: 'Select',
      description: 'Insert a Ruby select',
      replacedOnClick: 'array.select { |item| condition }',
      triggeredAt: 'array',
    ),
    SuggestionModel(
      label: 'Times Loop',
      description: 'Insert a Ruby times loop',
      replacedOnClick: 'n.times do |i|\n  \nend',
      triggeredAt: 'times',
    ),
    SuggestionModel(
      label: 'While Loop',
      description: 'Insert a Ruby while loop',
      replacedOnClick: 'while condition\n  \nend',
      triggeredAt: 'while',
    ),
    SuggestionModel(
      label: 'Until Loop',
      description: 'Insert a Ruby until loop',
      replacedOnClick: 'until condition\n  \nend',
      triggeredAt: 'until',
    ),
    SuggestionModel(
      label: 'Block',
      description: 'Insert a Ruby block',
      replacedOnClick: 'do |param|\n  \nend',
      triggeredAt: 'do',
    ),
    SuggestionModel(
      label: 'Hash',
      description: 'Insert a Ruby hash',
      replacedOnClick: 'hash = { key: "value" }',
      triggeredAt: 'hash',
    ),
    SuggestionModel(
      label: 'Array',
      description: 'Insert a Ruby array',
      replacedOnClick: 'array = []',
      triggeredAt: 'array',
    ),
    SuggestionModel(
      label: 'Symbol',
      description: 'Insert a Ruby symbol',
      replacedOnClick: ':symbol',
      triggeredAt: ':',
    ),
    SuggestionModel(
      label: 'String Interpolation',
      description: 'Insert Ruby string interpolation',
      replacedOnClick: '"#{variable}"',
      triggeredAt: '"',
    ),
    SuggestionModel(
      label: 'Require',
      description: 'Insert a Ruby require statement',
      replacedOnClick: 'require "library"',
      triggeredAt: 'require',
    ),
    SuggestionModel(
      label: 'Attr Accessor',
      description: 'Insert a Ruby attr_accessor',
      replacedOnClick: 'attr_accessor :property',
      triggeredAt: 'attr_accessor',
    ),
  ];
}
