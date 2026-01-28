/// Tag completion provider for HTML and Jinja languages.
///
/// Provides intelligent tag completion suggestions when the cursor is within
/// an opening tag (`<tag>`) or closing tag (`</tag>`).
library;

import 'package:code_forge/code_forge/suggestion_model.dart';

/// Represents the context of a tag completion request.
class TagContext {
  /// Whether the cursor is within a tag context.
  final bool isInTag;

  /// Whether this is a closing tag context (`</tag>` or `{% endtag %}`).
  final bool isClosingTag;

  /// Whether this is a Jinja tag (`{% %}`) vs HTML tag (`<>`).
  final bool isJinjaTag;

  /// The prefix text before the cursor within the tag.
  final String prefix;

  /// The start position of the tag opening bracket.
  final int tagStart;

  /// The end position of the tag closing bracket (if found).
  final int? tagEnd;

  TagContext({
    required this.isInTag,
    this.isClosingTag = false,
    this.isJinjaTag = false,
    this.prefix = '',
    this.tagStart = -1,
    this.tagEnd,
  });
}

/// Provides tag completion for HTML and Jinja templates.
class TagCompletion {
  /// Common HTML tags
  static const List<String> htmlTags = [
    'div',
    'span',
    'p',
    'a',
    'img',
    'input',
    'button',
    'form',
    'label',
    'select',
    'option',
    'textarea',
    'h1',
    'h2',
    'h3',
    'h4',
    'h5',
    'h6',
    'ul',
    'ol',
    'li',
    'table',
    'tr',
    'td',
    'th',
    'thead',
    'tbody',
    'tfoot',
    'header',
    'footer',
    'nav',
    'section',
    'article',
    'aside',
    'main',
    'script',
    'style',
    'link',
    'meta',
    'title',
    'head',
    'body',
    'html',
    'br',
    'hr',
    'strong',
    'em',
    'b',
    'i',
    'u',
    'code',
    'pre',
    'blockquote',
    'iframe',
    'video',
    'audio',
    'canvas',
    'svg',
    'path',
    'circle',
    'rect',
    'line',
    'polyline',
    'polygon',
    'g',
    'defs',
    'use',
    'text',
    'tspan',
  ];

