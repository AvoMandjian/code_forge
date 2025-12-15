# API Reference

## CodeForge Widget
The main entry point.

```dart
CodeForge({
  Key? key,
  CodeForgeController? controller,
  UndoRedoController? undoController,
  Map<String, TextStyle>? editorTheme, // from re_highlight
  Mode? language, // from re_highlight
  FocusNode? focusNode,
  TextStyle? textStyle,
  AiCompletion? aiCompletion,
  LspConfig? lspConfig,
  String? filePath, // Required for LSP
  String? initialText,
  bool readOnly = false,
  bool lineWrap = false,
  bool autoFocus = true,
  bool enableFolding = true,
  bool enableGutter = true,
  bool enableGuideLines = true,
  // Styling...
})
```

## CodeForgeController
Manages text and selection.

| Method | Description |
|--------|-------------|
| `text` (get/set) | The full text content. |
| `selection` | Current cursor/selection range. |
| `insertAtCurrentCursor(String)` | Inserts text programmatically. |
| `foldAll() / unfoldAll()` | Collapses/expands all fold regions. |
| `toggleFold(int line)` | Toggles fold at specific line. |
| `getLineText(int index)` | Returns text of a specific line. |
| `saveFile()` | Triggers save logic (often for LSP `didSave`). |

## LspConfig
Configuration for Language Server Protocol.

### LspStdioConfig
For local processes (desktop).
```dart
await LspStdioConfig.start(
  executable: 'path/to/server', // e.g. 'dart', 'pyright'
  args: ['argument', 'list'],
  filePath: '/path/to/file.dart',
  workspacePath: '/path/to/project',
  languageId: 'dart',
)
```

### LspSocketConfig
For remote/proxy servers.
```dart
LspSocketConfig(
  serverUrl: 'ws://localhost:5000',
  filePath: '/path/to/file.dart',
  workspacePath: '/path/to/project',
  languageId: 'python',
)
```

## AiCompletion
Configuration for AI features.

```dart
AiCompletion({
  required Models model, // Gemini, OpenAI, etc.
  bool enableCompletion = true,
  CompletionType completionType = CompletionType.auto,
  int debounceTime = 1000,
})
```

