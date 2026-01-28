# LSP Integration Example

This example shows how to connect to the Dart Analysis Server (available in the Flutter SDK) for real IDE features.

**Note**: This requires running on a desktop platform (macOS, Linux, Windows) where the `dart` executable is available in the path.

```dart
import 'package:flutter/material.dart';
import 'package:code_forge/code_forge.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:re_highlight/languages/dart.dart';

class DartLspEditor extends StatefulWidget {
  const DartLspEditor({super.key});

  @override
  State<DartLspEditor> createState() => _DartLspEditorState();
}

class _DartLspEditorState extends State<DartLspEditor> {
  final _controller = CodeForgeController();
  
  // Using a Future to manage LSP initialization
  late Future<LspConfig> _lspInitFuture;
  
  // Valid absolute path to a dart file on your machine
  final String _targetFile = '/Users/username/projects/myapp/lib/main.dart';
  final String _workspace = '/Users/username/projects/myapp';

  @override
  void initState() {
    super.initState();
    _lspInitFuture = _initLsp();
  }

  Future<LspConfig> _initLsp() async {
    // Start the Dart Analysis Server in LSP mode
    return await LspStdioConfig.start(
      executable: 'dart',
      args: ['language-server', '--protocol=lsp'],
      filePath: _targetFile,
      workspacePath: _workspace,
      languageId: 'dart',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<LspConfig>(
        future: _lspInitFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (snapshot.hasError) {
            return Center(child: Text('Error starting LSP: ${snapshot.error}'));
          }

          return CodeForge(
            controller: _controller,
            language: langDart,
            textStyle: GoogleFonts.jetBrainsMono(fontSize: 14),
            
            // Critical: Enable LSP configuration
            lspConfig: snapshot.data,
            filePath: _targetFile, // Must match the config
            
            enableSuggestions: true, // Enable autocomplete popup
          );
        },
      ),
    );
  }
}
```