  /// Map of HTML tag names to their templates
  /// Templates include the closing tag and placeholder variables
  static const Map<String, String> htmlTagTemplates = <String, String>{
    'p': 'p>VARIABLE_1</p>',
    'h1': 'h1>VARIABLE_1</h1>',
    'h2': 'h2>VARIABLE_1</h2>',
    'h3': 'h3>VARIABLE_1</h3>',
    'h4': 'h4>VARIABLE_1</h4>',
    'h5': 'h5>VARIABLE_1</h5>',
    'h6': 'h6>VARIABLE_1</h6>',
    'a': 'a href="VARIABLE_1">VARIABLE_1</a>',
    'img':
        'img src="VARIABLE_1" alt="VARIABLE_1" width="VARIABLE_2" height="VARIABLE_3">',
    'ul': 'ul>\n<VARIABLE_1>\n</ul>',
    'li': 'li>VARIABLE_1</li>',
    'ol': 'ol>\n<VARIABLE_1>\n</ol>',
    'table': 'table>\n<VARIABLE_1>\n</table>',
    'tr': 'tr>\n<VARIABLE_1>\n</tr>',
    'th': 'th>VARIABLE_1</th>',
    'td': 'td>VARIABLE_1</td>',
    'br': 'br>',
    'hr': 'hr>',
    'div': 'div>VARIABLE_1</div>',
    'span': 'span>VARIABLE_1</span>',
    'b': 'b>VARIABLE_1</b>',
    'i': 'i>VARIABLE_1</i>',
    'em': 'em>VARIABLE_1</em>',
    'strong': 'strong>VARIABLE_1</strong>',
    'code': 'code>VARIABLE_1</code>',
    'pre': 'pre>VARIABLE_1</pre>',
    'blockquote': 'blockquote>\n<VARIABLE_1>\n</blockquote>',
    's': 's>VARIABLE_1</s>',
    'sub': 'sub>VARIABLE_1</sub>',
    'sup': 'sup>VARIABLE_1</sup>',
    'del': 'del>VARIABLE_1</del>',
    'mark': 'mark>VARIABLE_1</mark>',
    'small': 'small>VARIABLE_1</small>',
    'big': 'big>VARIABLE_1</big>',
    'tt': 'tt>VARIABLE_1</tt>',
    'header': 'header>\n<VARIABLE_1>\n</header>',
    'footer': 'footer>\n<VARIABLE_1>\n</footer>',
    'nav': 'nav>\n<VARIABLE_1>\n</nav>',
    'main': 'main>\n<VARIABLE_1>\n</main>',
    'section': 'section>\n<VARIABLE_1>\n</section>',
    'article': 'article>\n<VARIABLE_1>\n</article>',
    'aside': 'aside>\n<VARIABLE_1>\n</aside>',
    'details':
        'details>\n<summary>VARIABLE_1</summary>\n<VARIABLE_2>\n</details>',
    'figure':
        'figure>\n<VARIABLE_1>\n<figcaption>VARIABLE_2</figcaption>\n</figure>',
    'form':
        'form action="VARIABLE_1" method="VARIABLE_2">\n<VARIABLE_3>\n</form>',
    'input':
        'input type="VARIABLE_1" name="VARIABLE_2" placeholder="VARIABLE_3">',
    'textarea':
        'textarea name="VARIABLE_1" rows="VARIABLE_2" cols="VARIABLE_3">VARIABLE_4</textarea>',
    'button': 'button type="VARIABLE_1">VARIABLE_2</button>',
    'select': 'select name="VARIABLE_1">\n<VARIABLE_2>\n</select>',
    'option': 'option value="VARIABLE_1">VARIABLE_2</option>',
    'label': 'label for="VARIABLE_1">VARIABLE_2</label>',
    'fieldset':
        'fieldset>\n<legend>VARIABLE_1</legend>\n<VARIABLE_2>\n</fieldset>',
    'datalist': 'datalist id="VARIABLE_1">\n<VARIABLE_2>\n</datalist>',
    'output': 'output name="VARIABLE_1">VARIABLE_2</output>',
    'audio':
        'audio controls>\n<source src="VARIABLE_1" type="VARIABLE_2">\nVARIABLE_3\n</audio>',
    'video':
        'video width="VARIABLE_1" height="VARIABLE_2" controls>\n<source src="VARIABLE_3" type="VARIABLE_4">\nVARIABLE_5\n</video>',
    'source': 'source src="VARIABLE_1" type="VARIABLE_2">',
    'track':
        'track src="VARIABLE_1" kind="VARIABLE_2" srclang="VARIABLE_3" label="VARIABLE_4">',
    'picture':
        'picture>\n<source media="(min-width: VW)" srcset="VARIABLE_1">\n<img src="VARIABLE_2" alt="VARIABLE_3">\n</picture>',
    'svg': 'svg width="VARIABLE_1" height="VARIABLE_2">\n<VARIABLE_3>\n</svg>',
    'canvas':
        'canvas id="VARIABLE_1" width="VARIABLE_2" height="VARIABLE_3"></canvas>',
    'dialog': 'dialog open>\nVARIABLE_1\n</dialog>',
    'menu': 'menu>\n<VARIABLE_1>\n</menu>',
    'menuitem': 'menuitem>VARIABLE_1</menuitem>',
    'progress': 'progress value="VARIABLE_1" max="VARIABLE_2"></progress>',
    'meter':
        'meter value="VARIABLE_1" min="VARIABLE_2" max="VARIABLE_3">VARIABLE_4</meter>',
    'cite': 'cite>VARIABLE_1</cite>',
    'q': 'q>VARIABLE_1</q>',
    'dfn': 'dfn>VARIABLE_1</dfn>',
    'abbr': 'abbr title="VARIABLE_1">VARIABLE_2</abbr>',
    'time': 'time datetime="VARIABLE_1">VARIABLE_2</time>',
    'var': 'var>VARIABLE_1</var>',
    'samp': 'samp>VARIABLE_1</samp>',
    'kbd': 'kbd>VARIABLE_1</kbd>',
    'data': 'data value="VARIABLE_1">VARIABLE_2</data>',
    'ruby': 'ruby>VARIABLE_1 <rt>VARIABLE_2</rt></ruby>',
    'rt': 'rt>VARIABLE_1</rt>',
    'rp': 'rp>VARIABLE_1</rp>',
    'bdi': 'bdi>VARIABLE_1</bdi>',
    'bdo': 'bdo dir="VARIABLE_1">VARIABLE_2</bdo>',
    'iframe':
        'iframe src="VARIABLE_1" width="VARIABLE_2" height="VARIABLE_3"></iframe>',
    'embed': 'embed src="VARIABLE_1" width="VARIABLE_2" height="VARIABLE_3">',
    'object':
        'object data="VARIABLE_1" width="VARIABLE_2" height="VARIABLE_3"></object>',
    'param': 'param name="VARIABLE_1" value="VARIABLE_2">',
    'template': 'template>\n<VARIABLE_1>\n</template>',
    'slot': 'slot name="VARIABLE_1"></slot>',
    'noscript': 'noscript>VARIABLE_1</noscript>',
    'thead': 'thead>\n<VARIABLE_1>\n</thead>',
    'tbody': 'tbody>\n<VARIABLE_1>\n</tbody>',
    'tfoot': 'tfoot>\n<VARIABLE_1>\n</tfoot>',
    'script': 'script>\nVARIABLE_1\n</script>',
    'style': 'style>\nVARIABLE_1\n</style>',
    'link': 'link rel="VARIABLE_1" href="VARIABLE_2">',
    'meta': 'meta name="VARIABLE_1" content="VARIABLE_2">',
    'title': 'title>VARIABLE_1</title>',
    'head': 'head>\n<VARIABLE_1>\n</head>',
    'body': 'body>\n<VARIABLE_1>\n</body>',
    'html': 'html>\n<VARIABLE_1>\n</html>',
    'path': 'path d="VARIABLE_1"></path>',
    'circle': 'circle cx="VARIABLE_1" cy="VARIABLE_2" r="VARIABLE_3"></circle>',
    'rect':
        'rect x="VARIABLE_1" y="VARIABLE_2" width="VARIABLE_3" height="VARIABLE_4"></rect>',
    'line':
        'line x1="VARIABLE_1" y1="VARIABLE_2" x2="VARIABLE_3" y2="VARIABLE_4"></line>',
    'polyline': 'polyline points="VARIABLE_1"></polyline>',
    'polygon': 'polygon points="VARIABLE_1"></polygon>',
    'g': 'g>\n<VARIABLE_1>\n</g>',
    'defs': 'defs>\n<VARIABLE_1>\n</defs>',
    'use': 'use href="VARIABLE_1"></use>',
    'text': 'text x="VARIABLE_1" y="VARIABLE_2">VARIABLE_3</text>',
    'tspan': 'tspan>VARIABLE_1</tspan>',
  };

