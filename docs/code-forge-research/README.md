# CodeForge - Comprehensive Research & Documentation

## Overview
**CodeForge** is a high-performance, feature-rich code editor package for Flutter, designed to provide a VS Code-like editing experience. Unlike standard Flutter text fields, it utilizes a **Rope data structure** for efficient large file handling and a custom **RenderBox** architecture for optimized rendering. It distinguishes itself with built-in **Language Server Protocol (LSP)** support, **AI code completion** (Gemini, OpenAI, etc.), and extensive customization options.

## Quick Start
Add to `pubspec.yaml`:
```yaml
dependencies:
  code_forge: ^1.1.0
```

Basic implementation:
```dart
CodeForge(
  controller: CodeForgeController(),
  language: langDart, // from re_highlight
  enableFolding: true,
  enableGutter: true,
)
```

## Table of Contents
- [Research Summary](00-research-summary.md) - Executive summary of findings and citations.
- [Overview](01-overview/) - Introduction and key concepts.
  - [Introduction](01-overview/introduction.md)
  - [Key Concepts](01-overview/key-concepts.md)
- [Technical Details](02-technical-details/) - Architecture and API reference.
  - [Architecture](02-technical-details/architecture.md)
  - [API Reference](02-technical-details/api-reference.md)
- [Best Practices](03-best-practices/) - Implementation guidelines.
- [Examples](04-examples/) - Code examples for LSP and AI.
- [Resources](05-resources/) - External references.

## Key Findings
1.  **Performance Architecture**: Uses a **Rope** data structure instead of simple Strings, allowing it to handle files with 100k+ lines efficiently, solving a major bottleneck in standard Flutter `TextField` based editors.
2.  **LSP Integration**: It is one of the few Flutter editors with a built-in, fully functional **Language Server Protocol** client (supporting both WebSocket and Stdio), enabling real IDE features like "Go to Definition", "Find References", and "Rename".
3.  **AI Native**: Built-in architecture for AI completion providers (Gemini, OpenAI, Claude, DeepSeek) with ghost text and debounce handling.

## Research Metadata
- **Created**: 2025-01-27
- **Sources**: GitHub Repository (Source Code Analysis), Pub.dev, Web Search
- **Depth**: Comprehensive (Source Code Analysis via Repomix)

