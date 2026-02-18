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
/// - [openingTag]: The string pattern that triggers this suggestion when typed
/// - [context]: Optional context requirement for when the suggestion should be shown
class SuggestionModel {
  /// The text displayed in the suggestion list.
  final String label;

  Map<String, dynamic>? jinjaHtmlWidget;

  /// The text inserted when the suggestion is selected.
  final String replacedOnClick;

  /// Optional description text shown below the label.
  final String? description;

  /// The string pattern that triggers this suggestion when typed.
  ///
  /// When the user types this pattern in the editor, the suggestion popup
  /// will be triggered. For example, if [closingTag] is "}}", typing
  /// "}}" will show the suggestions.
  final String closingTag;

  /// The string pattern that triggers this suggestion when typed.
  ///
  /// When the user types this pattern in the editor, the suggestion popup
  /// will be triggered. For example, if [openingTag] is "{{}}", typing
  /// "{{}}" will show the suggestions.
  final String openingTag;

  /// The context requirement for this suggestion.
  ///
  /// Returns the context that must be satisfied for this suggestion to be shown.
  /// Defaults to [SuggestionContext.none] (no restriction).
  SuggestionContext? get context => SuggestionContext.none;

  /// Character indices in [label] that match the filter text.
  ///
  /// Used for highlighting matched characters in the UI.
  /// This is a runtime-only field, computed during suggestion filtering.
  final List<int>? matchRanges;

  /// Whether the suggestion is a custom suggestion.
  final bool isCustom;

  /// Creates a [SuggestionModel] instance.
  ///
  /// [label], [replacedOnClick], and [openingTag] are required.
  /// [description] and [matchRanges] are optional.
  SuggestionModel({
    required this.label,
    required this.replacedOnClick,
    required this.openingTag,
    required this.closingTag,
    this.description,
    this.jinjaHtmlWidget,
    this.matchRanges,
    this.isCustom = false,
  });

  /// Creates a [SuggestionModel] from a map.
  ///
  /// Useful for deserializing from JSON or converting from legacy map format.
  /// Supports both camelCase (replacedOnClick, openingTag) and snake_case
  /// (replaced_on_click, opening_tag) formats for backend compatibility.
  factory SuggestionModel.fromJson(Map<String, dynamic> map) {
    return SuggestionModel(
      label: map['label'] as String,
      replacedOnClick: map['replaced_on_click'] ?? '',
      openingTag: map['opening_tag'] ?? '',
      closingTag: map['closing_tag'] ?? '',
      description: map['description'] as String?,
      jinjaHtmlWidget: map['jinja_html_widget'] as Map<String, dynamic>?,
      isCustom: map['is_custom'] ?? false,
    );
  }

  /// Converts the [SuggestionModel] to a map.
  ///
  /// Useful for serializing to JSON or converting to legacy map format.
  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'replaced_on_click': replacedOnClick,
      'opening_tag': openingTag,
      'closing_tag': closingTag,
      if (description != null) 'description': description,
      if (jinjaHtmlWidget != null) 'jinja_html_widget': jinjaHtmlWidget,
      'is_custom': isCustom,
    };
  }

  @override
  String toString() {
    return 'SuggestionModel(label: $label, replacedOnClick: $replacedOnClick, '
        'description: $description, openingTag: $openingTag, closingTag: $closingTag, '
        'jinjaHtmlWidget: $jinjaHtmlWidget, matchRanges: $matchRanges, isCustom: $isCustom)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SuggestionModel &&
        other.label == label &&
        other.replacedOnClick == replacedOnClick &&
        other.description == description &&
        other.openingTag == openingTag &&
        other.closingTag == closingTag &&
        other.jinjaHtmlWidget == jinjaHtmlWidget &&
        other.matchRanges == matchRanges &&
        other.isCustom == isCustom;
  }

  @override
  int get hashCode {
    return Object.hash(
      label,
      replacedOnClick,
      description,
      openingTag,
      jinjaHtmlWidget,
      closingTag,
      matchRanges,
      isCustom,
    );
  }
}

class SuggestionModelJinja extends SuggestionModel {
  SuggestionModelJinja({
    required super.label,
    required super.replacedOnClick,
    required super.openingTag,
    required super.closingTag,
    super.description,
    super.isCustom,
  });

  @override
  SuggestionContext? get context => SuggestionContext.jinjaBlock;
}

class SuggestionModelHtml extends SuggestionModel {
  SuggestionModelHtml({
    required super.label,
    required super.replacedOnClick,
    required super.openingTag,
    required super.closingTag,
    super.description,
    super.isCustom,
  });
}
