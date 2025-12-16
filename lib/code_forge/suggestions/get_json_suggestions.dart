import 'package:code_forge/code_forge.dart';
import 'package:code_forge/code_forge/controller.dart';

/// Returns JSON-specific suggestions.
List<SuggestionModel> getJsonSuggestions() {
  return [
    SuggestionModel(
      label: 'Object',
      description: 'Insert a JSON object structure',
      replacedOnClick: '{\n  "key": "value"\n}',
      triggeredAt: '{',
    ),
    SuggestionModel(
      label: 'Array',
      description: 'Insert a JSON array structure',
      replacedOnClick: '[\n  \n]',
      triggeredAt: '[',
    ),
    SuggestionModel(
      label: 'String Property',
      description: 'Insert a JSON string property',
      replacedOnClick: '"property": "value"',
      triggeredAt: '"',
    ),
    SuggestionModel(
      label: 'Number Property',
      description: 'Insert a JSON number property',
      replacedOnClick: '"property": 0',
      triggeredAt: '"',
    ),
    SuggestionModel(
      label: 'Boolean Property',
      description: 'Insert a JSON boolean property',
      replacedOnClick: '"property": true',
      triggeredAt: '"',
    ),
    SuggestionModel(
      label: 'Null Property',
      description: 'Insert a JSON null property',
      replacedOnClick: '"property": null',
      triggeredAt: '"',
    ),
    SuggestionModel(
      label: 'Nested Object',
      description: 'Insert a nested JSON object',
      replacedOnClick: '"property": {\n  "nested": "value"\n}',
      triggeredAt: '"',
    ),
    SuggestionModel(
      label: 'Array of Objects',
      description: 'Insert an array of JSON objects',
      replacedOnClick: '[\n  {\n    "key": "value"\n  }\n]',
      triggeredAt: '[',
    ),
  ];
}