  /// Common Jinja2 tags
  static const List<String> jinjaTags = [
    'if',
    'elif',
    'else',
    'endif',
    'for',
    'endfor',
    'while',
    'endwhile',
    'macro',
    'endmacro',
    'call',
    'endcall',
    'filter',
    'endfilter',
    'set',
    'endset',
    'block',
    'endblock',
    'extends',
    'include',
    'import',
    'from',
    'with',
    'endwith',
    'autoescape',
    'endautoescape',
    'raw',
    'endraw',
    'verbatim',
    'endverbatim',
    'trans',
    'endtrans',
  ];

  /// Map of Jinja tag names to their templates
  /// Templates use Jinja syntax: {% tag %}...{% endtag %}
  static const Map<String, String> jinjaTagTemplates = <String, String>{
    'if': 'if VARIABLE_1 %}VARIABLE_2{% endif %}',
    'elif': 'elif VARIABLE_1 %}VARIABLE_2',
    'else': 'else %}VARIABLE_1',
    'endif': 'endif %}',
    'for': 'for VARIABLE_1 in VARIABLE_2 %}VARIABLE_3{% endfor %}',
    'endfor': 'endfor %}',
    'while': 'while VARIABLE_1 %}VARIABLE_2{% endwhile %}',
    'endwhile': 'endwhile %}',
    'macro': 'macro VARIABLE_1(VARIABLE_2) %}VARIABLE_3{% endmacro %}',
    'endmacro': 'endmacro %}',
    'call': 'call VARIABLE_1(VARIABLE_2) %}VARIABLE_3{% endcall %}',
    'endcall': 'endcall %}',
    'filter': 'filter VARIABLE_1 %}VARIABLE_2{% endfilter %}',
    'endfilter': 'endfilter %}',
    'set': 'set VARIABLE_1 = VARIABLE_2 %}',
    'endset': 'endset %}',
    'block': 'block VARIABLE_1 %}VARIABLE_2{% endblock %}',
    'endblock': 'endblock %}',
    'extends': 'extends "VARIABLE_1" %}',
    'include': 'include "VARIABLE_1" %}',
    'import': 'import "VARIABLE_1" as VARIABLE_2 %}',
    'from': 'from VARIABLE_1 import VARIABLE_2 %}',
    'with': 'with VARIABLE_1 %}VARIABLE_2{% endwith %}',
    'endwith': 'endwith %}',
    'autoescape': 'autoescape VARIABLE_1 %}VARIABLE_2{% endautoescape %}',
    'endautoescape': 'endautoescape %}',
    'raw': 'raw %}VARIABLE_1{% endraw %}',
    'endraw': 'endraw %}',
    'verbatim': 'verbatim %}VARIABLE_1{% endverbatim %}',
    'endverbatim': 'endverbatim %}',
    'trans': 'trans %}VARIABLE_1{% endtrans %}',
    'endtrans': 'endtrans %}',
  };

