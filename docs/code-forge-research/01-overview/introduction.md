# Introduction to CodeForge

## What is CodeForge?
CodeForge is a comprehensive code editor widget for Flutter applications. It is designed to overcome the limitations of standard Flutter text input widgets when dealing with code editing tasks—specifically performance with large files, syntax highlighting accuracy, and advanced IDE features.

It is **not** just a syntax highlighter; it is a full-featured editing engine that manages its own text state, rendering pipeline, and external integrations (LSP/AI).

## Core Features

### 📝 Editing Experience
*   **Large File Support**: Tested with 100k+ lines of code without UI jank.
*   **Syntax Highlighting**: Supports 180+ languages via `re_highlight`.
*   **Folding**: Smart code folding based on indentation and brackets.
*   **Minimap**: (Planned/Implicit in architecture) Efficient scrolling and navigation.
*   **Undo/Redo**: Robust history management with operation grouping.

### 🧠 Intelligence
*   **LSP Client**: Connects to language servers for "real" IDE features (errors, types, definitions).
*   **AI Completion**: Integrated "Copilot-like" experience with ghost text suggestions.
*   **Search**: Regex-based find and replace with highlighting.

### 🎨 Customization
*   **Theming**: Compatible with standard syntax themes (VS2015, Atom One Dark, etc.).
*   **Gutter**: Customizable line numbers, fold icons, and error indicators.
*   **Fonts**: Includes custom icon fonts for completion types (Class, Method, Variable, etc.).

## Comparison with Alternatives

| Feature | CodeForge | code_text_field | flutter_code_editor |
|---------|-----------|-----------------|---------------------|
| **Data Structure** | **Rope** (Tree-based) | String (Linear) | String / Controller |
| **Rendering** | Custom **RenderBox** | TextField | TextField / Custom |
| **LSP Support** | ✅ **Built-in** (Full) | ❌ (Regex only) | ❌ (Regex only) |
| **AI Integration** | ✅ **Built-in** | ❌ | ❌ |
| **Performance** | ⭐⭐⭐⭐⭐ (100k+ lines) | ⭐⭐ (Lags on large files) | ⭐⭐⭐ |
| **Web Support** | ❌ (Relies on `dart:io`) | ✅ | ✅ |

**Note**: CodeForge currently relies on `dart:io` for process management (LSP stdio) and socket connections, making it **incompatible with Flutter Web** at this time. This is a critical trade-off for its advanced capabilities.

