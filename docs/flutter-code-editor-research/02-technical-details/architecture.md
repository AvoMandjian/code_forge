# Architecture & Implementation

## Text Management (`lib/src/code/code.dart`)
The `Code` class is an immutable snapshot of the editor state.
*   **CodeLines**: Parses the text into a list of `CodeLine` objects.
*   **Hidden Ranges**: Calculates which ranges of text are currently hidden (folded or explicit hidden sections).
*   **Edit Application**: `getEditResult` calculates how a change in the *visible* text (from the user) applies to the *full* text, respecting hidden ranges. This is complex logic to ensure typing "around" a folded block doesn't delete the block.

## Rendering Pipeline
1.  **User Types**: `TextField` calls `controller.value = newValue`.
2.  **Controller**:
    *   Maps `newValue` (visible) to `fullText`.
    *   Runs `CodeModifier`s (e.g., auto-indent).
    *   Updates `Code` object.
    *   Triggers `SpanBuilder`.
3.  **SpanBuilder** (`lib/src/code_field/span_builder.dart`):
    *   Takes the visible text.
    *   Runs `highlight.parse()`.
    *   Converts abstract syntax tree nodes into `TextSpan` hierarchy.
    *   Returns the root `TextSpan` to the `TextField`.

## Analysis (`lib/src/analyzer/`)
*   **Async**: Analysis is debounced (default 500ms).
*   **Default**: `DefaultLocalAnalyzer` checks for bracket symmetry.
*   **DartPad**: `DartPadAnalyzer` sends code to `https://api.dartpad.dev/analyze` and parses the JSON response into `Issue` objects.

## Autocomplete (`lib/src/autocomplete/`)
*   **Trie**: Uses `autotrie` package to index words in the document.
*   **Keywords**: Loads language keywords from `highlight`.
*   **Popup**: Renders an `OverlayEntry` following the cursor.

