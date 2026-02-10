---
name: Merge DP_V1 Features
overview: Merge new features (AI Completion, Tag Completion, Code Formatting, Enhanced Suggestions) from DP_V1 into the current codebase.
todos:
  - id: deps
    content: Update pubspec.yaml with new dependencies and asset/font definitions
    status: completed
  - id: copy_files
    content: Copy new feature files (CodeFormatter, TagCompletion, AI_completion, Suggestions) and assets
    status: completed
  - id: exports
    content: Update lib/code_forge.dart exports
    status: completed
  - id: controller
    content: Update Controller (AI, callbacks, rulers, breakpoints)
    status: completed
  - id: styling
    content: Update Styling (GutterStyle) and SyntaxHighlighter (Jinja)
    status: completed
  - id: rope
    content: Update Rope with BiDi support
    status: completed
  - id: code_area
    content: Update CodeArea (AI, Tag Completion, Formatting, Rulers, Breakpoints)
    status: completed
  - id: verify
    content: Verify build and resolve analysis errors
    status: completed
  - id: remaining
    content: Optional DP_V1 parity (saveFile/saveFileCallback, clearRegisteredCustomSuggestions)
    status: completed
isProject: false
---

I will merge the features identified in `DP_V1_FEATURES.md` into the current project.

### 1. Dependencies and Assets

Update `pubspec.yaml` to include new dependencies required by the features:

- `http`: For AI completion API calls.
- `flutter_html`: For rendering HTML content in suggestions or previews.
- `meta`: For `@protected` and other annotations.
- `jinja_app_widgets_catalog`: (Git dependency) Required for `SuggestionModel`. *Note: This appears to be a private repository. If inaccessible, we may need to mock it or remove the dependency.*

**Asset/Font Definitions**:
Update `pubspec.yaml` to include the following font families in the `flutter` section:

- `Enum`, `KeyWord`, and `Constant` mapping to their respective `.ttf` files in `assets/icons/`.

**Asset Files**:
Copy the following `.ttf` files to `assets/icons/`:

- `assets/icons/enum.ttf`
- `assets/icons/keyword.ttf`
- `assets/icons/constant.ttf`

### 2. Copy New Files

Copy the following files and directories from the source to the current project:

- `lib/code_forge/code_formatter.dart`
- `lib/code_forge/tag_completion.dart`
- `lib/code_forge/suggestion_model.dart`
- `lib/code_forge/suggestions/` (entire directory)
- `lib/AI_completion/` (entire directory)

### 3. Exports

Update `lib/code_forge.dart` to export the new public APIs:

- `export 'code_forge/code_formatter.dart';`
- `export 'code_forge/tag_completion.dart';`
- `export 'AI_completion/ai.dart';`
- `export 'code_forge/suggestion_model.dart';`

### 4. Integration: Controller

Modify `lib/code_forge/controller.dart`:

- **AI**: `AiCompletion? _aiCompletion`, `manualAiCompletion`, methods `enableAiCompletion`, `toggleAiCompletion`, etc.
- **Callbacks**: `onCodeChanged`, `onBreakpointsChanged`, `showCustomSuggestionsCallback`.
- **Rulers**: `List<int>? rulers`, `setRulers`, `clearRulers`.
- **Breakpoints**: `Set<int> breakpoints`, `toggleBreakpoint`.
- **Logic**: Call `_onCodeChanged` in update logic; handle breakpoint toggles.

### 5. Integration: Styling and Highlighting

Modify `lib/code_forge/styling.dart`:

- **GutterStyle**: Add `final bool showBreakpoints` and `final Color breakpointColor`.

Modify `lib/code_forge/syntax_highlighter.dart`:

- Add `_createJinjaPatterns` and integrate into the highlighter logic.

### 6. Integration: Rope (BiDi Support)

Modify `lib/code_forge/rope.dart`:

- Add `TextDirection` enum and `BiDi` class.
- Add `BiDiSegment` class.
- Update `Rope` class with BiDi methods (`textDirection`, `bidiSegments`, `insertImmutable`, `deleteImmutable`).

### 7. Integration: Code Area

Modify `lib/code_forge/code_area.dart`:

- **Constructor**: Add `AiCompletion? aiCompletion` parameter.
- **State Initialization**:
  - Initialize `initializeLanguageSpecificSuggestions`.
  - Set up AI completion controller in `initState` (`_controller.setAiCompletion(widget.aiCompletion)`).
- **Formatting**: Hook up `CodeFormatter.formatCode`.
- **Tag Completion**: Integrate `TagCompletion.getTagSuggestions`.
- **AI Completion**: Logic to trigger and accept AI suggestions (`_acceptAiCompletion`).
- **Rulers**: Paint vertical rulers in `_paintCode` or a new painter method.
- **Breakpoints**: Calculate gutter width for breakpoints, paint breakpoints, handle gutter clicks to toggle.

### 7. Verification

- Run `flutter pub get`.
- Run `flutter analyze` to check for missing imports or type errors.
- Verify that the application compiles.

### 8. Remaining DP_V1 parity (done)

- **Controller**: Added `saveFileCallback`; `saveFile()` now calls it when set, then writes to `openedFile` if non-null. Added `clearRegisteredCustomSuggestions()`.
- **CodeForge**: Added `saveFile` (VoidCallback?); Cmd/Ctrl+S invokes `widget.saveFile ?? controller.saveFile()`. In `initState`, `_controller.saveFileCallback = widget.saveFile`. Added `onBreakpointsChanged` widget parameter, wired to controller.
- **SuggestionDescriptionStyle**: Added `suggestionDescriptionStyle` widget parameter; initialized `_suggestionDescriptionStyle` in `initState`; added description popup rendering for `SuggestionModel` items with descriptions (supports HTML and Jinja HTML widgets); added `SuggestionModel` handling in suggestion list rendering.
- **Doc**: `DP_V1_FEATURES.md` updated with "Remaining DP_V1-only items" table (all items now merged).

**Note on Conflicts**: The `controller.dart` file is large. I will use targeted edits to insert the new functionality without disrupting existing logic.