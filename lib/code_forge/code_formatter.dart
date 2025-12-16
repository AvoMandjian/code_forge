import 'dart:convert';

/// Code formatter utilities for various languages
class CodeFormatter {
  /// Formats code based on the language type
  ///
  /// [rulerColumn] is an optional column position (e.g., from editor rulers)
  /// that determines when to keep tags on the same line in HTML formatting.
  ///
  /// Returns the formatted code, or null if formatting is not supported
  static String? formatCode(
    String code,
    String? languageName, {
    int? rulerColumn,
  }) {
    if (languageName == null) return null;

    final langLower = languageName.toLowerCase();

    if (langLower == 'json' || langLower.contains('json')) {
      return formatJson(code);
    } else if (langLower == 'html' ||
        langLower == 'xml' ||
        langLower.contains('html') ||
        langLower.contains('xml')) {
      return formatHtml(code, rulerColumn: rulerColumn);
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
  ///
  /// [rulerColumn] is an optional column position. If provided and tags on the
  /// same line are within this column limit, they will not be split.
  static String formatHtml(String html, {int? rulerColumn}) {
    final buffer = StringBuffer();
    int indent = 0;
    final indentStr = '  ';
    final lines = html.split('\n');

    for (final line in lines) {
      final trimmed = line.trim();
      if (trimmed.isEmpty) {
        buffer.writeln();
        continue;
      }

      // Process all tag pairs on the line, not just the first one
      String remaining = trimmed;
      bool processedAnyTag = false;

      while (remaining.isNotEmpty) {
        // Find the first tag pair match
        final tagPairMatch = RegExp(
          r'<([a-zA-Z][a-zA-Z0-9-]*)([^>]*)>(.*?)</([a-zA-Z][a-zA-Z0-9-]*)>',
          dotAll: true,
        ).firstMatch(remaining);

        if (tagPairMatch != null) {
          final matchStart = tagPairMatch.start;
          final matchEnd = tagPairMatch.end;
          final openingTagName = tagPairMatch.group(1)!;
          final openingAttributes = tagPairMatch.group(2) ?? '';
          final content = tagPairMatch.group(3)!;
          final closingTagName = tagPairMatch.group(4)!;

          // Only process if tags match and it's not a void element
          if (openingTagName.toLowerCase() == closingTagName.toLowerCase() &&
              !_isVoidElement('<$openingTagName>')) {
            // Write any content before this tag pair
            if (matchStart > 0) {
              final beforeContent = remaining.substring(0, matchStart).trim();
              if (beforeContent.isNotEmpty) {
                buffer.write(indentStr * indent);
                buffer.writeln(beforeContent);
              }
            }

            // Calculate the tag pair length with current indentation
            final currentIndentLength = indentStr.length * indent;
            final tagPairText = remaining.substring(matchStart, matchEnd);
            final fullLineLength = currentIndentLength + tagPairText.length;

            // If ruler is set and tag pair is within ruler limit, keep on same line
            if (rulerColumn != null && fullLineLength <= rulerColumn) {
              buffer.write(indentStr * indent);
              buffer.writeln(tagPairText);
              remaining = remaining.substring(matchEnd).trim();
              processedAnyTag = true;
              continue;
            }

            // Check if content contains nested tags - if so, recursively format it
            final hasNestedTags = RegExp(
              r'<[^>]+>.*</[^>]+>',
              dotAll: true,
            ).hasMatch(content);

            if (hasNestedTags) {
              // Recursively format nested content
              final formattedContent = formatHtml(
                content,
                rulerColumn: rulerColumn,
              );
              final contentLines = formattedContent.split('\n');

              // Write opening tag
              buffer.write(indentStr * indent);
              if (openingAttributes.trim().isNotEmpty) {
                buffer.writeln('<$openingTagName$openingAttributes>');
              } else {
                buffer.writeln('<$openingTagName>');
              }

              // Write formatted content with proper indentation
              for (final contentLine in contentLines) {
                if (contentLine.trim().isNotEmpty) {
                  buffer.write(indentStr * (indent + 1));
                  buffer.writeln(contentLine.trim());
                }
              }

              // Write closing tag
              buffer.write(indentStr * indent);
              buffer.writeln('</$closingTagName>');
            } else {
              // Simple content - write opening tag, content, closing tag
              buffer.write(indentStr * indent);
              if (openingAttributes.trim().isNotEmpty) {
                buffer.writeln('<$openingTagName$openingAttributes>');
              } else {
                buffer.writeln('<$openingTagName>');
              }

              // Write content (if any) with indentation
              if (content.trim().isNotEmpty) {
                buffer.write(indentStr * (indent + 1));
                buffer.writeln(content.trim());
              }

              // Write closing tag
              buffer.write(indentStr * indent);
              buffer.writeln('</$closingTagName>');
            }

            remaining = remaining.substring(matchEnd).trim();
            processedAnyTag = true;
          } else {
            // Tags don't match or it's a void element, skip this match
            // Move past the opening tag to avoid infinite loop
            final nextOpenTag = remaining.indexOf('<', matchStart + 1);
            if (nextOpenTag > matchStart) {
              remaining = remaining.substring(nextOpenTag).trim();
            } else {
              break;
            }
          }
        } else {
          // No more tag pairs found, write remaining content
          if (remaining.trim().isNotEmpty) {
            buffer.write(indentStr * indent);
            buffer.writeln(remaining.trim());
          }
          break;
        }
      }

      // If we processed any tags, continue to next line
      if (processedAnyTag) {
        continue;
      }

      // Check for closing tags first
      if (trimmed.startsWith('</')) {
        // Decrease indent BEFORE writing so closing tag aligns with its opening tag
        if (indent > 0) {
          indent--;
        }
        buffer.write(indentStr * indent);
        buffer.writeln(trimmed);
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
        final isOpeningTag =
            !trimmed.contains('/>') &&
            !_isVoidElement(trimmed) &&
            !trimmed.endsWith('/>');

        // Write opening tag at current indent level
        buffer.write(indentStr * indent);
        buffer.writeln(trimmed);

        // If it's an opening tag (not self-closing or void), increase indent for content
        if (isOpeningTag) {
          // Increase indent AFTER writing the opening tag
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
