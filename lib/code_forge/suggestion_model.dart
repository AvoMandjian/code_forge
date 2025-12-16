/// Context requirements for suggestion validation.
enum SuggestionContext {
  /// No context restriction - suggestion can appear anywhere.
  none,

  /// Cursor must be within Jinja statement blocks (`{% ... %}`) or expression blocks (`{{ ... }}`).
  jinjaBlock,
}

/// Model representing a custom suggestion item for the code editor.
///
/// Each suggestion contains:
/// - [label]: The text displayed in the suggestion list
/// - [replacedOnClick]: The text inserted when the suggestion is selected
/// - [description]: Optional description text shown below the label
/// - [triggeredAt]: The string pattern that triggers this suggestion when typed
/// - [context]: Optional context requirement for when the suggestion should be shown
class SuggestionModel {
  /// The text displayed in the suggestion list.
  final String label;

  /// The text inserted when the suggestion is selected.
  final String replacedOnClick;

  /// Optional description text shown below the label.
  final String? description;

  /// The string pattern that triggers this suggestion when typed.
  ///
  /// When the user types this pattern in the editor, the suggestion popup
  /// will be triggered. For example, if [triggeredAt] is "{{}}", typing
  /// "{{}}" will show the suggestions.
  final String triggeredAt;

  /// The context requirement for this suggestion.
  ///
  /// Returns the context that must be satisfied for this suggestion to be shown.
  /// Defaults to [SuggestionContext.none] (no restriction).
  SuggestionContext? get context => SuggestionContext.none;

  /// Creates a [SuggestionModel] instance.
  ///
  /// [label], [replacedOnClick], and [triggeredAt] are required.
  /// [description] is optional.
  const SuggestionModel({
    required this.label,
    required this.replacedOnClick,
    required this.triggeredAt,
    this.description,
  });

  /// Creates a [SuggestionModel] from a map.
  ///
  /// Useful for deserializing from JSON or converting from legacy map format.
  /// Supports both camelCase (replacedOnClick, triggeredAt) and snake_case
  /// (replaced_on_click, triggered_at) formats for backend compatibility.
  factory SuggestionModel.fromMap(Map<String, dynamic> map) {
    return SuggestionModel(
      label: map['label'] as String,
      replacedOnClick: map['replacedOnClick'] ?? map['replaced_on_click'] ?? '',
      triggeredAt: map['triggeredAt'] ?? map['triggered_at'] ?? '',
      description: map['description'] as String?,
    );
  }

  /// Converts the [SuggestionModel] to a map.
  ///
  /// Useful for serializing to JSON or converting to legacy map format.
  Map<String, dynamic> toMap() {
    return {
      'label': label,
      'replacedOnClick': replacedOnClick,
      'triggeredAt': triggeredAt,
      if (description != null) 'description': description,
    };
  }

  @override
  String toString() {
    return 'SuggestionModel(label: $label, replacedOnClick: $replacedOnClick, '
        'description: $description, triggeredAt: $triggeredAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SuggestionModel &&
        other.label == label &&
        other.replacedOnClick == replacedOnClick &&
        other.description == description &&
        other.triggeredAt == triggeredAt;
  }

  @override
  int get hashCode {
    return Object.hash(label, replacedOnClick, description, triggeredAt);
  }
}

class SuggestionModelJinja extends SuggestionModel {
  SuggestionModelJinja({
    required super.label,
    required super.replacedOnClick,
    required super.triggeredAt,
    super.description,
  });

  @override
  SuggestionContext? get context => SuggestionContext.jinjaBlock;
}

class SuggestionModelHtml extends SuggestionModel {
  SuggestionModelHtml({
    required super.label,
    required super.replacedOnClick,
    required super.triggeredAt,
    super.description,
  });
}
