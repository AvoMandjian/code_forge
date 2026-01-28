# Research Summary: CodeForge

## Executive Summary
CodeForge represents a significant evolution in Flutter code editing widgets. By moving away from the standard `TextEditingController` and `TextField` implementation in favor of a **Rope-based** text management system and **custom RenderObject** rendering pipeline, it addresses the performance limitations inherent in processing large text files in Flutter. Its "batteries-included" approach—providing built-in LSP and AI clients—positions it as a platform-grade component rather than just a UI widget.

## Key Insights

### 1. Performance-First Architecture
Standard Flutter editors often struggle with large files because `String` operations are expensive and `TextField` rebuilds can be heavy. CodeForge uses:
*   **Rope Data Structure**: A tree-based data structure for strings that makes insertions, deletions, and splitting efficient ($O(\log n)$) compared to standard string concatenation ($O(n)$).
*   **Custom Viewport**: A `TwoDimensionalViewport` implementation (`CustomViewport`) handles layout, ensuring only visible lines are rendered/processed.

### 2. Native LSP Support
Unlike many editors that rely solely on Regex for syntax highlighting, CodeForge integrates a full LSP client (`Lib/LSP/lsp.dart`).
*   **Protocols**: Supports both `Stdio` (local processes like `dart language-server`) and `WebSocket` (remote servers or proxies).
*   **Features**: Provides semantic tokens (better highlighting than regex), diagnostics (red squiggles for errors), hover tooltips, and intelligent auto-completion.

### 3. AI Integration
The package includes a modular AI completion engine (`AiCompletion`):
*   **Ghost Text**: Renders suggestions inline with the code (faint text).
*   **Providers**: Pre-built classes for Gemini, OpenAI, Claude, DeepSeek, and Groq.
*   **Customization**: Allows custom prompts ("system instructions") and debounce configuration to manage API costs.

## Research Sources

### Codebase Analysis (Repomix)
*   **Source**: `heckmon/code_forge` GitHub Repository.
*   **Findings**: Analyzed 70k+ tokens of source code. Verified implementation of `Rope` class, `RenderBox` logic (`_CodeFieldRenderer`), and LSP state management.
*   **Key Files**: `lib/code_forge/rope.dart`, `lib/code_forge/code_area.dart`, `lib/LSP/lsp.dart`.

### Web Search (Exa)
*   **Context**: Confirmed positioning as an alternative to `code_text_field` and `flutter_code_editor`.
*   **Status**: Active development, positioned as a "VS Code-like" experience.

## Cross-References
*   [Architecture Details](02-technical-details/architecture.md)
*   [LSP Implementation](04-examples/lsp-integration.md)
*   [Comparison](01-overview/introduction.md#comparison-with-alternatives)

## Citations
1.  **Repository**: [heckmon/code_forge](https://github.com/heckmon/code_forge)
2.  **Package**: [pub.dev/packages/code_forge](https://pub.dev/packages/code_forge)

