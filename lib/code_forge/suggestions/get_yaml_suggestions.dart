import 'package:code_forge/code_forge/suggestion_model.dart';

/// Returns YAML-specific suggestions.
List<SuggestionModel> getYamlSuggestions() {
  return [
    SuggestionModel(
      label: 'Key-Value Pair',
      description: 'Insert a YAML key-value pair',
      replacedOnClick: 'key: value',
      triggeredAt: 'key',
    ),
    SuggestionModel(
      label: 'String Value',
      description: 'Insert a YAML string value',
      replacedOnClick: 'key: "string value"',
      triggeredAt: 'key',
    ),
    SuggestionModel(
      label: 'Number Value',
      description: 'Insert a YAML number value',
      replacedOnClick: 'key: 123',
      triggeredAt: 'key',
    ),
    SuggestionModel(
      label: 'Boolean Value',
      description: 'Insert a YAML boolean value',
      replacedOnClick: 'key: true',
      triggeredAt: 'key',
    ),
    SuggestionModel(
      label: 'Null Value',
      description: 'Insert a YAML null value',
      replacedOnClick: 'key: null',
      triggeredAt: 'key',
    ),
    SuggestionModel(
      label: 'List Item',
      description: 'Insert a YAML list item',
      replacedOnClick: '- item',
      triggeredAt: '-',
    ),
    SuggestionModel(
      label: 'Inline List',
      description: 'Insert an inline YAML list',
      replacedOnClick: 'key: [item1, item2, item3]',
      triggeredAt: 'key',
    ),
    SuggestionModel(
      label: 'Nested Object',
      description: 'Insert a nested YAML object',
      replacedOnClick: 'parent:\n  child: value',
      triggeredAt: 'parent',
    ),
    SuggestionModel(
      label: 'Multi-line String (Literal)',
      description: 'Insert a literal multi-line YAML string',
      replacedOnClick: 'key: |\n  line 1\n  line 2',
      triggeredAt: '|',
    ),
    SuggestionModel(
      label: 'Multi-line String (Folded)',
      description: 'Insert a folded multi-line YAML string',
      replacedOnClick: 'key: >\n  line 1\n  line 2',
      triggeredAt: '>',
    ),
    SuggestionModel(
      label: 'Anchor',
      description: 'Insert a YAML anchor',
      replacedOnClick: '&anchor key: value',
      triggeredAt: '&',
    ),
    SuggestionModel(
      label: 'Alias',
      description: 'Insert a YAML alias',
      replacedOnClick: 'key: *anchor',
      triggeredAt: '*',
    ),
    SuggestionModel(
      label: 'Comment',
      description: 'Insert a YAML comment',
      replacedOnClick: '# Comment',
      triggeredAt: '#',
    ),
    SuggestionModel(
      label: 'Document Separator',
      description: 'Insert a YAML document separator',
      replacedOnClick: '---',
      triggeredAt: '---',
    ),
    SuggestionModel(
      label: 'Document End',
      description: 'Insert a YAML document end marker',
      replacedOnClick: '...',
      triggeredAt: '...',
    ),
  ];
}
