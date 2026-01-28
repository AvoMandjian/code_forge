# Research Summary: Flutter Code Editor

## Executive Summary
`flutter_code_editor` by Akvelon is a mature, production-ready widget that enhances the standard Flutter `TextField` with code-specific features. Its primary strength lies in its "Named Sections" and "Read-Only Blocks" capabilities, making it ideal for controlled environments like tutorials, interview platforms, or snippet managers. However, its reliance on `TextEditingController` and Regex-based highlighting limits its performance ceiling compared to Rope-based editors like `code_forge`.

## Key Insights

### 1. Controller-Centric Design
The core logic resides in `CodeController` (extending `TextEditingController`).
*   **Folding Magic**: It maintains a "full text" and a "visible text". When code is folded, the controller physically removes it from the `text` property exposed to the `TextField`, but maps edits back to the full text.
*   **Regex Highlighting**: Uses `flutter_highlight` (which ports `highlight.js`) to generate `TextSpan` trees.

### 2. Feature Set
*   **Folding**: Supports indentation-based (Python) and bracket-based (Java/Dart) folding.
*   **Gutter**: Built-in gutter for line numbers, errors, and fold toggles.
*   **Read-Only Sections**: Unique feature allowing developers to define `[START section]` tags in comments to lock or hide specific code blocks.
*   **Analyzers**: Pluggable architecture. Includes a `DartPadAnalyzer` example, but fundamentally runs analysis *after* edits (debounced), pushing errors to the gutter.

### 3. Comparison with CodeForge
| Feature | Flutter Code Editor | CodeForge |
|---------|---------------------|-----------|
| **Data Structure** | String (Linear) | Rope (Tree) |
| **Rendering** | `TextField` | Custom `RenderBox` |
| **LSP** | ❌ (Regex only) | ✅ Native Client |
| **Web Support** | ✅ Excellent | ❌ Not supported |
| **Use Case** | Tutorials, Web Apps, Small/Med Files | Full IDEs, Large Files, Desktop |

## Research Sources
*   **Codebase**: Analyzed `lib/src/code_field/code_controller.dart` (7700+ chars) and `lib/src/code/code.dart`.
*   **Documentation**: Verified features in `README.md` and example apps.

## Citations
1.  **Repository**: [akvelon/flutter-code-editor](https://github.com/akvelon/flutter-code-editor)
2.  **Pub.dev**: [flutter_code_editor](https://pub.dev/packages/flutter_code_editor)

