import 'package:code_forge/code_forge/suggestion_model.dart';

/// Returns JSON-specific suggestions.
List<SuggestionModel> getJsonSuggestions() {
  return [
    SuggestionModel(
      label: 'Object',
      description: '<p>Insert a JSON object structure</p>',
      replacedOnClick: '{\n  "key": "value"\n}',
      triggeredAt: '{',
    ),
    SuggestionModel(
      label: 'Array',
      description: '<p>Insert a JSON array structure</p>',
      replacedOnClick: '[\n  \n]',
      triggeredAt: '[',
    ),
    SuggestionModel(
      label: 'String Property',
      description: '<p>Insert a JSON string property</p>',
      replacedOnClick: '"property": "value"',
      triggeredAt: '"',
    ),
    SuggestionModel(
      label: 'Number Property',
      description: '<p>Insert a JSON number property</p>',
      replacedOnClick: '"property": 0',
      triggeredAt: '"',
    ),
    SuggestionModel(
      label: 'Boolean Property',
      description: '<p>Insert a JSON boolean property</p>',
      replacedOnClick: '"property": true',
      triggeredAt: '"',
    ),
    SuggestionModel(
      label: 'Null Property',
      description: '<p>Insert a JSON null property</p>',
      replacedOnClick: '"property": null',
      triggeredAt: '"',
    ),
    SuggestionModel(
      label: 'Nested Object',
      description: '<p>Insert a nested JSON object</p>',
      replacedOnClick: '"property": {\n  "nested": "value"\n}',
      triggeredAt: '"',
    ),
    SuggestionModel(
      label: 'Array of Objects',
      description: '<p>Insert an array of JSON objects</p>',
      replacedOnClick: '[\n  {\n    "key": "value"\n  }\n]',
      triggeredAt: '[',
    ),
  ];
}