  /// Analyzes the text around the cursor position to determine if we're in a tag context.
  ///
  /// Supports both HTML tags (`<tag>`) and Jinja tags (`{% tag %}`).
  /// Returns a [TagContext] object with information about the tag context.
  static TagContext analyzeTagContext(String text, int cursorPosition) {
    if (cursorPosition < 0 || cursorPosition > text.length) {
      return TagContext(isInTag: false);
    }

    // First, try to detect Jinja tags {% %}
    final jinjaContext = _analyzeJinjaTagContext(text, cursorPosition);
    if (jinjaContext.isInTag) {
      return jinjaContext;
    }

    // Then try HTML tags <>
    final htmlContext = _analyzeHtmlTagContext(text, cursorPosition);
    return htmlContext;
  }

  /// Analyzes Jinja tag context (`{% tag %}`).
  static TagContext _analyzeJinjaTagContext(String text, int cursorPosition) {
    int pos = cursorPosition - 1;
    bool foundOpeningTag = false;
    int tagStart = -1;
    bool isClosingTag = false;

    // Look backwards for '{%' first
    // This handles cases like '{%%}' where we need to detect we're inside a tag
    int searchPos = pos;
    while (searchPos >= 0) {
      if (searchPos + 1 < text.length) {
        final twoChars = text.substring(searchPos, searchPos + 2);
        if (twoChars == '{%') {
          tagStart = searchPos;
          foundOpeningTag = true;
          // Check if it's a closing tag (look for 'end' after '{%')
          if (searchPos + 2 < text.length) {
            final afterOpen = text
                .substring(searchPos + 2, (searchPos + 7).clamp(0, text.length))
                .trim();
            if (afterOpen.toLowerCase().startsWith('end')) {
              isClosingTag = true;
            }
          }
          break;
        }
        // Don't stop at '%}' - continue looking backwards for '{%'
        // We might be in a case like '{%%}' where we need to find the opening
      }
      searchPos--;
    }

    // If we didn't find an opening tag, check if we're right after a closing '%}'
    if (!foundOpeningTag && pos >= 0 && pos + 1 < text.length) {
      final twoChars = text.substring(pos, pos + 2);
      if (twoChars == '%}') {
        return TagContext(isInTag: false);
      }
    }

    if (!foundOpeningTag) {
      return TagContext(isInTag: false);
    }

    // Look forwards from tagStart to find the closing delimiter '%}'
    int? tagEnd;
    int searchStart = tagStart + 2;
    for (
      int i = searchStart;
      i < text.length && i < cursorPosition + 100;
      i++
    ) {
      if (i + 1 < text.length) {
        final twoChars = text.substring(i, i + 2);
        if (twoChars == '%}') {
          tagEnd = i + 1;
          break;
        }
        if (twoChars == '{%') {
          // Found another opening tag before closing this one
          break;
        }
      }
    }

    // Extract prefix (text between '{%' and cursor)
    // Skip any extra '%' characters after '{%' (handles '{%%}' case)
    final prefixStart = tagStart + 2;
    final prefixEnd = cursorPosition.clamp(prefixStart, text.length);
    String prefix = '';
    if (prefixEnd > prefixStart) {
      prefix = text.substring(prefixStart, prefixEnd).trim();
      // Remove leading '%' characters (handles '{%%}' -> prefix should be empty, not '%')
      prefix = prefix.replaceFirst(RegExp(r'^%+'), '');
    }

    // Check if cursor is actually within the tag bounds
    final isInTag = tagEnd == null || cursorPosition <= tagEnd;

    return TagContext(
      isInTag: isInTag && foundOpeningTag,
      isClosingTag: isClosingTag,
      isJinjaTag: true,
      prefix: prefix,
      tagStart: tagStart,
      tagEnd: tagEnd,
    );
  }

