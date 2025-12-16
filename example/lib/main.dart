import 'dart:io';

import 'package:code_forge/code_forge.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:re_highlight/languages/all.dart';
import 'package:re_highlight/styles/all.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _controller = CodeForgeController();
  final undoController = UndoRedoController();
  final absFilePath = p.join(Directory.current.path, "lib/example_code.dart");
  String _selectedLanguage = 'json';
  String _selectedTheme = 'vs2015';

  Future<LspConfig> getLsp() async {
    final absWorkspacePath = p.join(Directory.current.path, "lib");
    final data = await LspStdioConfig.start(
      executable: "dart",
      args: ["language-server", "--protocol=lsp"],
      filePath: absFilePath,
      workspacePath: absWorkspacePath,
      languageId: "dart",
    );
    return data;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: DropdownButton<String>(
                        value: _selectedLanguage,
                        isExpanded: true,
                        items: ['jinja', 'html', 'json', 'sql'].map((
                          String key,
                        ) {
                          return DropdownMenuItem<String>(
                            value: key,
                            child: Text(key),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              _selectedLanguage = newValue;
                            });
                            _controller.setLanguage(newValue);
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: DropdownButton<String>(
                        value: _selectedTheme,
                        isExpanded: true,
                        items: builtinAllThemes.keys.map((String key) {
                          return DropdownMenuItem<String>(
                            value: key,
                            child: Text(key),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              _selectedTheme = newValue;
                            });
                            _controller.setTheme(newValue);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: FutureBuilder<LspConfig>(
                  future: getLsp(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return CodeForge(
                      autoFocus: true,
                      undoController: undoController,
                      language: builtinAllLanguages[_selectedLanguage],
                      controller: _controller,
                      aiCompletion: AiCompletion(
                        model: Gemini(
                          apiKey: Platform.environment['GEMINI_API_KEY'] ?? '',
                        ),
                      ),
                      lineWrap: true,
                      lspConfig: snapshot.data,
                      filePath: absFilePath,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
