// import 'dart:io';

import 'package:code_forge/code_forge.dart';
import 'package:code_forge/code_forge/suggestion_model.dart';
import 'package:flutter/material.dart';
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
  // final absFilePath = p.join(Directory.current.path, "lib/example_code.dart");
  String _selectedLanguage = 'json';
  String _selectedTheme = 'vs2015';
  final _rulerController = TextEditingController(text: '80');
  bool _aiCompletionEnabled = false;

  // Future<LspConfig> getLsp() async {
  //   final absWorkspacePath = p.join(Directory.current.path, "lib");
  //   final data = await LspStdioConfig.start(
  //     executable: "dart",
  //     args: ["language-server", "--protocol=lsp"],
  //     filePath: absFilePath,
  //     workspacePath: absWorkspacePath,
  //     languageId: "dart",
  //   );
  //   return data;
  // }

  void _registerCustomSuggestions() {
    final backendSuggestions = [
      {
        "label": "Example Variables from backend",
        "replaced_on_click": "{{ example_variable }}",
        "triggered_at": "aaa",
        "jinja_html_widget": {},
        "description":
            "<h2>&lt;{{ }}&gt; Variable Output</h2><p><strong>Jinja template variable</strong> for outputting data from backend.</p><pre><code>{{ example_variable }}</code></pre><p><strong>Usage:</strong> Inserts variable value into template</p><p><strong>Syntax:</strong> <code>{{ variable_name }}</code> &mdash; <strong>Double curly braces</strong></p>",
      },
      {
        "label": "Example Variables from backend 2",
        "replaced_on_click": "{{ example_variable_2 }}",
        "triggered_at": "bbb",
        "jinja_html_widget": {},
        "description":
            "<h2>&lt;{{ }}&gt; Variable Output</h2><p><strong>Jinja template variable</strong> for outputting data from backend.</p><pre><code>{{ example_variable }}</code></pre><p><strong>Usage:</strong> Inserts variable value into template</p><p><strong>Syntax:</strong> <code>{{ variable_name }}</code> &mdash; <strong>Double curly braces</strong></p>",
      },
      {
        "label": "Example Variables from backend 3",
        "replaced_on_click": "{{ example_variable_3 }}",
        "triggered_at": "ccc",
        "jinja_html_widget": {},
        "description":
            "<h2>&lt;{{ }}&gt; Variable Output</h2><p><strong>Jinja template variable</strong> for outputting data from backend.</p><pre><code>{{ example_variable }}</code></pre><p><strong>Usage:</strong> Inserts variable value into template</p><p><strong>Syntax:</strong> <code>{{ variable_name }}</code> &mdash; <strong>Double curly braces</strong></p>",
      },
      {
        "label": "Example Variables from backend 4",
        "replaced_on_click": "{{ example_variable_4 }}",
        "triggered_at": "bbb",
        "jinja_html_widget": {},
        "description":
            "<h2>&lt;{{ }}&gt; Variable Output</h2><p><strong>Jinja template variable</strong> for outputting data from backend.</p><pre><code>{{ example_variable }}</code></pre><p><strong>Usage:</strong> Inserts variable value into template</p><p><strong>Syntax:</strong> <code>{{ variable_name }}</code> &mdash; <strong>Double curly braces</strong></p>",
      },
    ];
    final suggestions = backendSuggestions
        .map((item) => SuggestionModel.fromJson(item as Map<String, dynamic>))
        .toList();
    _controller.registerCustomSuggestions(suggestions);
  }

  @override
  void initState() {
    _controller.text = """
{
  "meta": {
    "app": "{{ app_name | default('My Application') }}",
    "environment": "{{ env | default('production') }}",
    "generatedAt": "{{ generated_at | date('Y-m-d\\TH:i:s') }}",
    "requestId": "{{ request_id }}",
    "version": "{{ version | default('1.0.0') }}"
  },

  "currentUser": {% if current_user %}
  {
    "id": {{ current_user.id }},
    "name": "{{ current_user.name }}",
    "email": "{{ current_user.email }}",
    "roles": [
      {% for role in current_user.roles %}
        "{{ role }}"{% if not loop.last %},{% endif %}
      {% endfor %}
    ],
    "isAdmin": {{ current_user.is_admin | lower }}
  }
  {% else %}
  null
  {% endif %},

  "statistics": {
    "totalUsers": {{ stats.total_users | default(0) }},
    "activeUsers": {{ stats.active_users | default(0) }},
    "inactiveUsers": {{ stats.inactive_users | default(0) }}
  },

  "users": [
    {% for user in users %}
    {
      "id": {{ user.id }},
      "name": "{{ user.name }}",
      "email": "{{ user.email }}",
      "status": "{{ 'active' if user.active else 'inactive' }}",
      "createdAt": "{{ user.created_at | date('Y-m-d') }}",
      "tags": [
        {% for tag in user.tags %}
          "{{ tag }}"{% if not loop.last %},{% endif %}
        {% endfor %}
      ]
    }{% if not loop.last %},{% endif %}
    {% endfor %}
  ],

  "features": {
    "billingEnabled": {{ features.billing_enabled | default(false) | lower }},
    "notificationsEnabled": {{ features.notifications | default(true) | lower }},
    "beta": {{ features.beta | default(false) | lower }}
  },

  "limits": {
    "maxUsers": {{ limits.max_users | default(1000) }},
    "maxRequestsPerMinute": {{ limits.rate_limit | default(60) }}
  },

  "messages": [
    {% for msg in messages %}
    {
      "level": "{{ msg.level }}",
      "text": "{{ msg.text }}"
    }{% if not loop.last %},{% endif %}
    {% endfor %}
  ]
}""";
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
                              _controller.registerCustomSuggestions([
                                SuggestionModel(
                                  label: 'Example Variables from backend',
                                  replacedOnClick: '{{ example_variable }}',
                                  triggeredAt: 'aaa',
                                  description:
                                      '<h2>&lt;{{ }}&gt; Variable Output</h2><p><strong>Jinja template variable</strong> for outputting data from backend.</p><pre><code>{{ example_variable }}</code></pre><p><strong>Usage:</strong> Inserts variable value into template</p><p><strong>Syntax:</strong> <code>{{ variable_name }}</code> &mdash; <strong>Double curly braces</strong></p>',
                                ),
                                SuggestionModel(
                                  label: 'Example Variables from backend',
                                  replacedOnClick: '{{ example_variable }}',
                                  triggeredAt: 'aaa',
                                  description:
                                      '<h2>&lt;{{ }}&gt; Variable Output</h2><p><strong>Jinja template variable</strong> for outputting data from backend.</p><pre><code>{{ example_variable }}</code></pre><p><strong>Usage:</strong> Inserts variable value into template</p><p><strong>Syntax:</strong> <code>{{ variable_name }}</code> &mdash; <strong>Double curly braces</strong></p>',
                                ),
                              ]);
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
                    child: CodeForge(
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