  /// Analyzes HTML tag context (`<tag>`).
  static TagContext _analyzeHtmlTagContext(String text, int cursorPosition) {
    int pos = cursorPosition - 1;
    bool foundOpeningBracket = false;
    int tagStart = -1;
    bool isClosingTag = false;

    // First, check if we're right after a closing bracket (not in a tag)
    if (pos >= 0 && text[pos] == '>') {
      return TagContext(isInTag: false);
    }

    // Look backwards for '<' or '</'
    while (pos >= 0) {
      final char = text[pos];
      if (char == '>') {
        // Found a closing bracket before opening bracket, not in a tag
        return TagContext(isInTag: false);
      }
      if (char == '<') {
        tagStart = pos;
        foundOpeningBracket = true;
        // Check if it's a closing tag
        if (pos + 1 < text.length && text[pos + 1] == '/') {
          isClosingTag = true;
        }
        break;
      }
      pos--;
    }

    if (!foundOpeningBracket) {
      return TagContext(isInTag: false);
    }

    // Look forwards from tagStart to find the closing bracket or space/attributes
    int? tagEnd;
    int? spaceAfterTagName;
    int searchStart = isClosingTag ? tagStart + 2 : tagStart + 1;
    for (
      int i = searchStart;
      i < text.length && i < cursorPosition + 100;
      i++
    ) {
      final char = text[i];
      if (char == '>') {
        tagEnd = i;
        break;
      }
      // If we find a space before the cursor, we might be in attributes
      if ((char == ' ' || char == '\n' || char == '\t') &&
          spaceAfterTagName == null) {
        spaceAfterTagName = i;
      }
    }

    // Extract prefix (text between tagStart and cursor, but only up to first space)
    final prefixStart = isClosingTag ? tagStart + 2 : tagStart + 1;
    final prefixEnd = cursorPosition.clamp(prefixStart, text.length);
    String prefix = '';

    // Only extract prefix if we haven't hit a space (attributes) yet
    if (prefixEnd > prefixStart) {
      final textToExtract = text.substring(prefixStart, prefixEnd);
      // Stop at first space or attribute start
      final spaceIndex = textToExtract.indexOf(' ');
      if (spaceIndex != -1 && cursorPosition <= prefixStart + spaceIndex) {
        prefix = textToExtract.substring(0, spaceIndex).trim();
      } else {
        prefix = textToExtract.trim();
      }
    }

    // Check if cursor is actually within the tag name bounds (before attributes)
    // If we've passed a space and are in attributes, don't show tag suggestions
    final isInTagName = tagEnd == null || cursorPosition <= tagEnd;
    final isInAttributes =
        spaceAfterTagName != null &&
        cursorPosition > spaceAfterTagName &&
        (tagEnd == null || cursorPosition < tagEnd);

    final isInTag = isInTagName && !isInAttributes;

    return TagContext(
      isInTag: isInTag && foundOpeningBracket,
      isClosingTag: isClosingTag,
      prefix: prefix,
      tagStart: tagStart,
      tagEnd: tagEnd,
    );
  }

