# Basic Usage Example

This example demonstrates a simple setup with a controller, undo/redo, and syntax highlighting.

```dart
import 'package:flutter/material.dart';
import 'package:code_forge/code_forge.dart';
import 'package:re_highlight/languages/dart.dart';
import 'package:re_highlight/styles/vs2015.dart';
import 'package:google_fonts/google_fonts.dart';

class SimpleEditor extends StatefulWidget {
  const SimpleEditor({super.key});

  @override
  State<SimpleEditor> createState() => _SimpleEditorState();
}

class _SimpleEditorState extends State<SimpleEditor> {
  late final CodeForgeController _controller;
  late final UndoRedoController _undoController;

  @override
  void initState() {
    super.initState();
    _controller = CodeForgeController();
    _undoController = UndoRedoController();
    
    // Set initial text
    _controller.text = '''
void main() {
  print("Hello, CodeForge!");
}
''';
  }

  @override
  void dispose() {
    _controller.dispose();
    _undoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CodeForge Demo')),
      body: CodeForge(
        controller: _controller,
        undoController: _undoController,
        language: langDart,
        editorTheme: vs2015Theme,
        textStyle: GoogleFonts.jetBrainsMono(fontSize: 14),
        enableFolding: true,
        enableGutter: true,
        enableGuideLines: true,
        lineWrap: false,
      ),
    );
  }
}
```

