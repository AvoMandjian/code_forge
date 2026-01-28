// import 'dart:io';

import 'package:code_forge/code_forge.dart';
import 'package:code_forge/code_forge/suggestion_model.dart';
import 'package:example/finder.dart';
import 'package:flutter/material.dart';
import 'package:re_highlight/languages/all.dart';
// import 'package:path/path.dart' as p;
import 'package:re_highlight/styles/all.dart';
import 'package:re_highlight/styles/atom-one-dark-reasonable.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final undoController = UndoRedoController();
  // // final absFilePath = p.join(Directory.current.path, "lib/example_code.dart");
  CodeForgeController? codeController;
  final String _selectedLanguage = 'json';
  final String _selectedTheme = 'vs2015';
  final _rulerController = TextEditingController(text: '80');
  final bool _aiCompletionEnabled = false;

  // // Future<LspConfig> getLsp() async {
  // //   final absWorkspacePath = p.join(Directory.current.path, "lib");
  // //   final data = await LspStdioConfig.start(
  // //     executable: "dart",
  // //     args: ["language-server", "--protocol=lsp"],
  // // //     workspacePath: absWorkspacePath,
  // //     languageId: "dart",
  // //   );
  // //   return data;
  // }

  void _registerCustomSuggestions() {
    final backendSuggestions = [
      {
        "label": "Example Variables from backend",
        "replaced_on_click": "{{ example_variable }}",
        "triggered_at": "aaa",
        "jinja_html_widget": {
          'widget_id': 'html_widget',
          'widget_type': 'html_widget',
          'html':
              """<h2>&lt;{{ }}&gt; Variable Output</h2><p><strong>Jinja template variable</strong> for outputting data from backend.</p><pre><code>{{ example_variable }}</code></pre><p><strong>Usage:</strong> Inserts variable value into template</p><p><strong>Syntax:</strong> <code>{{ variable_name }}</code> &mdash; <strong>Double curly braces</strong></p>""",
          'loading': false,
        },
        "description":
            "<h2>&lt;{{ }}&gt; Variable Output</h2><p><strong>Jinja template variable</strong> for outputting data from backend.</p><pre><code>{{ example_variable }}</code></pre><p><strong>Usage:</strong> Inserts variable value into template</p><p><strong>Syntax:</strong> <code>{{ variable_name }}</code> &mdash; <strong>Double curly braces</strong></p>",
      },
      {
        "label": "Example Variables from backend 2",
        "replaced_on_click": "{{ example_variable_2 }}",
        "triggered_at": "bbb",
        "jinja_html_widget": {
          'widget_id': 'html_widget',
          'widget_type': 'html_widget',
          'html':
              """<h2>&lt;{{ }}&gt; Variable Output</h2><p><strong>Jinja template variable</strong> for outputting data from backend.</p><pre><code>{{ example_variable }}</code></pre><p><strong>Usage:</strong> Inserts variable value into template</p><p><strong>Syntax:</strong> <code>{{ variable_name }}</code> &mdash; <strong>Double curly braces</strong></p>""",
          'loading': false,
        },
        "description":
            "<h2>&lt;{{ }}&gt; Variable Output</h2><p><strong>Jinja template variable</strong> for outputting data from backend.</p><pre><code>{{ example_variable }}</code></pre><p><strong>Usage:</strong> Inserts variable value into template</p><p><strong>Syntax:</strong> <code>{{ variable_name }}</code> &mdash; <strong>Double curly braces</strong></p>",
      },
      {
        "label": "Example Variables from backend 3",
        "replaced_on_click": "{{ example_variable_3 }}",
        "triggered_at": "ccc",
        "jinja_html_widget": {
          'widget_id': 'html_widget',
          'widget_type': 'html_widget',
          'html':
              """<h2>&lt;{{ }}&gt; Variable Output</h2><p><strong>Jinja template variable</strong> for outputting data from backend.</p><pre><code>{{ example_variable }}</code></pre><p><strong>Usage:</strong> Inserts variable value into template</p><p><strong>Syntax:</strong> <code>{{ variable_name }}</code> &mdash; <strong>Double curly braces</strong></p>""",
          'loading': false,
        },
        "description":
            "<h2>&lt;{{ }}&gt; Variable Output</h2><p><strong>Jinja template variable</strong> for outputting data from backend.</p><pre><code>{{ example_variable }}</code></pre><p><strong>Usage:</strong> Inserts variable value into template</p><p><strong>Syntax:</strong> <code>{{ variable_name }}</code> &mdash; <strong>Double curly braces</strong></p>",
      },
      {
        "label": "Example Variables from backend 4",
        "replaced_on_click": "{{ example_variable_4 }}",
        "triggered_at": "bbb",
        "jinja_html_widget": {
          'widget_id': 'html_widget',
          'widget_type': 'html_widget',
          'html':
              """<h2>&lt;{{ }}&gt; Variable Output</h2><p><strong>Jinja template variable</strong> for outputting data from backend.</p><pre><code>{{ example_variable }}</code></pre><p><strong>Usage:</strong> Inserts variable value into template</p><p><strong>Syntax:</strong> <code>{{ variable_name }}</code> &mdash; <strong>Double curly braces</strong></p>""",
          'loading': false,
        },
        "description":
            "<h2>&lt;{{ }}&gt; Variable Output</h2><p><strong>Jinja template variable</strong> for outputting data from backend.</p><pre><code>{{ example_variable }}</code></pre><p><strong>Usage:</strong> Inserts variable value into template</p><p><strong>Syntax:</strong> <code>{{ variable_name }}</code> &mdash; <strong>Double curly braces</strong></p>",
      },
    ];
    final suggestions = backendSuggestions
        .map(
          (item) => SuggestionModel.fromJson(Map<String, dynamic>.from(item)),
        )
        .toList();
    codeController?.registerCustomSuggestions(suggestions);
  }

  @override
  void initState() {
    codeController?.text = """
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
    codeController?.disableAiCompletion();

    // Register custom suggestions for testing
    _registerCustomSuggestions();

    super.initState();
  }

  void _updateRuler() {
    final rulerValue = int.tryParse(_rulerController.text);
    if (rulerValue != null && rulerValue > 0) {
      codeController?.setRulers([rulerValue]);
    } else {
      codeController?.clearRulers();
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            codeController?.setGitDiffDecorations(
              addedRanges: [(1, 5), (10, 25)],
              removedRanges: [(30, 37)],
            );
            codeController?.scrollToLine(100);
          },
        ),
        body: SafeArea(
          child: CodeForge(
            undoController: undoController,
            language: langDart,
            editorTheme: atomOneDarkReasonableTheme,
            controller: codeController,
            matchHighlightStyle: const MatchHighlightStyle(
              currentMatchStyle: TextStyle(backgroundColor: Color(0xFFFFA726)),
              otherMatchStyle: TextStyle(backgroundColor: Color(0x55FFFF00)),
            ),
            finderBuilder: (c, controller) =>
                FindPanelView(controller: controller),
          ),
        ),
      ),
    );
  }
}
