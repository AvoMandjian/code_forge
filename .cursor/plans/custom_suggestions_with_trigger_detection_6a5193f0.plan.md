---
name: Custom Suggestions with Trigger Detection
overview: Add automatic trigger detection for custom suggestions. When users type trigger patterns (like "{{" or "<<"), matching suggestions will automatically appear. Supports multiple trigger types simultaneously.
todos:
  - id: update_suggestion_model
    content: Update SuggestionModel.fromMap() to handle both camelCase and snake_case JSON keys from backend
    status: completed
  - id: add_suggestion_storage
    content: Add _registeredCustomSuggestions field and registerCustomSuggestions() method in CodeForgeController
    status: completed
  - id: add_trigger_detection
    content: Add trigger pattern detection logic in _controller.addListener() callback in code_area.dart
    status: completed
    dependencies:
      - add_suggestion_storage
  - id: add_helper_method
    content: Add _checkTriggerPatterns() helper method to find matching suggestions by trigger prefix
    status: completed
    dependencies:
      - add_suggestion_storage
  - id: update_suggestion_insertion
    content: Update _acceptSuggestion() and onTap handler to preserve trigger pattern when inserting suggestions
    status: completed
    dependencies:
      - add_trigger_detection
  - id: test_implementation
    content: Test with multiple triggers, prefix matching, and verify trigger pattern preservation
    status: completed
    dependencies:
      - update_suggestion_insertion
---

# Custom Suggestions with Automatic Trigger Detection

## Overview

Implement automatic trigger detection for custom suggestions. When users type trigger patterns (e.g., "{{" or "<<"), the editor will automatically show matching suggestions. Supports multiple different trigger types simultaneously.

## Implementation Plan

### 1. Update SuggestionModel.fromMap to handle backend snake_case format

**File**: `lib/code_forge/controller.dart`

- Update `SuggestionModel.fromMap()` to accept both camelCase (`replacedOnClick`, `triggeredAt`) and snake_case (`replaced_on_click`, `triggered_at`) keys from backend JSON
- This ensures compatibility with backend API responses

### 2. Add suggestion storage and registration in Controller

**File**: `lib/code_forge/controller.dart`

- Add a private field `List<SuggestionModel> _registeredCustomSuggestions = []` to store registered suggestions
- Add public method `registerCustomSuggestions(List<SuggestionModel> suggestions)` that:
  - Replaces or merges the registered suggestions list
  - Optionally notifies listeners if needed
- Add public getter `List<SuggestionModel> get registeredCustomSuggestions` for access

### 3. Add trigger detection logic in widget

**File**: `lib/code_forge/code_area.dart`

- In the `_controller.addListener()` callback (around line 432), add trigger detection logic:
  - Check if text was inserted (single character insertion around line 524)
  - Get text before cursor position
  - Check if any registered custom suggestion's `triggeredAt` pattern matches as a prefix
  - If match found, filter suggestions by matching trigger pattern
  - Show matching suggestions via `_suggestionNotifier`
- Handle multiple triggers: check all registered suggestions and group by matching triggers

### 4. Update suggestion insertion to preserve trigger pattern

**File**: `lib/code_forge/code_area.dart`

- In `_acceptSuggestion()` method (around line 2808) and the onTap handler (around line 1896):
  - When inserting a `SuggestionModel` suggestion, detect if trigger pattern exists before cursor
  - Keep the trigger pattern in place
  - Insert `replacedOnClick` text appropriately (after trigger or replacing only the word prefix, not the trigger)
- Ensure trigger pattern detection works correctly for multi-character triggers like "{{}}"

### 5. Handle trigger pattern detection edge cases

**File**: `lib/code_forge/code_area.dart`

- Implement helper method `_checkTriggerPatterns(String textBeforeCursor)` that:
  - Checks all registered custom suggestions
  - Returns list of suggestions whose `triggeredAt` pattern matches as prefix
  - Handles cases where multiple triggers might match (prioritize longest match)
- Clear suggestions when trigger pattern is deleted or cursor moves away

## Key Implementation Details

### Trigger Detection Algorithm

1. On each text insertion, get text before cursor (last N characters where N = max trigger length)
2. Check each registered suggestion's `triggeredAt` pattern
3. If pattern matches as prefix of text before cursor, add to matching suggestions
4. Show all matching suggestions grouped together

### Suggestion Insertion Behavior

- When user selects a suggestion:
  - Find the trigger pattern in text before cursor
  - Replace only the word/prefix after the trigger (if any)
  - Insert `replacedOnClick` text
  - Keep the trigger pattern intact

### Example Flow

```
User types: "{{"
→ Detects trigger "{{" matches "{{}}" pattern
→ Shows all suggestions with triggeredAt="{{}}"
→ User selects "Hello" suggestion
→ Text becomes: "{{Hello World" (trigger "{{" remains)
```

## Files to Modify

1. `lib/code_forge/controller.dart`

   - Update `SuggestionModel.fromMap()` for snake_case support
   - Add `_registeredCustomSuggestions` field
   - Add `registerCustomSuggestions()` method
   - Add getter for registered suggestions

2. `lib/code_forge/code_area.dart`

   - Add trigger detection in `_controller.addListener()` callback
   - Add helper method `_checkTriggerPatterns()`
   - Update `_acceptSuggestion()` to handle trigger preservation
   - Update onTap handler for suggestion selection

## Testing Considerations

- Test with multiple different triggers (e.g., "{{}}", "<<>>")
- Test prefix matching (typing "{{" should show "{{}}" triggers)
- Test that trigger pattern remains after suggestion insertion
- Test with empty suggestions list
- Test with suggestions that have same trigger pattern
- Test trigger detection doesn't interfere with existing autocomplete (LSP, tag completion)