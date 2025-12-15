# Flutter Code Editor - Comprehensive Research & Documentation

## Overview
**Flutter Code Editor** (pub: `flutter_code_editor`, repo: `akvelon/flutter-code-editor`) is a popular, multi-platform code editing widget. Unlike `code_forge`, it builds directly on top of Flutter's `TextEditingController` and standard text rendering pipeline (`TextSpan`, `TextField`), adding layers for syntax highlighting (via regex), code folding, and basic analysis. It is highly customizable and stable but optimized for medium-sized files rather than massive ones.

## Quick Start
Add to `pubspec.yaml`:
```yaml
dependencies:
  flutter_code_editor: ^0.3.5
  flutter_highlight: ^0.7.0
```

Basic implementation:
```dart
final controller = CodeController(
  text: 'void main() {}',
  language: java,
);

CodeTheme(
  data: CodeThemeData(styles: monokaiSublimeTheme),
  child: CodeField(controller: controller),
)
```

## Table of Contents
- [Research Summary](00-research-summary.md)
- [Overview](01-overview/)
  - [Introduction](01-overview/introduction.md)
  - [Key Concepts](01-overview/key-concepts.md)
- [Technical Details](02-technical-details/)
  - [Architecture](02-technical-details/architecture.md)
  - [API Reference](02-technical-details/api-reference.md)
- [Best Practices](03-best-practices/)
- [Examples](04-examples/)
- [Resources](05-resources/)

## Key Findings
1.  **Architecture**: Extends `TextEditingController`. It essentially "hacks" the text value to hide folded blocks from the widget while keeping them in memory.
2.  **Performance**: Good for standard files. Performance degrades on large files (10k+ lines) because it reconstructs `TextSpan` trees on every edit using Regex.
3.  **Features**: Strong support for "Named Sections" (read-only/hidden blocks), which makes it excellent for **educational apps** or tutorials where you want to lock parts of the code.
4.  **Web Support**: Works out-of-the-box on Web (unlike `code_forge`), making it the go-to choice for web-based tools.

## Research Metadata
- **Created**: 2025-01-27
- **Sources**: GitHub (Akvelon), Pub.dev
- **Depth**: Comprehensive

