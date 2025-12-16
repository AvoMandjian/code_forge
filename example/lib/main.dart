import 'dart:io';

import 'package:code_forge/code_forge.dart';
import 'package:code_forge/code_forge/suggestion_model.dart';
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
  final _rulerController = TextEditingController(text: '80');
  bool _aiCompletionEnabled = false;

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

  void _registerCustomSuggestions() {
    // Example 1: Register suggestions from backend JSON format (snake_case)
    final backendSuggestions = [];

    // Convert backend JSON to SuggestionModel list
    final suggestions = backendSuggestions
        .map((item) => SuggestionModel.fromMap(item as Map<String, dynamic>))
        .toList();

    // Register the suggestions
    _controller.registerCustomSuggestions(suggestions);

    // Example 2: You can also register suggestions directly using camelCase
    // _controller.registerCustomSuggestions([
    //   SuggestionModel(
    //     label: 'Direct Example',
    //     replacedOnClick: 'Direct replacement text',
    //     description: 'This is a direct example',
    //     triggeredAt: '{{}}',
    //   ),
    // ]);
  }

  @override
  void initState() {
    _controller.text = """
 {
    "id": 1,
    "name": "John Doe",
    "email": "john.doe@example.com"
  }
  """;
    _updateRuler();
    _controller.disableAiCompletion();

    // Register custom suggestions for testing
    _registerCustomSuggestions();

    super.initState();
  }

  void _updateRuler() {
    final rulerValue = int.tryParse(_rulerController.text);
    if (rulerValue != null && rulerValue > 0) {
      _controller.setRulers([rulerValue]);
    } else {
      _controller.clearRulers();
    }
  }

  @override
  void dispose() {
    _rulerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (BuildContext scaffoldContext) {
            return SafeArea(
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
                        const SizedBox(width: 16),
                        ElevatedButton.icon(
                          onPressed: () {
                            try {
                              _controller.saveFile();
                              ScaffoldMessenger.of(
                                scaffoldContext,
                              ).showSnackBar(
                                const SnackBar(
                                  content: Text('File saved successfully'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(
                                scaffoldContext,
                              ).showSnackBar(
                                SnackBar(
                                  content: Text('Error saving file: $e'),
                                  backgroundColor: Colors.red,
                                  duration: const Duration(seconds: 3),
                                ),
                              );
                            }
                          },
                          icon: const Icon(Icons.save),
                          label: const Text('Save'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton.icon(
                          onPressed: () {
                            _controller.formatCode();
                            ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                              const SnackBar(
                                content: Text('Code formatted'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                          icon: const Icon(Icons.format_align_left),
                          label: const Text('Format'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              _aiCompletionEnabled = !_aiCompletionEnabled;
                            });
                            if (_aiCompletionEnabled) {
                              _controller.enableAiCompletion();
                            } else {
                              _controller.disableAiCompletion();
                            }
                            ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                              SnackBar(
                                content: Text(
                                  _aiCompletionEnabled
                                      ? 'AI completion enabled'
                                      : 'AI completion disabled',
                                ),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                          icon: Icon(
                            _aiCompletionEnabled
                                ? Icons.smart_toy
                                : Icons.smart_toy_outlined,
                          ),
                          label: Text(
                            _aiCompletionEnabled ? 'AI On' : 'AI Off',
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _aiCompletionEnabled
                                ? Colors.green
                                : Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: 80,
                          child: TextField(
                            controller: _rulerController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Ruler',
                              hintText: '80',
                              border: OutlineInputBorder(),
                              isDense: true,
                              contentPadding: EdgeInsets.all(8),
                            ),
                            onSubmitted: (_) => _updateRuler(),
                            onChanged: (_) => _updateRuler(),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Tooltip(
                          message: 'Test custom suggestions manually',
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // Test custom suggestions manually
                              _controller.showCustomSuggestions([]);
                              ScaffoldMessenger.of(
                                scaffoldContext,
                              ).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Manual suggestions shown. Try typing "{{" to see automatic triggers!',
                                  ),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            },
                            icon: const Icon(Icons.auto_awesome),
                            label: const Text('Test'),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Instructions banner
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8.0),
                    color: Colors.blue.shade50,
                    child: const Text(
                      '💡 Tip: Type "{{" or "<<" to see custom suggestions automatically appear!',
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder<LspConfig>(
                      future: getLsp(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return CodeForge(
                          undoController: undoController,
                          language: builtinAllLanguages[_selectedLanguage],
                          controller: _controller,
                          // aiCompletion: AiCompletion(
                          //   model: Gemini(
                          //     apiKey:
                          //         Platform.environment['GEMINI_API_KEY'] ?? '',
                          //   ),
                          // ),
                          saveFile: () {
                            debugPrint('saveFile: ${_controller.text}');
                          },
                          lineWrap: true,
                          lspConfig: snapshot.data,

                          filePath: absFilePath,
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