  /// Gets tag completion suggestions based on the context and language.
  ///
  /// [text] is the full document text.
  /// [cursorPosition] is the current cursor position.
  /// [language] is the language name ('html' or 'jinja').
  /// [registeredSuggestions] is the list of registered custom suggestions from the controller.
  ///
  /// Returns a list of tag suggestions (SuggestionModel) matching the prefix with descriptions.
  /// When inside `{% %}`, only Jinja tags are shown.
  /// When inside `<>`, only HTML tags are shown.
  static List<SuggestionModel> getTagSuggestions(
    String text,
    int cursorPosition,
    String? language, {
    List<SuggestionModel>? registeredSuggestions,
  }) {
    final context = analyzeTagContext(text, cursorPosition);

    if (!context.isInTag) {
      return [];
    }

    // Determine which suggestions to use based on tag context
    List<SuggestionModel> availableSuggestions = [];

    if (registeredSuggestions != null && registeredSuggestions.isNotEmpty) {
      // Use registered suggestions directly to preserve descriptions
      if (context.isJinjaTag) {
        // Inside {% %} - filter Jinja suggestions triggered at '{%'
        availableSuggestions = List<SuggestionModel>.from(
          registeredSuggestions.where((s) => s.triggeredAt == '{%'),
        );
      } else {
        // Inside <> - filter HTML suggestions triggered at '<'
        availableSuggestions = List<SuggestionModel>.from(
          registeredSuggestions.where((s) => s.triggeredAt == '<'),
        );

        // If the base language is Jinja, also include Jinja tags
        if (language?.toLowerCase() == 'jinja' ||
            language?.toLowerCase() == 'jinja2') {
          final jinjaSuggestions = List<SuggestionModel>.from(
            registeredSuggestions.where((s) => s.triggeredAt == '{%'),
          );
          availableSuggestions.addAll(jinjaSuggestions);
        }
      }
    } else {
      // Fallback to static lists - create SuggestionModel objects from tag names
      List<String> availableTags = [];
      if (context.isJinjaTag) {
        availableTags = List.from(jinjaTags);
      } else {
        availableTags = List.from(htmlTags);
        if (language?.toLowerCase() == 'jinja' ||
            language?.toLowerCase() == 'jinja2') {
          availableTags.addAll(jinjaTags);
        }
      }

      // Convert tag names to SuggestionModel objects
      availableSuggestions = availableTags.map((tag) {
        final isJinja = context.isJinjaTag || jinjaTags.contains(tag);
        final template = getTagTemplate(tag, false, isJinjaTag: isJinja);
        String replacedOnClick;
        if (template != null) {
          final processedTemplate = processTagTemplate(template);
          replacedOnClick = isJinja
              ? '{% $processedTemplate'
              : '<$processedTemplate';
        } else {
          replacedOnClick = isJinja ? '{% $tag %}' : '<$tag></$tag>';
        }

        return SuggestionModel(
          label: tag,
          description: 'Insert a $tag ${isJinja ? 'Jinja' : 'HTML'} tag',
          replacedOnClick: replacedOnClick,
          triggeredAt: isJinja ? '{%' : '<',
        );
      }).toList();
    }

    // Filter by prefix if present (match against extracted tag name)
    if (context.prefix.isNotEmpty) {
      final lowerPrefix = context.prefix.toLowerCase();
      availableSuggestions = availableSuggestions.where((suggestion) {
        final tagName = _extractTagNameFromSuggestion(
          suggestion,
          isJinja: context.isJinjaTag,
        );
        return tagName.toLowerCase().startsWith(lowerPrefix);
      }).toList();
    }

    // Sort suggestions (exact prefix matches first, then alphabetical by tag name)
    availableSuggestions.sort((a, b) {
      final aTagName = _extractTagNameFromSuggestion(
        a,
        isJinja: context.isJinjaTag,
      );
      final bTagName = _extractTagNameFromSuggestion(
        b,
        isJinja: context.isJinjaTag,
      );
      final aLower = aTagName.toLowerCase();
      final bLower = bTagName.toLowerCase();
      final prefixLower = context.prefix.toLowerCase();

      // Exact prefix match gets priority
      if (aLower.startsWith(prefixLower) && !bLower.startsWith(prefixLower)) {
        return -1;
      }
      if (!aLower.startsWith(prefixLower) && bLower.startsWith(prefixLower)) {
        return 1;
      }

      return aTagName.compareTo(bTagName);
    });

    return availableSuggestions;
  }

  /// Extracts tag name from a suggestion's replacedOnClick content.
  ///
  /// For HTML tags, extracts from patterns like "<div>", "<span>", etc.
  /// For Jinja tags, extracts from patterns like "{% if %}", "{% for %}", etc.
  static String _extractTagNameFromSuggestion(
    SuggestionModel suggestion, {
    required bool isJinja,
  }) {
    final content = suggestion.replacedOnClick;

    if (isJinja) {
      // Extract from patterns like "{% if condition %}", "{% for item %}", etc.
      final jinjaPattern = RegExp(r'{%\s*(\w+)');
      final match = jinjaPattern.firstMatch(content);
      if (match != null && match.groupCount >= 1) {
        return match.group(1) ?? '';
      }
      return '';
    } else {
      // Extract from patterns like "<div>", "<span>", "<a href="">", etc.
      final htmlPattern = RegExp(r'<(\w+)');
      final match = htmlPattern.firstMatch(content);
      if (match != null && match.groupCount >= 1) {
        return match.group(1) ?? '';
      }
      // Fallback: try to extract from label (capitalized tag name)
      return suggestion.label.toLowerCase();
    }
  }

