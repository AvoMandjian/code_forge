import 'dart:convert';

/// Code formatter utilities for various languages
class CodeFormatter {
  /// Formats code based on the language type
  ///
  /// Returns the formatted code, or null if formatting is not supported
  static String? formatCode(String code, String? languageName) {
    if (languageName == null) return null;

    final langLower = languageName.toLowerCase();

    if (langLower == 'json' || langLower.contains('json')) {
      return formatJson(code);
    } else if (langLower == 'html' ||
        langLower == 'xml' ||
        langLower.contains('html') ||
        langLower.contains('xml')) {
      return formatHtml(code);
    } else if (langLower == 'sql' || langLower.contains('sql')) {
      return formatSql(code);
    } else if (langLower == 'jinja' ||
        langLower == 'jinja2' ||
        langLower == 'j2' ||
        langLower.contains('jinja')) {
      return formatJinja(code);
    }

    return null;
  }

  /// Formats JSON code
  static String formatJson(String json) {
    try {
      // Parse and pretty print JSON using dart:convert
      final dynamic decoded = jsonDecode(json);
      const encoder = JsonEncoder.withIndent('  ');
      return encoder.convert(decoded);
    } catch (e) {
      return json; // Return original if parsing fails
    }
  }

  /// Formats HTML code
  static String formatHtml(String html) {
    final buffer = StringBuffer();
    int indent = 0;
    final indentStr = '  ';
    final lines = html.split('\n');
    final tagStack =
        <String>[]; // Track opening tags to match with closing tags

    for (final line in lines) {
      final trimmed = line.trim();
      if (trimmed.isEmpty) {
        buffer.writeln();
        continue;
      }

      // Check for closing tags
      if (trimmed.startsWith('</')) {
        // Decrease indent first so closing tag aligns with its opening tag
        if (indent > 0) {
          indent--;
        }
        buffer.write(indentStr * indent);
        buffer.writeln(trimmed);
        // Pop from stack if we have matching tags
        if (tagStack.isNotEmpty) {
          tagStack.removeLast();
        }
        continue;
      }

      // Check for self-closing tags
      if (trimmed.contains('/>')) {
        buffer.write(indentStr * indent);
        buffer.writeln(trimmed);
        continue;
      }

      // Check for opening tags
      if (trimmed.startsWith('<') && trimmed.contains('>')) {
        final tagMatch = RegExp(
          r'<\s*([a-zA-Z][a-zA-Z0-9-]*)',
        ).firstMatch(trimmed);
        final isOpeningTag =
            !trimmed.contains('/>') &&
            !_isVoidElement(trimmed) &&
            !trimmed.endsWith('/>');

        buffer.write(indentStr * indent);
        buffer.writeln(trimmed);

        // If it's an opening tag (not self-closing or void), increase indent for content
        if (isOpeningTag) {
          if (tagMatch != null) {
            tagStack.add(tagMatch.group(1)!.toLowerCase());
          }
          indent++;
        }
        continue;
      }

      // Regular content (indented one level from its parent tag)
      buffer.write(indentStr * indent);
      buffer.writeln(trimmed);
    }

    return buffer.toString().trim();
  }

  static bool _isVoidElement(String tag) {
    final voidElements = [
      'area',
      'base',
      'br',
      'col',
      'embed',
      'hr',
      'img',
      'input',
      'link',
      'meta',
      'param',
      'source',
      'track',
      'wbr',
    ];
    for (final element in voidElements) {
      if (tag.toLowerCase().contains('<$element') ||
          tag.toLowerCase().contains('<$element>')) {
        return true;
      }
    }
    return false;
  }

  /// Formats SQL code
  static String formatSql(String sql) {
    final buffer = StringBuffer();
    int indent = 0;
    final indentStr = '  ';

    // SQL keywords that increase indent
    final indentKeywords = [
      'SELECT',
      'FROM',
      'WHERE',
      'JOIN',
      'INNER JOIN',
      'LEFT JOIN',
      'RIGHT JOIN',
      'FULL JOIN',
      'GROUP BY',
      'ORDER BY',
      'HAVING',
      'UNION',
      'INSERT',
      'UPDATE',
      'DELETE',
      'CREATE',
      'ALTER',
      'CASE',
      'WHEN',
      'THEN',
      'ELSE',
      'END',
    ];

    // Keywords that decrease indent
    final outdentKeywords = ['END', 'ELSE'];

    final lines = sql.split('\n');
    for (final line in lines) {
      final trimmed = line.trim();
      if (trimmed.isEmpty) {
        buffer.writeln();
        continue;
      }

      final upper = trimmed.toUpperCase();

      // Check for outdent keywords
      for (final keyword in outdentKeywords) {
        if (upper.startsWith(keyword)) {
          indent = (indent - 1).clamp(0, double.infinity).toInt();
          break;
        }
      }

      buffer.write(indentStr * indent);
      buffer.writeln(trimmed);

      // Check for indent keywords
      for (final keyword in indentKeywords) {
        if (upper.contains(keyword) &&
            !upper.startsWith('END') &&
            !upper.startsWith('ELSE')) {
          indent++;
          break;
        }
      }
    }

    return buffer.toString().trim();
  }

  /// Formats Jinja template code
  static String formatJinja(String jinja) {
    final buffer = StringBuffer();
    int indent = 0;
    final indentStr = '  ';

    final lines = jinja.split('\n');

    for (final line in lines) {
      final trimmed = line.trim();
      if (trimmed.isEmpty) {
        buffer.writeln();
        continue;
      }

      // Check for Jinja closing tags
      if (trimmed.startsWith('{% end')) {
        indent = (indent - 1).clamp(0, double.infinity).toInt();
        buffer.write(indentStr * indent);
        buffer.writeln(trimmed);
        continue;
      }

      // Check for Jinja opening tags that need indentation
      if (trimmed.startsWith('{%')) {
        final tagMatch = RegExp(r'\{%\s*(\w+)').firstMatch(trimmed);
        if (tagMatch != null) {
          final tagName = tagMatch.group(1)?.toLowerCase();
          final foldableTags = [
            'if',
            'for',
            'block',
            'macro',
            'filter',
            'with',
            'set',
            'call',
            'raw',
          ];

          if (tagName != null && foldableTags.contains(tagName)) {
            buffer.write(indentStr * indent);
            buffer.writeln(trimmed);
            indent++;
            continue;
          }
        }
        buffer.write(indentStr * indent);
        buffer.writeln(trimmed);
        continue;
      }

      // Regular content
      buffer.write(indentStr * indent);
      buffer.writeln(trimmed);
    }

    return buffer.toString().trim();
  }
}
