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
  String _selectedLanguage = 'html';
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
    _controller.text = """<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>{{ config.app_name }} - User Dashboard</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        .welcome { color: {{ colors.primary }}; font-size: 24px; }
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        .status-{% if user.active %}active{% else %}inactive{% endif %} { font-weight: bold; }
    </style>
</head>
<body>
    <div class="welcome">
        {% if user.is_premium %}
            <h1>👑 Welcome back, {{ user.name | title }}!</h1>
            <p>Premium member since {{ user.premium_since.strftime('%B %Y') }}.</p>
        {% else %}
            <h1>Hello, {{ user.name | default('User') }}!</h1>
            <p>Upgrade for premium features.</p>
        {% endif %}
    </div>

    {# Macro for reusable user card #}
    {% macro user_card(user) %}
        <div style="border: 1px solid #ccc; padding: 20px; margin: 10px 0; border-radius: 8px;">
            <h3>{{ user.name }}</h3>
            <p><strong>Email:</strong> {{ user.email }}</p>
            <p><strong>Score:</strong> {{ user.score | int | default(0) }}</p>
            <p class="status-{{ 'active' if user.active else 'inactive' }}">
                Status: {{ 'Active' if user.active else 'Inactive' }}
            </p>
            {% if user.score > 1000 %}
                🏆 Elite Member
            {% endif %}
        </div>
    {% endmacro %}

    {# Leaderboard table with sorting #}
    <h2>🏆 Leaderboard (Top {{ users | length | min(10) }})</h2>
    <table>
        <thead>
            <tr>
                <th>Rank</th>
                <th>Name</th>
                <th>Score</th>
                <th>Country</th>
                <th>Last Active</th>
            </tr>
        </thead>
        <tbody>
            {% for user in users | sort(attribute='score', reverse=True) | list | slice(10) %}
                <tr>
                    <td>{{ loop.index }}</td>
                    <td>{{ user.name | truncate(20) }}</td>
                    <td>{{ user.score | floatformat(0) }}</td>
                    <td>
                        <img src="https://flagcdn.com/24x18/{{ user.country.lower() }}.png" alt="{{ user.country }}">
                        {{ user.country }}
                    </td>
                    <td>{{ user.last_active.strftime('%Y-%m-%d') if user.last_active else 'Never' }}</td>
                </tr>
            {% else %}
                <tr><td colspan="5">No users found.</td></tr>
            {% endfor %}
        </tbody>
    </table>

    {# Nested loops: Users by country #}
    <h2>👥 Users by Country</h2>
    {% for country, country_users in users | groupby('country') | list %}
        <h3>{{ country }} ({{ country_users | list | length }} users)</h3>
        <div style="display: flex; flex-wrap: wrap;">
            {% for user in country_users | list | slice(3) %}
                {{ user_card(user) }}
            {% endfor %}
        </div>
    {% endfor %}

    {# Filters and custom logic #}
    <h2>📊 Stats</h2>
    <ul>
        <li>Total Users: {{ users | length }}</li>
        <li>Avg Score: {{ users | map(attribute='score') | list | avg | round(1) }}</li>
        <li>Premium Users: {{ users | selectattr('is_premium') | list | length }}</li>
        <li>Countries: {{ users | map(attribute='country') | unique | list | length }}</li>
    </ul>

    {# Custom filters example (requires registration in Python) #}
    <p>Total Score (custom): {{ users | map(attribute='score') | sum }} ({{ (users | map(attribute='score') | sum) | filesizeformat }})</p>

    {# Include external template (if using includes) #}
    {% include 'footer.html' ignore missing %}

    {# Set block for inheritance #}
    {% block scripts %}
        <script>
            console.log('Rendered at {{ now.strftime("%Y-%m-%d %H:%M") }}');
        </script>
    {% endblock %}
</body>
</html>
""";
    super.initState();
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
                      ],
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
                          //     apiKey: Platform.environment['GEMINI_API_KEY'] ?? '',
                          //   ),
                          // ),
                          saveFile: () {
                            print('saveFile');
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