  /// Checks if the current language supports tag completion.
  ///
  /// Returns true if the language is HTML or Jinja.
  /// Also returns true if [text] and [cursorPosition] are provided and
  /// a Jinja tag context is detected (allows Jinja autocomplete in any language).
  static bool supportsTagCompletion(
    String? language, {
    String? text,
    int? cursorPosition,
  }) {
    // If text and cursor are provided, check for Jinja tag context first
    // This allows Jinja autocomplete in any language when {%%} is detected
    if (text != null && cursorPosition != null) {
      final jinjaContext = _analyzeJinjaTagContext(text, cursorPosition);
      if (jinjaContext.isInTag) {
        return true; // Always allow Jinja tag completion regardless of language
      }
    }

    // Otherwise, check language support
    if (language == null) return false;
    final langLower = language.toLowerCase();
    return langLower == 'html' ||
        langLower == 'jinja' ||
        langLower == 'jinja2' ||
        langLower == 'django' ||
        langLower == 'twig';
  }

  /// Gets the template for a tag name.
  ///
  /// Returns the template string if available, or null if the tag doesn't have a template.
  /// For closing tags, returns just the tag name with closing syntax.
  /// [isJinjaTag] indicates if this is a Jinja tag ({% %}) vs HTML tag (<>).
  static String? getTagTemplate(
    String tagName,
    bool isClosingTag, {
    bool isJinjaTag = false,
  }) {
    if (isClosingTag) {
      // For closing tags, just return the tag name
      return tagName;
    }

    // Check Jinja templates first
    if (isJinjaTag && jinjaTagTemplates.containsKey(tagName)) {
      return jinjaTagTemplates[tagName];
    }

    // Check HTML templates
    if (htmlTagTemplates.containsKey(tagName)) {
      return htmlTagTemplates[tagName];
    }

    // Default template based on tag type
    if (isJinjaTag) {
      return '$tagName VARIABLE_1 %}';
    } else {
      return '$tagName>VARIABLE_1</$tagName>';
    }
  }

  /// Processes a tag template by replacing VARIABLE placeholders with empty strings.
  ///
  /// This prepares the template for insertion into the editor.
  static String processTagTemplate(String template) {
    // Replace <VARIABLE_N> patterns (entire tag) with empty string
    String processed = template.replaceAll(RegExp(r'<VARIABLE_\d+>'), '');

    // Replace standalone VARIABLE_N placeholders (not in tags) with empty strings
    processed = processed.replaceAll(RegExp(r'VARIABLE_\d+'), '');

    // Clean up any empty tags like <>
    processed = processed.replaceAll(RegExp(r'<>'), '');

    // Clean up multiple consecutive newlines (more than 2)
    processed = processed.replaceAll(RegExp(r'\n{3,}'), '\n\n');

    // Trim trailing newlines but keep structure
    return processed;
  }

  /// Gets the text to insert for a tag completion.
  ///
  /// [tagName] is the tag name.
  /// [isClosingTag] indicates if this is a closing tag.
  /// [context] is the tag context (optional, used to determine if we're in a tag).
  ///
  /// Returns the text to insert. For opening tags, this includes the full template.
  /// For closing tags, this is just the tag name.
  static String getInsertTextForTag(
    String tagName,
    bool isClosingTag, [
    TagContext? context,
  ]) {
    final isJinja = context?.isJinjaTag ?? false;

    if (isClosingTag || (context != null && context.isClosingTag)) {
      // For closing tags, just return the tag name
      return tagName;
    }

    // For opening tags, get the template
    final template = getTagTemplate(tagName, false, isJinjaTag: isJinja);
    if (template != null) {
      return processTagTemplate(template);
    }

    // Fallback: simple tag with closing
    if (isJinja) {
      return '$tagName %}';
    } else {
      return '$tagName></$tagName>';
    }
  }
}
