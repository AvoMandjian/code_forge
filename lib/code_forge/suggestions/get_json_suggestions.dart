import 'package:code_forge/code_forge/suggestion_model.dart';

/// Returns JSON-specific suggestions.
List<SuggestionModel> getJsonSuggestions() {
  return [
    SuggestionModel(
      label: 'Object',
      description: '<p>Insert a JSON object structure</p>',
      replacedOnClick: '{\n  "key": "value"\n}',
      openingTag: '{',
      closingTag: '}',
    ),
    SuggestionModel(
      label: 'Array',
      description: '<p>Insert a JSON array structure</p>',
      replacedOnClick: '[\n  \n]',
      openingTag: '[',
      closingTag: '}',
    ),
    SuggestionModel(
      label: 'String Property',
      description: '<p>Insert a JSON string property</p>',
      replacedOnClick: '"property": "value"',
      openingTag: '"',
      closingTag: '}',
    ),
    SuggestionModel(
      label: 'Number Property',
      description: '<p>Insert a JSON number property</p>',
      replacedOnClick: '"property": 0',
      openingTag: '"',
      closingTag: '}',
    ),
    SuggestionModel(
      label: 'Boolean Property',
      description: '<p>Insert a JSON boolean property</p>',
      replacedOnClick: '"property": true',
      openingTag: '"',
      closingTag: '}',
    ),
    SuggestionModel(
      label: 'Null Property',
      description: '<p>Insert a JSON null property</p>',
      replacedOnClick: '"property": null',
      openingTag: '"',
      closingTag: '}',
    ),
    SuggestionModel(
      label: 'Nested Object',
      description: '<p>Insert a nested JSON object</p>',
      replacedOnClick: '"property": {\n  "nested": "value"\n}',
      openingTag: '"',
      closingTag: '}',
    ),
    SuggestionModel(
      label: 'Array of Objects',
      description: '<p>Insert an array of JSON objects</p>',
      replacedOnClick: '[\n  {\n    "key": "value"\n  }\n]',
      openingTag: '[',
      closingTag: '}',
    ),
  ];
}
