# API Reference

## CodeController
```dart
CodeController({
  String? text, // Initial text
  Mode? language, // Language definition
  AbstractAnalyzer? analyzer, // Error checker
  Map<String, TextStyle>? theme, // Syntax colors
  // ... modifiers and params
})
```

### Key Properties
| Property | Description |
|----------|-------------|
| `fullText` | The actual content (including hidden parts). |
| `readOnlySectionNames` | Set of section names that are locked. |
| `visibleSectionNames` | Set of section names to show (hides everything else). |
| `foldedBlocks` | Currently collapsed blocks. |

### Key Methods
| Method | Description |
|--------|-------------|
| `foldAt(int line)` | Folds the block at the given line. |
| `unfoldAt(int line)` | Unfolds the block. |
| `foldAll() / unfoldAll()` | Global fold actions. |
| `setCursor(int offset)` | Moves cursor safely. |

## CodeField
```dart
CodeField({
  required CodeController controller,
  bool readOnly = false,
  bool lineNumbers = true,
  GutterStyle gutterStyle,
  // ... styling
})
```

## AbstractAnalyzer
```dart
abstract class AbstractAnalyzer {
  Future<AnalysisResult> analyze(Code code);
}
```
*   Implement this to connect to a backend (LSP proxy, API, linter).

