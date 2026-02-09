# DP_V1 Additional Features

This document summarizes the additional features found in the `code_forge-DP_V1` version of the library compared to the current codebase.

## 1. Code Formatting
**File:** `lib/code_forge/code_formatter.dart`

The `CodeFormatter` class provides utility methods to format code for various languages. Key capabilities include:

*   **Supported Languages:**
    *   **JSON:** Supports standard JSON and JSON with embedded Jinja tags.
    *   **HTML:** Formats HTML structure, handles self-closing tags, void elements, and mixed Jinja/HTML content. Supports a `rulerColumn` for wrapping attributes or tags.
    *   **SQL:** Formats SQL queries, handling indentation for keywords (SELECT, FROM, WHERE, JOIN, etc.) and nested queries. Supports Jinja tags within SQL.
    *   **Jinja:** Specific formatter for Jinja templates, handling block tags (if, for, block, macro, etc.) and indentation.
*   **Mixed Content Handling:** specialized logic to preserve and correctly indent Jinja tags (`{% ... %}`) when embedded within other languages like HTML, JSON, or SQL.

## 2. Tag Completion
**File:** `lib/code_forge/tag_completion.dart`

The `TagCompletion` class provides intelligent auto-completion for XML-like tags (HTML) and template tags (Jinja).

*   **Context Analysis:** `analyzeTagContext` determines if the cursor is inside a tag, distinguishing between HTML tags (`<...>`) and Jinja tags (`{% ... %}`).
*   **Smart Suggestions:** `getTagSuggestions` returns valid tags based on the current context (HTML vs. Jinja) and any typed prefix.
*   **Templates:** Defines standard templates for HTML tags (e.g., `<a href="...">...</a>`) and Jinja blocks (e.g., `{% if ... %}...{% endif %}`).
*   **Auto-Closing:** Helper methods to generate the correct closing tags or full tag structures.

## 3. AI Completion Integration
**Directory:** `lib/AI_completion/`
**File:** `lib/AI_completion/ai.dart`

A comprehensive AI code completion system supporting multiple providers.

*   **`AiCompletion` Class:** Configuration for AI features, including:
    *   `enableCompletion`: Toggle flag.
    *   `debounceTime`: Control request frequency.
    *   `completionType`: Support for `auto`, `manual`, or `mixed` trigger modes.
*   **Supported Models:**
    *   **Gemini:** Google's generative AI.
    *   **OpenAI:** ChatGPT models.
    *   **Claude:** Anthropic's models.
    *   **OpenAI Compatible:** Generic support for providers like Grok, DeepSeek, Groq, TogetherAI, Perplexity (Sonar), OpenRouter, and FireWorks.
    *   **CustomModel:** Extensible class to hook into any custom API endpoint.

## 4. Enhanced Suggestion System & Language Packs
**Directory:** `lib/code_forge/suggestions/`
**File:** `lib/code_forge/suggestion_model.dart`
**File:** `lib/code_forge/suggestions/initialize_language_specific_suggestions.dart`

The suggestion system has been significantly expanded to support static suggestions for a wide range of languages.

*   **`SuggestionModel` Enhancements:**
    *   `triggeredAt`: Defines what characters trigger the suggestion (e.g., `<` for HTML, `{%` for Jinja).
    *   `context`: `SuggestionContext` enum to restrict suggestions to specific scopes (e.g., only inside a Jinja block).
    *   Subclasses `SuggestionModelJinja` and `SuggestionModelHtml` for specialized behavior.
*   **Language-Specific Providers:** Separate files for keywords and snippets for 20+ languages including Dart, Python, JavaScript, SQL, Rust, etc.
*   **Initialization:** `initializeLanguageSpecificSuggestions` dynamically loads the correct set of suggestions based on the editor's current language mode.

## 5. Rulers and Callbacks
**File:** `lib/code_forge/controller.dart`

*   **Editor Rulers:** Support for vertical guide lines at specific column positions (e.g., 80, 120 chars).
    *   `List<int>? rulers` field in `CodeForgeController`.
    *   `setRulers(List<int>? columns)` and `clearRulers()` methods.
*   **New Callbacks:**
    *   `onCodeChanged(void Function(String currentCode) callback)`: Listen for content changes.
    *   `onBreakpointsChanged(void Function(Set<int> breakpoints) callback)`: Listen for breakpoint additions/removals.

## 6. Asset & Font Enhancements
**File:** `pubspec.yaml`
**Directory:** `assets/icons/`

*   **New Icon Fonts:** Added support for `Enum`, `KeyWord`, and `Constant` icons in autocomplete suggestions.
    *   `assets/icons/enum.ttf`
    *   `assets/icons/keyword.ttf`
    *   `assets/icons/constant.ttf`

## 7. Integration Changes
**Files:** `lib/code_forge/code_area.dart`, `lib/code_forge/controller.dart`

To support these features, the core editor components in DP_V1 include:
*   **Formatter Integration:** Calls to `CodeFormatter.formatCode` in `CodeArea`.
*   **Completion Hooks:** `CodeArea` checks `TagCompletion.supportsTagCompletion` and invokes `TagCompletion.getTagSuggestions`.
*   **AI Handlers:** `CodeArea` and `Controller` include logic for `manualAiCompletion`, `_acceptAiCompletion`, and managing the `AiCompletion` instance.
*   **Suggestion Registration:** Calls to `initializeLanguageSpecificSuggestions` to populate the autocomplete list.
