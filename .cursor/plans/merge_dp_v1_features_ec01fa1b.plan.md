---
name: Merge DP_V1 Features
overview: Merge new features (AI Completion, Tag Completion, Code Formatting, Enhanced Suggestions) from DP_V1 into the current codebase.
todos:
  - id: deps
    content: Update pubspec.yaml with new dependencies and asset/font definitions
    status: pending
  - id: copy_files
    content: Copy new feature files (CodeFormatter, TagCompletion, AI_completion, Suggestions) and assets
    status: pending
  - id: exports
    content: Update lib/code_forge.dart exports
    status: pending
  - id: controller
    content: Update Controller to support AI completion, rulers, and callbacks
    status: pending
  - id: code_area
    content: Update CodeArea to integrate AI, Tag Completion, Formatting, and Rulers
    status: pending
  - id: verify
    content: Verify build and resolve analysis errors
    status: pending
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

- Add `AiCompletion? _aiCompletion` field and getter/setter.
- Add `VoidCallback? manualAiCompletion`.
- Add fields for `rulers`, `_onCodeChanged`, `_onBreakpointsChanged`, and `showCustomSuggestionsCallback`.
- Add methods: `enableAiCompletion`, `disableAiCompletion`, `toggleAiCompletion`, `isAiCompletionEnabled`, `setRulers`, `clearRulers`, `onCodeChanged`, `onBreakpointsChanged`.
- Integrate `_onCodeChanged?.call(text)` in the text update logic.

### 5. Integration: Code Area

Modify `lib/code_forge/code_area.dart`:

- **Constructor**: Add `AiCompletion? aiCompletion` parameter.
- **State Initialization**:
  - Initialize `initializeLanguageSpecificSuggestions`.
  - Set up AI completion controller in `initState` (`_controller.setAiCompletion(widget.aiCompletion)`).
- **Formatting**: Hook up `CodeFormatter.formatCode` (likely in a format command or keybinding).
- **Tag Completion**: Integrate `TagCompletion.getTagSuggestions` into the autocomplete logic.
- **AI Completion**: Add logic to trigger and accept AI suggestions (`_acceptAiCompletion`).
- **Rulers**: Implement drawing logic for vertical rulers in the painter or as a separate layer.

### 6. Verification

- Run `flutter pub get`.
- Run `flutter analyze` to check for missing imports or type errors.
- Verify that the application compiles.

**Note on Conflicts**: The `controller.dart` file is large. I will use targeted edits to insert the new functionality without disrupting existing logic.