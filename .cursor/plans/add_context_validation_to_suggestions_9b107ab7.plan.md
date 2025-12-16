---
name: Add context validation to suggestions
overview: Add context-aware suggestion filtering using specialized classes (SuggestionModelJinja) that have built-in context validation. Jinja filter suggestions will only appear when cursor is within {% ... %} or {{ ... }} blocks.
todos:
  - id: add_context_enum
    content: Add SuggestionContext enum to suggestion_model.dart
    status: pending
  - id: add_context_method
    content: Add getContext() method to SuggestionModel base class and override in SuggestionModelJinja
    status: pending
    dependencies:
      - add_context_enum
  - id: add_context_helper
    content: Create _isCursorInJinjaBlock() helper function for context validation
    status: pending
    dependencies:
      - add_context_enum
  - id: update_trigger_checking
    content: Modify _checkTriggerPatterns() to validate context using getContext() method
    status: pending
    dependencies:
      - add_context_method
      - add_context_helper
  - id: replace_jinja_models
    content: Replace all SuggestionModel instances in get_jinja_suggestions.dart with SuggestionModelJinja
    status: pending
    dependencies:
      - add_context_method
---

# Add Context Validation to Suggestions

## Overview

Add context-aware suggestion filtering using specialized classes (`SuggestionModelJinja`, `SuggestionModelHtml`) that have built-in context validation. This allows Jinja filter suggestions (like `| toBool`) to only appear when the cursor is within Jinja statement blocks (`{% ... %}`) or expression blocks (`{{ ... }}`).

## Implementation Plan

### 1. Add Context Enum to `suggestion_model.dart`

- Create `SuggestionContext` enum with values:
  - `none` - No context restriction (default behavior)
  - `jinjaBlock` - Cursor must be within `{% ... %}` or `{{ ... }}` blocks
- Add abstract or default method `SuggestionContext? get context` to `SuggestionModel` base class (returns `SuggestionContext.none` by default)
- Override `get context` in `SuggestionModelJinja` to return `SuggestionContext.jinjaBlock`
- Keep `SuggestionModelHtml` returning `SuggestionContext.none` (or add HTML-specific context later)

**File**: `lib/code_forge/suggestion_model.dart`

### 2. Add Context Validation Helper Function

- Create `_isCursorInJinjaBlock()` helper function in `code_area.dart`
- Function signature: `bool _isCursorInJinjaBlock(String textBeforeCursor, String? textAfterCursor, int cursorPosition)`
- Logic:
  - Search backwards from cursor for `{%` or `{{`
  - Search forwards from cursor for `%}` or `}}`
  - Ensure the opening and closing tags match (statement vs expression)
  - Return true if cursor is between matching tags
- Handle edge cases:
  - Nested blocks
  - Incomplete blocks (opening without closing)
  - Escaped sequences
  - Multiple blocks on same line

**File**: `lib/code_forge/code_area.dart`

### 3. Update Trigger Pattern Checking Logic

- Modify `_checkTriggerPatterns()` method in `code_area.dart`
- After matching trigger pattern, check suggestion's context using `suggestion.context`
- If `context != null && context != SuggestionContext.none`, validate context before adding to results
- For `SuggestionContext.jinjaBlock`, call `_isCursorInJinjaBlock()`
- Only add suggestion if context validation passes (or if context is null/none)

**File**: `lib/code_forge/code_area.dart` (around line 783-886)

### 4. Replace All Jinja Suggestions with SuggestionModelJinja

- Replace all `SuggestionModel(` instances in `get_jinja_suggestions.dart` with `SuggestionModelJinja(`
- This includes:
  - All statement suggestions (if, for, block, etc.)
  - All filter suggestions (escape, string, replace, etc.)
- No need to manually add context - it's built into the class
- Update imports if needed

**File**: `lib/code_forge/suggestions/get_jinja_suggestions.dart`

## Technical Details

### Context Validation Algorithm

```dart
bool _isCursorInJinjaBlock(String textBeforeCursor, String? textAfterCursor, int cursorPosition) {
  // Find nearest opening tag before cursor: {% or {{
  // Track nesting level
  // Find nearest closing tag after cursor: %} or }}
  // Verify they match and cursor is between them
  // Handle nested blocks correctly
}
```

### Class Structure

```dart
enum SuggestionContext {
  none,
  jinjaBlock,
}

class SuggestionModel {
  // ... existing fields ...
  
  SuggestionContext? get context => SuggestionContext.none;
}

class SuggestionModelJinja extends SuggestionModel {
  SuggestionModelJinja({...});
  
  @override
  SuggestionContext? get context => SuggestionContext.jinjaBlock;
}
```

### Example Usage

```dart
// Filter suggestions automatically have jinjaBlock context
SuggestionModelJinja(
  label: 'To Bool',
  description: '...',
  replacedOnClick: '| toBool',
  triggeredAt: '|',
  // context is automatically SuggestionContext.jinjaBlock
)

// Statement suggestions also use SuggestionModelJinja
SuggestionModelJinja(
  label: 'If Statement',
  replacedOnClick: '{% if condition %}\n  \n{% endif %}',
  triggeredAt: '{%',
  // context is automatically SuggestionContext.jinjaBlock
)
```

## Testing Considerations

- Test with cursor inside `{% ... %}` blocks (should show filter suggestions)
- Test with cursor inside `{{ ... }}` blocks (should show filter suggestions)
- Test with cursor outside Jinja blocks (should NOT show filter suggestions)
- Test with nested blocks (should work correctly)
- Test with incomplete blocks (opening without closing)
- Test statement suggestions (should work as before, context applies to filters)
- Test with other suggestion types using base `SuggestionModel` (should work as before)

## Files to Modify

1. `lib/code_forge/suggestion_model.dart` - Add enum and getContext() method, update SuggestionModelJinja
2. `lib/code_forge/code_area.dart` - Add validation logic and update trigger checking
3. `lib/code_forge/suggestions/get_jinja_suggestions.dart` - Replace all SuggestionModel with SuggestionModelJinja