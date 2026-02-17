import 'package:code_forge/code_forge/suggestion_model.dart';

/// Returns JINJA template suggestions.
List<SuggestionModel> getJinjaSuggestions() {
  return [
    /// -------------------------------------------------------------------------
    /// Statements
    /// -------------------------------------------------------------------------
    SuggestionModelJinja(
      label: 'If Statement',
      description:
          '<h2><code>{% if %}</code> Conditional Block</h2>\n\n<p><strong>Conditional rendering</strong> based on a boolean expression.</p>\n\n<pre><code>{% if condition %}\n  <!-- Content when true -->\n{% endif %}</code></pre>\n\n<p><strong>Use cases:</strong> Conditional content display, feature flags, validation</p>',
      replacedOnClick: '{% if condition %}\n  \n{% endif %}',
      openingTag: '{%',
      closingTag: '%}',
    ),
    SuggestionModelJinja(
      label: 'If-Else',
      description:
          '<h2><code>{% if %}</code> with <code>{% else %}</code></h2>\n\n<p><strong>Two-way conditional</strong> with alternative content.</p>\n\n<pre><code>{% if condition %}\n  <!-- True case -->\n{% else %}\n  <!-- False case -->\n{% endif %}</code></pre>\n\n<p><strong>Use cases:</strong> Default fallbacks, user authentication states</p>',
      replacedOnClick: '{% if condition %}\n  \n{% else %}\n  \n{% endif %}',
      openingTag: '{%',
      closingTag: '%}',
    ),
    SuggestionModelJinja(
      label: 'If-Elif-Else',
      description:
          '<h2><code>{% if %}</code> Multi-Conditional</h2>\n\n<p><strong>Multiple conditions</strong> with elif chains.</p>\n\n<pre><code>{% if condition %}\n  <!-- First case -->\n{% elif other_condition %}\n  <!-- Second case -->\n{% else %}\n  <!-- Default case -->\n{% endif %}</code></pre>\n\n<p><strong>Use cases:</strong> Status handling, multi-state logic, priority checks</p>',
      replacedOnClick:
          '{% if condition %}\n  \n{% elif other_condition %}\n  \n{% else %}\n  \n{% endif %}',
      openingTag: '{%',
      closingTag: '%}',
    ),
    SuggestionModelJinja(
      label: 'For Loop',
      description:
          '<h2><code>{% for %}` Loop Block\n\n<strong>Iterate over</strong> a sequence or iterable.\n\n<pre><code>\n{% for item in items %}\n  {{ item }}\n{% endfor %}\n</code></pre>\n\n<strong>Loop variables:<strong> `loop.index`, `loop.index0`, `loop.first`, `loop.last`\n\n<strong>Use cases:<strong> Lists, tables, repeating content',
      replacedOnClick: '{% for item in items %}\n  \n{% endfor %}',
      openingTag: '{%',
      closingTag: '%}',
    ),
    SuggestionModelJinja(
      label: 'For Loop with Index',
      description:
          '<h2><code>{% for %}` with Index\n\n<strong>Loop with index<strong> counter for numbering.\n\n<pre><code>\n{% for item in items %}\n  {{ loop.index }}: {{ item }}\n{% endfor %}\n</code></pre>\n\n<strong>Index properties:<strong>\n- `loop.index` - <strong>1-based<strong> index\n- `loop.index0` - <strong>0-based<strong> index\n- `loop.first` - <strong>First iteration<strong>\n- `loop.last` - <strong>Last iteration<strong>\n\n<strong>Use cases:<strong> Numbered lists, table rows, pagination',
      replacedOnClick:
          '{% for item in items %}\n  {{ loop.index }}: {{ item }}\n{% endfor %}',
      openingTag: '{%',
      closingTag: '%}',
    ),
    SuggestionModelJinja(
      label: 'For Loop with Key-Value',
      description:
          '<h2><code>{% for %}` Dictionary Iteration\n\n<strong>Iterate over</strong> dictionary key-value pairs.\n\n<pre><code>\n{% for key, value in dict.items() %}\n  {{ key }}: {{ value }}\n{% endfor %}\n</code></pre>\n\n<strong>Dictionary methods:<strong>\n- `.items()` - <strong>Key-value pairs<strong>\n- `.keys()` - <strong>Keys only<strong>\n- `.values()` - <strong>Values only<strong>\n\n<strong>Use cases:<strong> Configuration display, metadata rendering',
      replacedOnClick:
          '{% for key, value in dict.items() %}\n  {{ key }}: {{ value }}\n{% endfor %}',
      openingTag: '{%',
      closingTag: '%}',
    ),
    SuggestionModelJinja(
      label: 'Block',
      description:
          '<h2><code>{% block %}` Template Block\n\n<strong>Define a block<strong> that can be overridden in child templates.\n\n<pre><code>\n{% block block_name %}\n  <!-- Default content -->\n{% endblock %}\n</code></pre>\n\n<strong>Use cases:<strong> Template inheritance, content sections, layout customization\n\n<strong>Best practice:<strong> Use descriptive block names like `content`, `sidebar`, `footer`',
      replacedOnClick: '{% block block_name %}\n  \n{% endblock %}',
      openingTag: '{%',
      closingTag: '%}',
    ),
    SuggestionModelJinja(
      label: 'Extends',
      description:
          '<h2><code>{% extends %}` Template Inheritance\n\n<strong>Inherit from<strong> a parent template.\n\n<pre><code>\n{% extends "base.html" %}\n</code></pre>\n\n<strong>Must be first tag<strong> in the template.\n\n<strong>Use cases:<strong> Base templates, consistent layouts, DRY principle\n\n<strong>Example:<strong> Child templates override parent blocks',
      replacedOnClick: '{% extends "base.html" %}',
      openingTag: '{%',
      closingTag: '%}',
    ),
    SuggestionModelJinja(
      label: 'Include',
      description:
          '<h2><code>{% include %}` Template Inclusion\n\n<strong>Include another template<strong> at this location.\n\n<pre><code>\n{% include "header.html" %}\n{% include "footer.html" %}\n</code></pre>\n\n<strong>With context:<strong>\n<pre><code>\n{% include "widget.html" with context %}\n</code></pre>\n\n<strong>Use cases:<strong> Reusable components, headers/footers, partials\n\n<strong>Note:<strong> Variables are passed from parent context',
      replacedOnClick: '{% include "template.html" %}',
      openingTag: '{%',
      closingTag: '%}',
    ),
    SuggestionModelJinja(
      label: 'Macro',
      description:
          '<h2><code>{% macro %}` Function Definition\n\n<strong>Define a reusable<strong> template function.\n\n<pre><code>\n{% macro macro_name(param) %}\n  <!-- Macro content -->\n  {{ param }}\n{% endmacro %}\n</code></pre>\n\n<strong>Calling macros:<strong>\n<pre><code>\n{{ macro_name("value") }}\n</code></pre>\n\n<strong>Use cases:<strong> Reusable UI components, form fields, buttons\n\n<strong>Benefits:<strong> DRY principle, consistent styling',
      replacedOnClick: '{% macro macro_name(param) %}\n  \n{% endmacro %}',
      openingTag: '{%',
      closingTag: '%}',
    ),
    SuggestionModelJinja(
      label: 'Call Macro',
      description:
          '<h2><code>{% call %}` Macro with Caller\n\n<strong>Call a macro<strong> and pass content via `caller()`.\n\n<pre><code>\n{% call macro_name(param) %}\n  <!-- Content passed to macro -->\n{% endcall %}\n</code></pre>\n\n<strong>In macro:<strong> Use `{{ caller() }}` to render passed content.\n\n<strong>Use cases:<strong> Wrapper macros, decorated content, flexible components',
      replacedOnClick: '{% call macro_name(param) %}\n  \n{% endcall %}',
      openingTag: '{%',
      closingTag: '%}',
    ),
    SuggestionModelJinja(
      label: 'Set Variable',
      description:
          '<h2><code>{% set %}` Variable Assignment\n\n<strong>Assign a value<strong> to a variable.\n\n<pre><code>\n{% set variable = value %}\n{% set name = "Jinja" %}\n{% set count = items|length %}\n</code></pre>\n\n<strong>Use cases:<strong> Computed values, temporary variables, simplifying expressions\n\n<strong>Scope:<strong> Variables are available in the current block',
      replacedOnClick: '{% set variable = value %}',
      openingTag: '{%',
      closingTag: '%}',
    ),

    SuggestionModelJinja(
      label: 'Comment',
      description:
          '<h2><code>{# #}` Template Comment\n\n<strong>Comment out<strong> template code (not rendered).\n\n<pre><code>\n{# Comment here #}\n{# Multi-line\n   comment #}\n</code></pre>\n\n<strong>Use cases:<strong> Documentation, debugging, temporary code removal\n\n<strong>Note:<strong> Comments are <strong>not included<strong> in rendered output',
      replacedOnClick: '{# Comment here #}',
      openingTag: '{#',
      closingTag: '#}',
    ),
    SuggestionModelJinja(
      label: 'With Statement',
      description:
          '<h2><code>{% with %}` Scoped Variables\n\n<strong>Create scoped variables<strong> for a block.\n\n<pre><code>\n{% with variable = value %}\n  {{ variable }}  <!-- Available here -->\n{% endwith %}\n<!-- variable not available here -->\n</code></pre>\n\n<strong>Multiple variables:<strong>\n<pre><code>\n{% with var1 = val1, var2 = val2 %}\n  <!-- Both available -->\n{% endwith %}\n</code></pre>\n\n<strong>Use cases:<strong> Temporary variables, scoped calculations, cleaner code',
      replacedOnClick: '{% with variable = value %}\n  \n{% endwith %}',
      openingTag: '{%',
      closingTag: '%}',
    ),
    SuggestionModelJinja(
      label: 'Raw Block',
      description:
          '<h2><code>{% raw %}` Unprocessed Block\n\n<strong>Output raw text<strong> without Jinja processing.\n\n<pre><code>\n{% raw %}\n  {{ This will be output as-is }}\n  {% tags are not processed %}\n{% endraw %}\n</code></pre>\n\n<strong>Use cases:<strong>\n- <strong>Documentation<strong> examples\n- <strong>JavaScript<strong> with curly braces\n- <strong>CSS<strong> with `{{ }}` syntax\n- <strong>Escaping<strong> Jinja syntax\n\n<strong>Security:<strong> Use carefully with user input',
      replacedOnClick: '{% raw %}\n  \n{% endraw %}',
      openingTag: '{%',
      closingTag: '%}',
    ),
    SuggestionModelJinja(
      label: 'Filter Block',
      description:
          '<h2><code>{% filter %}` Block Filtering\n\n<strong>Apply a filter<strong> to all content in a block.\n\n<pre><code>\n{% filter upper %}\n  This text will be uppercase\n{% endfilter %}\n</code></pre>\n\n<strong>Common uses:<strong>\n- `upper`, `lower` - <strong>Case conversion<strong>\n- `trim` - <strong>Whitespace removal<strong>\n- `striptags` - <strong>Remove HTML tags<strong>\n- `markdown` - <strong>Markdown rendering<strong>\n\n<strong>Use cases:<strong> Bulk text transformation, formatting entire sections',
      replacedOnClick: '{% filter filter_name %}\n  \n{% endfilter %}',
      openingTag: '{%',
      closingTag: '%}',
    ),
    SuggestionModelJinja(
      label: 'Test',
      description:
          '<h2><code>{% if %}` with Tests\n\n<strong>Conditional logic<strong> using test functions.\n\n<pre><code>\n{% if value is test_name %}\n  <!-- Content when test passes -->\n{% endif %}\n</code></pre>\n\n<strong>Common tests:<strong>\n- `is defined` - <strong>Variable exists<strong>\n- `is none` - <strong>Value is None<strong>\n- `is even`, `is odd` - <strong>Number parity<strong>\n- `is divisibleby(3)` - <strong>Divisibility<strong>\n- `is sameas(value)` - <strong>Identity check<strong>\n\n<strong>Use cases:<strong> Type checking, validation, conditional rendering',
      replacedOnClick: '{% if value is test_name %}\n  \n{% endif %}',
      openingTag: '{%',
      closingTag: '%}',
    ),
    SuggestionModelJinja(
      label: 'Import',
      description:
          '<h2><code>{% import %}` Macro Import\n\n<strong>Import macros<strong> from another template as a namespace.\n\n<pre><code>\n{% import "macros.html" as macros %}\n{{ macros.button("Click me") }}\n{{ macros.input("name", "text") }}\n</code></pre>\n\n<strong>Namespace benefits:<strong>\n- <strong>Avoid conflicts<strong> with local macros\n- <strong>Organized<strong> macro access\n- <strong>Reusable<strong> component library\n\n<strong>Use cases:<strong> Shared macro libraries, component systems',
      replacedOnClick: '{% import "macros.html" as macros %}',
      openingTag: '{%',
      closingTag: '%}',
    ),
    SuggestionModelJinja(
      label: 'From Import',
      description:
          '<h2><code>{% from %}` Selective Import\n\n<strong>Import specific macros<strong> directly into current namespace.\n\n<pre><code>\n{% from "macros.html" import button, input %}\n{{ button("Click me") }}\n{{ input("name", "text") }}\n</code></pre>\n\n<strong>Multiple imports:<strong>\n<pre><code>\n{% from "macros.html" import macro1, macro2, macro3 %}\n</code></pre>\n\n<strong>Use cases:<strong> Selective imports, avoiding namespace prefixes\n\n<strong>Note:<strong> Can cause name conflicts if macros share names',
      replacedOnClick: '{% from "macros.html" import macro_name %}',
      openingTag: '{%',
      closingTag: '%}',
    ),
    SuggestionModelJinja(
      label: 'Do Statement',
      description:
          '<h2><code>{% do %}` Side Effect Execution\n\n<strong>Execute code<strong> without producing output.\n\n<pre><code>\n{% do dict.update({"key": "value"}) %}\n{% do list.append(item) %}\n{% do set.add(value) %}\n</code></pre>\n\n<strong>Use cases:<strong>\n- <strong>Modifying<strong> data structures\n- <strong>Calling<strong> methods with side effects\n- <strong>Updating<strong> mutable objects\n\n<strong>Note:<strong> Requires `do` extension to be enabled',
      replacedOnClick: '{% do dict.update({"key": "value"}) %}',
      openingTag: '{%',
      closingTag: '%}',
    ),
    SuggestionModelJinja(
      label: 'Break',
      description:
          '<h2><code>{% break %}` Loop Exit\n\n<strong>Exit a loop<strong> early when condition is met.\n\n<pre><code>\n{% for item in items %}\n  {% if item == target %}\n    {% break %}\n  {% endif %}\n  {{ item }}\n{% endfor %}\n</code></pre>\n\n<strong>Use cases:<strong>\n- <strong>Early termination<strong> when found\n- <strong>Performance<strong> optimization\n- <strong>Conditional<strong> loop exit\n\n<strong>Note:<strong> Only works inside `{% for %}` loops',
      replacedOnClick: '{% break %}',
      openingTag: '{%',
      closingTag: '%}',
    ),
    SuggestionModelJinja(
      label: 'Continue',
      description:
          '<h2><code>{% continue %}` Skip Iteration\n\n<strong>Skip to next<strong> loop iteration.\n\n<pre><code>\n{% for item in items %}\n  {% if item.skip %}\n    {% continue %}\n  {% endif %}\n  {{ item }}\n{% endfor %}\n</code></pre>\n\n<strong>Use cases:<strong>\n- <strong>Filtering<strong> items during iteration\n- <strong>Skipping<strong> invalid entries\n- <strong>Conditional<strong> processing\n\n<strong>Note:<strong> Only works inside `{% for %}` loops',
      replacedOnClick: '{% continue %}',
      openingTag: '{%',
      closingTag: '%}',
    ),
    SuggestionModelJinja(
      label: 'Set Block',
      description:
          '<h2><code>{% set %}` Block Assignment\n\n<strong>Set variable<strong> from block content (captures whitespace).\n\n<pre><code>\n{% set variable %}\n  Multi-line\n  content value\n{% endset %}\n</code></pre>\n\n<strong>Use cases:<strong>\n- <strong>Multi-line<strong> string assignment\n- <strong>Capturing<strong> formatted content\n- <strong>Preserving<strong> whitespace\n\n<strong>Note:<strong> Content includes newlines and indentation',
      replacedOnClick: '{% set variable %}\n  value\n{% endset %}',
      openingTag: '{%',
      closingTag: '%}',
    ),
    SuggestionModelJinja(
      label: 'Set Multiple',
      description:
          '<h2><code>{% set %}` Multiple Assignment\n\n<strong>Assign multiple variables<strong> in one statement.\n\n<pre><code>\n{% set var1, var2 = value1, value2 %}\n{% set name, age = user.name, user.age %}\n{% set x, y, z = 1, 2, 3 %}\n</code></pre>\n\n<strong>Use cases:<strong>\n- <strong>Unpacking<strong> tuples/lists\n- <strong>Multiple<strong> variable initialization\n- <strong>Cleaner<strong> code organization\n\n<strong>Note:<strong> Number of variables must match values',
      replacedOnClick: '{% set var1, var2 = value1, value2 %}',
      openingTag: '{%',
      closingTag: '%}',
    ),
    SuggestionModelJinja(
      label: 'Autoescape',
      description:
          '<h2><code>{% autoescape %}` Security Control\n\n<strong>Toggle autoescaping<strong> for XSS protection.\n\n<pre><code>\n{% autoescape true %}\n  {{ user_input }}  <!-- Escaped -->\n{% endautoescape %}\n\n{% autoescape false %}\n  {{ trusted_html }}  <!-- Not escaped -->\n{% endautoescape %}\n</code></pre>\n\n<strong>Security:<strong>\n- `true` - <strong>Escape HTML<strong> (default, safe)\n- `false` - <strong>Raw output<strong> (use with caution)\n\n<strong>Note:<strong> Requires `autoescape` extension\n\n<strong>Best practice:<strong> Keep autoescape enabled for user input',
      replacedOnClick: '{% autoescape true %}\n  \n{% endautoescape %}',
      openingTag: '{%',
      closingTag: '%}',
    ),
    SuggestionModelJinja(
      label: 'Cycle',
      description:
          '<h2><code>loop.cycle()` Alternating Values\n\n<strong>Cycle through<strong> values in a loop.\n\n<pre><code>\n{% for item in items %}\n  <div class="{{ loop.cycle(\'odd\', \'even\') }}">\n    {{ item }}\n  </div>\n{% endfor %}\n</code></pre>\n\n<strong>Multiple values:<strong>\n<pre><code>\n{{ loop.cycle(\'red\', \'blue\', \'green\') }}\n</code></pre>\n\n<strong>Use cases:<strong>\n- <strong>Alternating<strong> row colors\n- <strong>Rotating<strong> styles\n- <strong>Zebra striping<strong> tables\n\n<strong>Note:<strong> Available in `{% for %}` loops via `loop.cycle()`',
      replacedOnClick:
          '{% for item in items %}\n  <div class="{{ loop.cycle(\'odd\', \'even\') }}">{{ item }}</div>\n{% endfor %}',
      openingTag: '{%',
      closingTag: '%}',
    ),
    SuggestionModelJinja(
      label: 'Ifchanged',
      description:
          '<h2><code>{% ifchanged %}` Change Detection\n\n<strong>Render only<strong> when value changes from previous iteration.\n\n<pre><code>\n{% for item in items %}\n  {% ifchanged item.category %}\n    <h3>{{ item.category }}</h3>\n  {% endifchanged %}\n  {{ item.name }}\n{% endfor %}\n</code></pre>\n\n<strong>Use cases:<strong>\n- <strong>Grouping<strong> items by category\n- <strong>Section headers<strong> for grouped data\n- <strong>Avoiding<strong> duplicate headers\n\n<strong>Note:<strong> Django-inspired pattern, useful for grouped lists',
      replacedOnClick: '{% ifchanged %}\n  {{ value }}\n{% endifchanged %}',
      openingTag: '{%',
      closingTag: '%}',
    ),
    SuggestionModelJinja(
      label: 'Namespace',
      description:
          '<h2><code>{% namespace %}` Variable Scoping\n\n<strong>Create a namespace<strong> for variable isolation.\n\n<pre><code>\n{% namespace ns %}\n  {% set var = value %}\n  {{ var }}  <!-- Available here -->\n{% endnamespace %}\n<!-- var not available here -->\n</code></pre>\n\n<strong>Use cases:<strong>\n- <strong>Isolating<strong> variable scope\n- <strong>Avoiding<strong> name conflicts\n- <strong>Organizing<strong> template logic\n\n<strong>Note:<strong> Requires `namespace` extension to be enabled',
      replacedOnClick:
          '{% namespace ns %}\n  {% set var = value %}\n{% endnamespace %}',
      openingTag: '{%',
      closingTag: '%}',
    ),
    SuggestionModelJinja(
      label: 'Trans',
      description:
          '<h2><code>{% trans %}</code> Translation Block</h2>\n\n<p><strong>Translate content</strong> for internationalization.</p>\n\n<pre><code>{% trans %}Hello World{% endtrans %}\n{% trans count=items|length %}\n  {{ count }} item\n{% plural %}\n  {{ count }} items\n{% endtrans %}</code></pre>\n\n<p><strong>Use cases:</strong> Multi-language support, pluralization</p>',
      replacedOnClick: '{% trans %}\n  \n{% endtrans %}',
      openingTag: '{%',
      closingTag: '%}',
    ),
    SuggestionModelJinja(
      label: 'Debug',
      description:
          '<h2><code>{% debug %}</code> Debug Statement</h2>\n\n<p><strong>Output current context</strong> variables for debugging.</p>\n\n<pre><code>{% debug %}</code></pre>\n\n<p><strong>Use cases:</strong> Inspecting available variables, troubleshooting templates</p>',
      replacedOnClick: '{% debug %}',
      openingTag: '{%',
      closingTag: '%}',
    ),

    /// -------------------------------------------------------------------------
    /// Statements
    /// -------------------------------------------------------------------------

    /// -------------------------------------------------------------------------
    /// Filters
    /// -------------------------------------------------------------------------
    SuggestionModelJinja(
      label: 'Escape',
      description:
          '<h2><code>{{ value | escape }}</code> Filter\n\n<strong>Escape HTML</strong> characters in the value.\n\n<pre><code>\n{{ value | escape }}\n</code></pre>\n\n<strong>Use cases:<strong> Prevent XSS attacks, sanitize user input\n\n<strong>Note:<strong> Available in all templates',
      replacedOnClick: '| escape',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'String',
      description:
          '<h2><code>{{ value | string }}</code> Filter\n\n<strong>Convert value to string</strong>.\n\n<pre><code>\n{{ value | string }}\n</code></pre>\n\n<strong>Use cases:<strong> Convert values to strings, format numbers, concatenate strings\n\n<strong>Note:<strong> Available in all templates',
      replacedOnClick: '| string',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Replace',
      description:
          '<h2><code>{{ value | replace }}</code> Filter\n\n<strong>Replace text in the value</strong>.\n\n<pre><code>\n{{ value | replace("old", "new") }}\n</code></pre>\n\n<strong>Use cases:<strong> Replace text in strings, format numbers, concatenate strings\n\n<strong>Note:<strong> Available in all templates',
      replacedOnClick: '| replace("old", "new")',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Replace Each',
      description:
          '<h2><code>{{ value | replace_each }}</code> Filter\n\n<strong>Replace multiple<strong> text patterns at once.\n\n<pre><code>\n{{ value | replace_each([("old1", "new1"), ("old2", "new2")]) }}\n</code></pre>\n\n<strong>Use cases:<strong> Multiple replacements, bulk text transformation\n\n<strong>Note:<strong> Takes a list of tuples with (old, new) pairs',
      replacedOnClick: '| replace_each([("old", "new")])',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Regex Replace',
      description:
          '<h2><code>{{ value | regex_replace }}</code> Filter\n\n<strong>Replace using<strong> regular expressions.\n\n<pre><code>\n{{ value | regex_replace("pattern", "replacement") }}\n</code></pre>\n\n<strong>Use cases:<strong> Pattern-based replacements, complex text transformations\n\n<strong>Note:<strong> Uses regex patterns for matching',
      replacedOnClick: '| regex_replace("pattern", "replacement")',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Upper',
      description:
          '<h2><code>{{ value | upper }}</code> Filter\n\n<strong>Convert text<strong> to uppercase.\n\n<pre><code>\n{{ value | upper }}\n</code></pre>\n\n<strong>Use cases:<strong> Text formatting, case normalization, display formatting',
      replacedOnClick: '| upper',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Lower',
      description:
          '<h2><code>{{ value | lower }}</code> Filter\n\n<strong>Convert text<strong> to lowercase.\n\n<pre><code>\n{{ value | lower }}\n</code></pre>\n\n<strong>Use cases:<strong> Text formatting, case normalization, case-insensitive comparisons',
      replacedOnClick: '| lower',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Items',
      description:
          '<h2><code>{{ dict | items }}</code> Filter\n\n<strong>Get key-value pairs<strong> from a dictionary.\n\n<pre><code>\n{{ dict | items }}\n</code></pre>\n\n<strong>Use cases:<strong> Dictionary iteration, key-value access\n\n<strong>Note:<strong> Returns list of (key, value) tuples',
      replacedOnClick: '| items',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Capitalize',
      description:
          '<h2><code>{{ value | capitalize }}</code> Filter\n\n<strong>Capitalize first letter<strong> of the string.\n\n<pre><code>\n{{ value | capitalize }}\n</code></pre>\n\n<strong>Use cases:<strong> Name formatting, title case, text presentation',
      replacedOnClick: '| capitalize',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Title',
      description:
          '<h2><code>{{ value | title }}</code> Filter\n\n<strong>Convert to title case<strong> (each word capitalized).\n\n<pre><code>\n{{ value | title }}\n</code></pre>\n\n<strong>Use cases:<strong> Headings, proper names, formatted text display',
      replacedOnClick: '| title',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Dictsort',
      description:
          '<h2><code>{{ list | dictsort }}</code> Filter\n\n<strong>Sort list of dictionaries<strong> by a key.\n\n<pre><code>\n{{ items | dictsort("name") }}\n</code></pre>\n\n<strong>Use cases:<strong> Sorting dictionaries, ordered data display\n\n<strong>Note:<strong> Sorts by dictionary key value',
      replacedOnClick: '| dictsort("key")',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Default',
      description:
          '<h2><code>{{ value | default }}</code> Filter\n\n<strong>Provide default value<strong> if variable is undefined or empty.\n\n<pre><code>\n{{ value | default("default_value") }}\n</code></pre>\n\n<strong>Use cases:<strong> Fallback values, handling missing data, safe defaults',
      replacedOnClick: '| default("default_value")',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Join',
      description:
          '<h2><code>{{ list | join }}</code> Filter\n\n<strong>Join list items<strong> into a string.\n\n<pre><code>\n{{ list | join(", ") }}\n</code></pre>\n\n<strong>Use cases:<strong> Comma-separated lists, string concatenation, formatting arrays',
      replacedOnClick: '| join(", ")',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Center',
      description:
          '<h2><code>{{ value | center }}</code> Filter\n\n<strong>Center text<strong> with padding.\n\n<pre><code>\n{{ value | center(20) }}\n</code></pre>\n\n<strong>Use cases:<strong> Text alignment, formatting, display layout',
      replacedOnClick: '| center(20)',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'First',
      description:
          '<h2><code>{{ list | first }}</code> Filter\n\n<strong>Get first item<strong> from a list.\n\n<pre><code>\n{{ list | first }}\n</code></pre>\n\n<strong>Use cases:<strong> Accessing first element, default selection, list operations',
      replacedOnClick: '| first',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Last',
      description:
          '<h2><code>{{ list | last }}</code> Filter\n\n<strong>Get last item<strong> from a list.\n\n<pre><code>\n{{ list | last }}\n</code></pre>\n\n<strong>Use cases:<strong> Accessing last element, final item selection, list operations',
      replacedOnClick: '| last',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Random',
      description:
          '<h2><code>{{ list | random }}</code> Filter\n\n<strong>Get random item<strong> from a list.\n\n<pre><code>\n{{ list | random }}\n</code></pre>\n\n<strong>Use cases:<strong> Random selection, shuffling, random content display',
      replacedOnClick: '| random',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Filesizeformat',
      description:
          '<h2><code>{{ size | filesizeformat }}</code> Filter\n\n<strong>Format file size<strong> in human-readable format.\n\n<pre><code>\n{{ size | filesizeformat }}\n</code></pre>\n\n<strong>Use cases:<strong> File size display, storage information, user-friendly sizes\n\n<strong>Output:<strong> Formats as KB, MB, GB, etc.',
      replacedOnClick: '| filesizeformat',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Truncate',
      description:
          '<h2><code>{{ value | truncate }}</code> Filter\n\n<strong>Truncate text<strong> to specified length.\n\n<pre><code>\n{{ value | truncate(50) }}\n</code></pre>\n\n<strong>Use cases:<strong> Text previews, summaries, limiting display length',
      replacedOnClick: '| truncate(50)',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Wordwrap',
      description:
          '<h2><code>{{ value | wordwrap }}</code> Filter\n\n<strong>Wrap text<strong> at word boundaries.\n\n<pre><code>\n{{ value | wordwrap(40) }}\n</code></pre>\n\n<strong>Use cases:<strong> Text formatting, line breaks, readable text display',
      replacedOnClick: '| wordwrap(40)',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Wordcount',
      description:
          '<h2><code>{{ value | wordcount }}</code> Filter\n\n<strong>Count words<strong> in the text.\n\n<pre><code>\n{{ value | wordcount }}\n</code></pre>\n\n<strong>Use cases:<strong> Text statistics, content analysis, word counting',
      replacedOnClick: '| wordcount',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Int',
      description:
          '<h2><code>{{ value | int }}</code> Filter\n\n<strong>Convert value<strong> to integer.\n\n<pre><code>\n{{ value | int }}\n</code></pre>\n\n<strong>Use cases:<strong> Type conversion, numeric operations, integer formatting',
      replacedOnClick: '| int',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Float',
      description:
          '<h2><code>{{ value | float }}</code> Filter\n\n<strong>Convert value<strong> to floating-point number.\n\n<pre><code>\n{{ value | float }}\n</code></pre>\n\n<strong>Use cases:<strong> Type conversion, decimal numbers, numeric operations',
      replacedOnClick: '| float',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Abs',
      description:
          '<h2><code>{{ value | abs }}</code> Filter\n\n<strong>Get absolute value<strong> of a number.\n\n<pre><code>\n{{ value | abs }}\n</code></pre>\n\n<strong>Use cases:<strong> Distance calculations, magnitude, removing negative signs',
      replacedOnClick: '| abs',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Trim',
      description:
          '<h2><code>{{ value | trim }}</code> Filter\n\n<strong>Remove leading and trailing<strong> whitespace.\n\n<pre><code>\n{{ value | trim }}\n</code></pre>\n\n<strong>Use cases:<strong> Clean user input, remove extra spaces, text normalization',
      replacedOnClick: '| trim',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Striptags',
      description:
          '<h2><code>{{ value | striptags }}</code> Filter\n\n<strong>Remove HTML tags<strong> from text.\n\n<pre><code>\n{{ value | striptags }}\n</code></pre>\n\n<strong>Use cases:<strong> Plain text extraction, sanitization, removing markup',
      replacedOnClick: '| striptags',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Slice',
      description:
          '<h2><code>{{ list | slice }}</code> Filter\n\n<strong>Get slice<strong> of a list or string.\n\n<pre><code>\n{{ list | slice(0, 10) }}\n</code></pre>\n\n<strong>Use cases:<strong> Pagination, limiting results, array slicing',
      replacedOnClick: '| slice(0, 10)',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Batch',
      description:
          '<h2><code>{{ list | batch }}</code> Filter\n\n<strong>Split list<strong> into batches of specified size.\n\n<pre><code>\n{{ list | batch(3) }}\n</code></pre>\n\n<strong>Use cases:<strong> Grid layouts, pagination, grouping items',
      replacedOnClick: '| batch(3)',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Count',
      description:
          '<h2><code>{{ value | count }}</code> Filter\n\n<strong>Count items<strong> in a list or string length.\n\n<pre><code>\n{{ list | count }}\n</code></pre>\n\n<strong>Use cases:<strong> Counting elements, length operations, statistics',
      replacedOnClick: '| count',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Length',
      description:
          '<h2><code>{{ value | length }}</code> Filter\n\n<strong>Get length<strong> of a list, string, or dictionary.\n\n<pre><code>\n{{ value | length }}\n</code></pre>\n\n<strong>Use cases:<strong> Size checks, validation, counting elements',
      replacedOnClick: '| length',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Sum',
      description:
          '<h2><code>{{ list | sum }}</code> Filter\n\n<strong>Sum numeric values<strong> in a list.\n\n<pre><code>\n{{ list | sum }}\n</code></pre>\n\n<strong>Use cases:<strong> Totals, calculations, aggregations',
      replacedOnClick: '| sum',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'List',
      description:
          '<h2><code>{{ value | list }}</code> Filter\n\n<strong>Convert value<strong> to a list.\n\n<pre><code>\n{{ value | list }}\n</code></pre>\n\n<strong>Use cases:<strong> Type conversion, list operations, iterable creation',
      replacedOnClick: '| list',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Reverse',
      description:
          '<h2><code>{{ list | reverse }}</code> Filter\n\n<strong>Reverse order<strong> of a list or string.\n\n<pre><code>\n{{ list | reverse }}\n</code></pre>\n\n<strong>Use cases:<strong> Reversed display, backward iteration, order manipulation',
      replacedOnClick: '| reverse',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Attr',
      description:
          '<h2><code>{{ obj | attr }}</code> Filter\n\n<strong>Get attribute<strong> from an object.\n\n<pre><code>\n{{ obj | attr("attribute_name") }}\n</code></pre>\n\n<strong>Use cases:<strong> Dynamic attribute access, object property retrieval',
      replacedOnClick: '| attr("attribute_name")',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Item',
      description:
          '<h2><code>{{ obj | item }}</code> Filter\n\n<strong>Get item<strong> from dictionary or list by key/index.\n\n<pre><code>\n{{ obj | item("key") }}\n</code></pre>\n\n<strong>Use cases:<strong> Dynamic key access, dictionary lookups, list indexing',
      replacedOnClick: '| item("key")',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Map',
      description:
          '<h2><code>{{ list | map }}</code> Filter\n\n<strong>Apply filter<strong> to each item in a list.\n\n<pre><code>\n{{ list | map("attribute") }}\n</code></pre>\n\n<strong>Use cases:<strong> Extracting attributes, transforming lists, bulk operations',
      replacedOnClick: '| map("attribute")',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Tojson',
      description:
          '<h2><code>{{ value | tojson }}</code> Filter\n\n<strong>Convert value<strong> to JSON string.\n\n<pre><code>\n{{ value | tojson }}\n</code></pre>\n\n<strong>Use cases:<strong> JSON serialization, API responses, data exchange',
      replacedOnClick: '| tojson',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Runtimetype',
      description:
          '<h2><code>{{ value | runtimetype }}</code> Filter\n\n<strong>Get runtime type<strong> of a value.\n\n<pre><code>\n{{ value | runtimetype }}\n</code></pre>\n\n<strong>Use cases:<strong> Type checking, debugging, type information',
      replacedOnClick: '| runtimetype',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Date Diff Days',
      description:
          '<h2><code>{{ date | date_diff_days }}</code> Filter\n\n<strong>Calculate difference<strong> in days between dates.\n\n<pre><code>\n{{ date | date_diff_days(other_date) }}\n</code></pre>\n\n<strong>Use cases:<strong> Date calculations, time differences, age calculations',
      replacedOnClick: '| date_diff_days(other_date)',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Merge',
      description:
          '<h2><code>{{ dict | merge }}</code> Filter\n\n<strong>Merge dictionaries<strong> together.\n\n<pre><code>\n{{ dict1 | merge(dict2) }}\n</code></pre>\n\n<strong>Use cases:<strong> Combining dictionaries, merging configurations, data aggregation',
      replacedOnClick: '| merge(dict2)',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Tostring',
      description:
          '<h2><code>{{ value | tostring }}</code> Filter\n\n<strong>Convert value<strong> to string representation.\n\n<pre><code>\n{{ value | tostring }}\n</code></pre>\n\n<strong>Use cases:<strong> Type conversion, string formatting, display formatting',
      replacedOnClick: '| tostring',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'To Json F',
      description:
          '<h2><code>{{ value | toJsonF }}</code> Filter\n\n<strong>Convert value<strong> to formatted JSON string.\n\n<pre><code>\n{{ value | toJsonF }}\n</code></pre>\n\n<strong>Use cases:<strong> Pretty-printed JSON, formatted output, readable JSON',
      replacedOnClick: '| toJsonF',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Chunk',
      description:
          '<h2><code>{{ list | chunk }}</code> Filter\n\n<strong>Split list<strong> into chunks of specified size.\n\n<pre><code>\n{{ list | chunk(3) }}\n</code></pre>\n\n<strong>Use cases:<strong> Grid layouts, pagination, grouping items',
      replacedOnClick: '| chunk(3)',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Calculate List Stats',
      description:
          '<h2><code>{{ list | calculate_list_stats }}</code> Filter\n\n<strong>Calculate statistics<strong> for a numeric list.\n\n<pre><code>\n{{ list | calculate_list_stats }}\n</code></pre>\n\n<strong>Use cases:<strong> Statistical analysis, data summaries, aggregations',
      replacedOnClick: '| calculate_list_stats',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Max',
      description:
          '<h2><code>{{ list | max }}</code> Filter\n\n<strong>Get maximum value<strong> from a list.\n\n<pre><code>\n{{ list | max }}\n</code></pre>\n\n<strong>Use cases:<strong> Finding maximum, comparisons, data analysis',
      replacedOnClick: '| max',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Min',
      description:
          '<h2><code>{{ list | min }}</code> Filter\n\n<strong>Get minimum value<strong> from a list.\n\n<pre><code>\n{{ list | min }}\n</code></pre>\n\n<strong>Use cases:<strong> Finding minimum, comparisons, data analysis',
      replacedOnClick: '| min',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Format Number',
      description:
          '<h2><code>{{ value | format_number }}</code> Filter\n\n<strong>Format number<strong> with specified format.\n\n<pre><code>\n{{ value | format_number }}\n</code></pre>\n\n<strong>Use cases:<strong> Number formatting, currency, decimal places',
      replacedOnClick: '| format_number',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Get Plain Text From Html',
      description:
          '<h2><code>{{ value | get_plain_text_from_html }}</code> Filter\n\n<strong>Extract plain text<strong> from HTML content.\n\n<pre><code>\n{{ value | get_plain_text_from_html }}\n</code></pre>\n\n<strong>Use cases:<strong> Text extraction, content sanitization, plain text conversion',
      replacedOnClick: '| get_plain_text_from_html',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Get Filter Map',
      description:
          '<h2><code>{{ list | get_filter_map }}</code> Filter\n\n<strong>Get filtered map<strong> from a list.\n\n<pre><code>\n{{ list | get_filter_map("key") }}\n</code></pre>\n\n<strong>Use cases:<strong> Filtered transformations, conditional mapping, data filtering',
      replacedOnClick: '| get_filter_map("key")',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Filter Map',
      description:
          '<h2><code>{{ list | filter_map }}</code> Filter\n\n<strong>Filter and map<strong> list items.\n\n<pre><code>\n{{ list | filter_map("attribute") }}\n</code></pre>\n\n<strong>Use cases:<strong> Combined filtering and mapping, data transformation',
      replacedOnClick: '| filter_map("attribute")',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Get Items From Map',
      description:
          '<h2><code>{{ map | get_items_from_map }}</code> Filter\n\n<strong>Get items<strong> from a map/dictionary.\n\n<pre><code>\n{{ map | get_items_from_map }}\n</code></pre>\n\n<strong>Use cases:<strong> Dictionary operations, key-value extraction, map processing',
      replacedOnClick: '| get_items_from_map',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Sort By',
      description:
          '<h2><code>{{ list | sort_by }}</code> Filter\n\n<strong>Sort list<strong> by specified attribute or key.\n\n<pre><code>\n{{ list | sort_by("attribute") }}\n</code></pre>\n\n<strong>Use cases:<strong> Custom sorting, ordered display, data organization',
      replacedOnClick: '| sort_by("attribute")',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Select Attr Multi',
      description:
          '<h2><code>{{ list | selectattrmulti }}</code> Filter\n\n<strong>Select items<strong> matching multiple attribute conditions.\n\n<pre><code>\n{{ list | selectattrmulti("attr", "value") }}\n</code></pre>\n\n<strong>Use cases:<strong> Multi-attribute filtering, complex queries, data selection',
      replacedOnClick: '| selectattrmulti("attr", "value")',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Select Attr',
      description:
          '<h2><code>{{ list | selectattr }}</code> Filter\n\n<strong>Select items<strong> matching attribute condition.\n\n<pre><code>\n{{ list | selectattr("attribute", "value") }}\n</code></pre>\n\n<strong>Use cases:<strong> Attribute filtering, conditional selection, data filtering',
      replacedOnClick: '| selectattr("attribute", "value")',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Round',
      description:
          '<h2><code>{{ value | round }}</code> Filter\n\n<strong>Round number<strong> to specified decimal places.\n\n<pre><code>\n{{ value | round(2) }}\n</code></pre>\n\n<strong>Use cases:<strong> Decimal formatting, precision control, number rounding',
      replacedOnClick: '| round(2)',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Index Of By',
      description:
          '<h2><code>{{ list | indexOfBy }}</code> Filter\n\n<strong>Find index<strong> of item by attribute or condition.\n\n<pre><code>\n{{ list | indexOfBy("attribute", "value") }}\n</code></pre>\n\n<strong>Use cases:<strong> Finding positions, index lookup, item location',
      replacedOnClick: '| indexOfBy("attribute", "value")',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Sublist',
      description:
          '<h2><code>{{ list | sublist }}</code> Filter\n\n<strong>Get sublist<strong> from a list.\n\n<pre><code>\n{{ list | sublist(0, 10) }}\n</code></pre>\n\n<strong>Use cases:<strong> List slicing, pagination, range extraction',
      replacedOnClick: '| sublist(0, 10)',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'To Bool',
      description:
          '<h2><code>{{ value | toBool }}</code> Filter\n\n<strong>Convert value<strong> to boolean.\n\n<pre><code>\n{{ value | toBool }}\n</code></pre>\n\n<strong>Use cases:<strong> Type conversion, boolean operations, truthiness checks',
      replacedOnClick: '| toBool',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Json Decode',
      description:
          '<h2><code>{{ value | jsonDecode }}</code> Filter\n\n<strong>Decode JSON string<strong> to object.\n\n<pre><code>\n{{ value | jsonDecode }}\n</code></pre>\n\n<strong>Use cases:<strong> JSON parsing, data deserialization, API responses',
      replacedOnClick: '| jsonDecode',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Json Encode',
      description:
          '<h2><code>{{ value | jsonEncode }}</code> Filter\n\n<strong>Encode value<strong> to JSON string.\n\n<pre><code>\n{{ value | jsonEncode }}\n</code></pre>\n\n<strong>Use cases:<strong> JSON serialization, data encoding, API requests',
      replacedOnClick: '| jsonEncode',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Is B64',
      description:
          '<h2><code>{{ value | isb64 }}</code> Filter\n\n<strong>Check if value<strong> is base64 encoded.\n\n<pre><code>\n{{ value | isb64 }}\n</code></pre>\n\n<strong>Use cases:<strong> Encoding validation, format checking, data verification',
      replacedOnClick: '| isb64',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'B64 Encode',
      description:
          '<h2><code>{{ value | b64encode }}</code> Filter\n\n<strong>Encode value<strong> to base64.\n\n<pre><code>\n{{ value | b64encode }}\n</code></pre>\n\n<strong>Use cases:<strong> Base64 encoding, data encoding, secure transmission',
      replacedOnClick: '| b64encode',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'B64 Decode',
      description:
          '<h2><code>{{ value | b64decode }}</code> Filter\n\n<strong>Decode base64<strong> string to original value.\n\n<pre><code>\n{{ value | b64decode }}\n</code></pre>\n\n<strong>Use cases:<strong> Base64 decoding, data decoding, encoded content',
      replacedOnClick: '| b64decode',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Sub String',
      description:
          '<h2><code>{{ value | sub_string }}</code> Filter\n\n<strong>Extract substring<strong> from a string.\n\n<pre><code>\n{{ value | sub_string(0, 10) }}\n</code></pre>\n\n<strong>Use cases:<strong> String slicing, text extraction, substring operations',
      replacedOnClick: '| sub_string(0, 10)',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'To String',
      description:
          '<h2><code>{{ value | to_string }}</code> Filter\n\n<strong>Convert value<strong> to string.\n\n<pre><code>\n{{ value | to_string }}\n</code></pre>\n\n<strong>Use cases:<strong> Type conversion, string formatting, display formatting',
      replacedOnClick: '| to_string',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Split',
      description:
          '<h2><code>{{ value | split }}</code> Filter\n\n<strong>Split string<strong> into a list by delimiter.\n\n<pre><code>\n{{ value | split(",") }}\n</code></pre>\n\n<strong>Use cases:<strong> String parsing, CSV processing, text splitting',
      replacedOnClick: '| split(",")',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Date Format',
      description:
          '<h2><code>{{ date | date_format }}</code> Filter\n\n<strong>Format date<strong> with specified format string.\n\n<pre><code>\n{{ date | date_format("%Y-%m-%d") }}\n</code></pre>\n\n<strong>Use cases:<strong> Date formatting, time display, custom date formats',
      replacedOnClick: '| date_format("%Y-%m-%d")',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Sort',
      description:
          '<h2><code>{{ list | sort }}</code> Filter</h2>\n\n<p><strong>Sort a list</strong>.</p>\n\n<pre><code>{{ [3, 1, 2] | sort }}</code></pre>\n\n<p><strong>Use cases:</strong> Ordering lists, organizing data</p>',
      replacedOnClick: '| sort',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Unique',
      description:
          '<h2><code>{{ list | unique }}</code> Filter</h2>\n\n<p><strong>Filter unique items</strong> from a list.</p>\n\n<pre><code>{{ [1, 1, 2] | unique }}</code></pre>\n\n<p><strong>Use cases:</strong> Removing duplicates, finding distinct values</p>',
      replacedOnClick: '| unique',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Reject Attr',
      description:
          '<h2><code>{{ list | rejectattr }}</code> Filter</h2>\n\n<p><strong>Reject items</strong> matching attribute condition.</p>\n\n<pre><code>{{ users | rejectattr("is_active") }}</code></pre>\n\n<p><strong>Use cases:</strong> Filtering lists by attribute, excluding items</p>',
      replacedOnClick: '| rejectattr("attribute")',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Select',
      description:
          '<h2><code>{{ list | select }}</code> Filter</h2>\n\n<p><strong>Select items</strong> matching a test.</p>\n\n<pre><code>{{ numbers | select("even") }}</code></pre>\n\n<p><strong>Use cases:</strong> Filtering with tests, selecting specific items</p>',
      replacedOnClick: '| select("test")',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Reject',
      description:
          '<h2><code>{{ list | reject }}</code> Filter</h2>\n\n<p><strong>Reject items</strong> matching a test.</p>\n\n<pre><code>{{ numbers | reject("odd") }}</code></pre>\n\n<p><strong>Use cases:</strong> Filtering with tests, excluding items</p>',
      replacedOnClick: '| reject("test")',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Group By',
      description:
          '<h2><code>{{ list | groupby }}</code> Filter</h2>\n\n<p><strong>Group a sequence</strong> by an attribute.</p>\n\n<pre><code>{% for group in users | groupby("city") %}\n  {{ group.grouper }}: {{ group.list | join(", ") }}\n{% endfor %}</code></pre>\n\n<p><strong>Use cases:</strong> Categorizing data, grouped lists</p>',
      replacedOnClick: '| groupby("attribute")',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Safe',
      description:
          '<h2><code>{{ value | safe }}</code> Filter</h2>\n\n<p><strong>Mark value as safe</strong> (do not escape).</p>\n\n<pre><code>{{ html_content | safe }}</code></pre>\n\n<p><strong>Use cases:</strong> Rendering trusted HTML, bypassing auto-escaping</p>',
      replacedOnClick: '| safe',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Replace All From To',
      description:
          '<h2><code>{{ value | replace_all_from_to }}</code> Filter</h2>\n\n<p><strong>Replace all occurrences</strong> of a string with another.</p>\n\n<pre><code>{{ value | replace_all_from_to("world", "jinja") }}</code></pre>\n\n<p><strong>Use cases:</strong> String replacement, text substitution</p>',
      replacedOnClick: '| replace_all_from_to("from", "to")',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Replace Backslash N',
      description:
          '<h2><code>{{ value | replace_backslash_n }}</code> Filter</h2>\n\n<p><strong>Remove all newline characters</strong> from a string.</p>\n\n<pre><code>{{ value | replace_backslash_n }}</code></pre>\n\n<p><strong>Use cases:</strong> Cleaning text, removing line breaks</p>',
      replacedOnClick: '| replace_backslash_n',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Append',
      description:
          '<h2><code>{{ list | append }}</code> Filter</h2>\n\n<p><strong>Append a value</strong> to a list.</p>\n\n<pre><code>{{ list | append("new_item") }}</code></pre>\n\n<p><strong>Use cases:</strong> Adding items to a list</p>',
      replacedOnClick: '| append("item")',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Fromjson',
      description:
          '<h2><code>{{ json_string | fromjson }}</code> Filter</h2>\n\n<p><strong>Parse a JSON string</strong> into an object.</p>\n\n<pre><code>{{ json_string | fromjson }}</code></pre>\n\n<p><strong>Use cases:</strong> JSON parsing</p>',
      replacedOnClick: '| fromjson',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'As Bool',
      description:
          '<h2><code>{{ value | as_bool }}</code> Filter</h2>\n\n<p><strong>Convert value to boolean</strong>.</p>\n\n<pre><code>{{ value | as_bool }}</code></pre>\n\n<p><strong>Use cases:</strong> Type conversion, truthiness check</p>',
      replacedOnClick: '| as_bool',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Bool',
      description:
          '<h2><code>{{ value | bool }}</code> Filter</h2>\n\n<p><strong>Convert value to boolean</strong> (alias for as_bool).</p>\n\n<pre><code>{{ value | bool }}</code></pre>\n\n<p><strong>Use cases:</strong> Type conversion, truthiness check</p>',
      replacedOnClick: '| bool',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Combine',
      description:
          '<h2><code>{{ map1 | combine }}</code> Filter</h2>\n\n<p><strong>Merge two maps</strong> together.</p>\n\n<pre><code>{{ map1 | combine(map2) }}</code></pre>\n\n<p><strong>Use cases:</strong> Merging maps, combining data</p>',
      replacedOnClick: '| combine(map2)',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Build Tree',
      description:
          '<h2><code>{{ flat_list | buildTree }}</code> Filter</h2>\n\n<p><strong>Build a tree structure</strong> from a flat list.</p>\n\n<pre><code>{{ flat_list | buildTree }}</code></pre>\n\n<p><strong>Use cases:</strong> Tree visualization, hierarchy building</p>',
      replacedOnClick: '| buildTree',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Group By Multiple',
      description:
          '<h2><code>{{ list | groupbyMultiple }}</code> Filter</h2>\n\n<p><strong>Group a list</strong> by multiple attributes recursively.</p>\n\n<pre><code>{{ list | groupbyMultiple(["category", "subcategory"]) }}</code></pre>\n\n<p><strong>Use cases:</strong> Nested grouping, complex categorization</p>',
      replacedOnClick: '| groupbyMultiple(["attr1", "attr2"])',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Urlencode',
      description:
          '<h2><code>{{ value | urlencode }}</code> Filter</h2>\n\n<p><strong>URL encode</strong> a string.</p>\n\n<pre><code>{{ value | urlencode }}</code></pre>\n\n<p><strong>Use cases:</strong> URL parameters, encoding strings</p>',
      replacedOnClick: '| urlencode',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Urldecode',
      description:
          '<h2><code>{{ value | urldecode }}</code> Filter</h2>\n\n<p><strong>URL decode</strong> a string.</p>\n\n<pre><code>{{ value | urldecode }}</code></pre>\n\n<p><strong>Use cases:</strong> URL parameters, decoding strings</p>',
      replacedOnClick: '| urldecode',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'To Json',
      description:
          '<h2><code>{{ value | to_json }}</code> Filter</h2>\n\n<p><strong>Convert object to JSON string</strong> (formatted).</p>\n\n<pre><code>{{ value | to_json(indent=2) }}</code></pre>\n\n<p><strong>Use cases:</strong> JSON serialization, debugging</p>',
      replacedOnClick: '| to_json',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'From Json',
      description:
          '<h2><code>{{ value | from_json }}</code> Filter</h2>\n\n<p><strong>Parse JSON string</strong>.</p>\n\n<pre><code>{{ value | from_json }}</code></pre>\n\n<p><strong>Use cases:</strong> JSON parsing</p>',
      replacedOnClick: '| from_json',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Mandatory',
      description:
          '<h2><code>{{ value | mandatory }}</code> Filter</h2>\n\n<p><strong>Throw error if value is null</strong>.</p>\n\n<pre><code>{{ value | mandatory(hint="Field is required") }}</code></pre>\n\n<p><strong>Use cases:</strong> Validation, required fields</p>',
      replacedOnClick: '| mandatory(hint="Required")',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Ternary',
      description:
          '<h2><code>{{ condition | ternary }}</code> Filter</h2>\n\n<p><strong>Ternary operator</strong>.</p>\n\n<pre><code>{{ condition | ternary("true_val", "false_val") }}</code></pre>\n\n<p><strong>Use cases:</strong> Conditional values</p>',
      replacedOnClick: '| ternary("true", "false")',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Type Debug',
      description:
          '<h2><code>{{ value | type_debug }}</code> Filter</h2>\n\n<p><strong>Get runtime type</strong>.</p>\n\n<pre><code>{{ value | type_debug }}</code></pre>\n\n<p><strong>Use cases:</strong> Debugging, type checking</p>',
      replacedOnClick: '| type_debug',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Dict2Items',
      description:
          '<h2><code>{{ dict | dict2items }}</code> Filter</h2>\n\n<p><strong>Convert dictionary to list of items</strong>.</p>\n\n<pre><code>{{ dict | dict2items }}</code></pre>\n\n<p><strong>Use cases:</strong> Dictionary iteration</p>',
      replacedOnClick: '| dict2items',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Items2Dict',
      description:
          '<h2><code>{{ items | items2dict }}</code> Filter</h2>\n\n<p><strong>Convert list of items to dictionary</strong>.</p>\n\n<pre><code>{{ items | items2dict }}</code></pre>\n\n<p><strong>Use cases:</strong> Dictionary construction</p>',
      replacedOnClick: '| items2dict',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Flatten',
      description:
          '<h2><code>{{ list | flatten }}</code> Filter</h2>\n\n<p><strong>Flatten a nested list</strong>.</p>\n\n<pre><code>{{ list | flatten }}</code></pre>\n\n<p><strong>Use cases:</strong> List flattening</p>',
      replacedOnClick: '| flatten',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Product',
      description:
          '<h2><code>{{ lists | product }}</code> Filter</h2>\n\n<p><strong>Cartesian product</strong> of input iterables.</p>\n\n<pre><code>{{ lists | product }}</code></pre>\n\n<p><strong>Use cases:</strong> Combinatorics</p>',
      replacedOnClick: '| product',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Permutations',
      description:
          '<h2><code>{{ list | permutations }}</code> Filter</h2>\n\n<p><strong>Permutations</strong> of elements.</p>\n\n<pre><code>{{ list | permutations(2) }}</code></pre>\n\n<p><strong>Use cases:</strong> Combinatorics</p>',
      replacedOnClick: '| permutations',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Combinations',
      description:
          '<h2><code>{{ list | combinations }}</code> Filter</h2>\n\n<p><strong>Combinations</strong> of elements.</p>\n\n<pre><code>{{ list | combinations(2) }}</code></pre>\n\n<p><strong>Use cases:</strong> Combinatorics</p>',
      replacedOnClick: '| combinations',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Zip',
      description:
          '<h2><code>{{ list1 | zip }}</code> Filter</h2>\n\n<p><strong>Zip lists</strong> together.</p>\n\n<pre><code>{{ list1 | zip(list2) }}</code></pre>\n\n<p><strong>Use cases:</strong> Iterating multiple lists</p>',
      replacedOnClick: '| zip(list2)',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Zip Longest',
      description:
          '<h2><code>{{ list1 | zip_longest }}</code> Filter</h2>\n\n<p><strong>Zip lists</strong> (longest).</p>\n\n<pre><code>{{ list1 | zip_longest(list2, fillvalue="-") }}</code></pre>\n\n<p><strong>Use cases:</strong> Iterating multiple lists</p>',
      replacedOnClick: '| zip_longest(list2)',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'To UUID',
      description:
          '<h2><code>{{ value | to_uuid }}</code> Filter</h2>\n\n<p><strong>Generate UUID</strong>.</p>\n\n<pre><code>{{ value | to_uuid }}</code></pre>\n\n<p><strong>Use cases:</strong> ID generation</p>',
      replacedOnClick: '| to_uuid',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Regex Escape',
      description:
          '<h2><code>{{ value | regex_escape }}</code> Filter</h2>\n\n<p><strong>Escape string for regex</strong>.</p>\n\n<pre><code>{{ value | regex_escape }}</code></pre>\n\n<p><strong>Use cases:</strong> Regex safety</p>',
      replacedOnClick: '| regex_escape',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Regex Search',
      description:
          '<h2><code>{{ value | regex_search }}</code> Filter</h2>\n\n<p><strong>Search regex pattern</strong>.</p>\n\n<pre><code>{{ value | regex_search("pattern") }}</code></pre>\n\n<p><strong>Use cases:</strong> Pattern matching</p>',
      replacedOnClick: '| regex_search("pattern")',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'Regex Findall',
      description:
          '<h2><code>{{ value | regex_findall }}</code> Filter</h2>\n\n<p><strong>Find all regex matches</strong>.</p>\n\n<pre><code>{{ value | regex_findall("pattern") }}</code></pre>\n\n<p><strong>Use cases:</strong> Pattern matching</p>',
      replacedOnClick: '| regex_findall("pattern")',
      openingTag: '|',
      closingTag: '',
    ),
    SuggestionModelJinja(
      label: 'First Where',
      description:
          '<h2><code>{{ list | firstWhere }}</code> Filter</h2>\n\n<p><strong>Find first item matching condition</strong>.</p>\n\n<pre><code>{{ list | firstWhere("key", "==", "value") }}</code></pre>\n\n<p><strong>Use cases:</strong> Searching lists</p>',
      replacedOnClick: '| firstWhere("key", "==", "value")',
      openingTag: '|',
      closingTag: '',
    ),

    /// -------------------------------------------------------------------------
    /// Globals / Functions
    /// -------------------------------------------------------------------------
    SuggestionModelJinja(
      label: 'Return',
      description:
          '<h2><code>return(value)</code> Function</h2>\n\n<p><strong>Return data</strong> to the caller.</p>\n\n<pre><code>{{ return([1, 2, 3]) }}</code></pre>\n\n<p><strong>Use cases:</strong> Returning structured data from macros</p>',
      replacedOnClick: 'return()',
      openingTag: '{{',
      closingTag: '}}',
    ),
    SuggestionModelJinja(
      label: 'Jinja Action',
      description:
          '<h2><code>jinja_action(id, target, data)</code> Function</h2>\n\n<p><strong>Execute an action</strong> (widget, db, app).</p>\n\n<pre><code>{{ jinja_action(\'widget_id\', \'widget\', {\'key\': \'value\'}) }}</code></pre>\n\n<p><strong>Use cases:</strong> Widget refresh, DB actions, app callbacks</p>',
      replacedOnClick: 'jinja_action()',
      openingTag: '{{',
      closingTag: '}}',
    ),
    SuggestionModelJinja(
      label: 'Run Data Source',
      description:
          '<h2><code>run_data_source(id, properties)</code> Function</h2>\n\n<p><strong>Run a data source</strong> by ID.</p>\n\n<pre><code>{{ run_data_source(\'ds_users\', {\'page\': 1}) }}</code></pre>\n\n<p><strong>Use cases:</strong> Fetching data, API calls</p>',
      replacedOnClick: 'run_data_source()',
      openingTag: '{{',
      closingTag: '}}',
    ),
    SuggestionModelJinja(
      label: 'Get Data From DB',
      description:
          '<h2><code>get_data_from_db(query_map)</code> Function</h2>\n\n<p><strong>Retrieve data</strong> from database.</p>\n\n<pre><code>{{ get_data_from_db({\'table_name\': \'users\', \'limit\': 1}) }}</code></pre>\n\n<p><strong>Use cases:</strong> Database queries</p>',
      replacedOnClick: 'get_data_from_db()',
      openingTag: '{{',
      closingTag: '}}',
    ),
    SuggestionModelJinja(
      label: 'Render Widget By ID',
      description:
          '<h2><code>render_widget_by_id(id, data)</code> Function</h2>\n\n<p><strong>Render another widget</strong>.</p>\n\n<pre><code>{{ render_widget_by_id(\'footer\', {\'year\': 2024}) }}</code></pre>\n\n<p><strong>Use cases:</strong> Component composition, layout building</p>',
      replacedOnClick: 'render_widget_by_id()',
      openingTag: '{{',
      closingTag: '}}',
    ),
    SuggestionModelJinja(
      label: 'Get Widget By ID',
      description:
          '<h2><code>get_widget_by_id(id)</code> Function</h2>\n\n<p><strong>Get widget configuration</strong>.</p>\n\n<pre><code>{% set config = get_widget_by_id(\'chart\') %}</code></pre>\n\n<p><strong>Use cases:</strong> Accessing widget properties</p>',
      replacedOnClick: 'get_widget_by_id()',
      openingTag: '{{',
      closingTag: '}}',
    ),
    SuggestionModelJinja(
      label: 'Callback',
      description:
          '<h2><code>callback(id, data, payload)</code> Function</h2>\n\n<p><strong>Trigger generic callback</strong>.</p>\n\n<pre><code>{{ callback(\'on_submit\', {}, {\'status\': \'ok\'}) }}</code></pre>\n\n<p><strong>Use cases:</strong> Event handling, interactions</p>',
      replacedOnClick: 'callback()',
      openingTag: '{{',
      closingTag: '}}',
    ),
    SuggestionModelJinja(
      label: 'Print',
      description:
          '<h2><code>print(value)</code> Function</h2>\n\n<p><strong>Log value</strong> to console.</p>\n\n<pre><code>{{ print(my_var) }}</code></pre>\n\n<p><strong>Use cases:</strong> Debugging</p>',
      replacedOnClick: 'print()',
      openingTag: '{{',
      closingTag: '}}',
    ),
    SuggestionModelJinja(
      label: 'Translate',
      description:
          '<h2><code>translate(text, source, target)</code> Function</h2>\n\n<p><strong>Translate text</strong> using Google Translate.</p>\n\n<pre><code>{{ translate(\'Hello\', \'en\', \'es\') }}</code></pre>\n\n<p><strong>Use cases:</strong> Localization</p>',
      replacedOnClick: 'translate()',
      openingTag: '{{',
      closingTag: '}}',
    ),
    SuggestionModelJinja(
      label: 'UUID',
      description:
          '<h2><code>uuid()</code> Function</h2>\n\n<p><strong>Generate UUID v4</strong>.</p>\n\n<pre><code>{{ uuid() }}</code></pre>\n\n<p><strong>Use cases:</strong> Unique identifiers</p>',
      replacedOnClick: 'uuid()',
      openingTag: '{{',
      closingTag: '}}',
    ),
    SuggestionModelJinja(
      label: 'Ref',
      description:
          '<h2><code>ref(model)</code> Function</h2>\n\n<p><strong>dbt Reference</strong> (placeholder).</p>\n\n<pre><code>{{ ref(\'my_model\') }}</code></pre>\n\n<p><strong>Use cases:</strong> dbt compatibility</p>',
      replacedOnClick: 'ref()',
      openingTag: '{{',
      closingTag: '}}',
    ),
    SuggestionModelJinja(
      label: 'Source',
      description:
          '<h2><code>source(source, table)</code> Function</h2>\n\n<p><strong>dbt Source</strong> (placeholder).</p>\n\n<pre><code>{{ source(\'raw\', \'users\') }}</code></pre>\n\n<p><strong>Use cases:</strong> dbt compatibility</p>',
      replacedOnClick: 'source()',
      openingTag: '{{',
      closingTag: '}}',
    ),
    SuggestionModelJinja(
      label: 'Config',
      description:
          '<h2><code>config(args)</code> Function</h2>\n\n<p><strong>dbt Config</strong> (placeholder).</p>\n\n<pre><code>{{ config(materialized=\'table\') }}</code></pre>\n\n<p><strong>Use cases:</strong> dbt compatibility</p>',
      replacedOnClick: 'config()',
      openingTag: '{{',
      closingTag: '}}',
    ),
    SuggestionModelJinja(
      label: 'Var',
      description:
          '<h2><code>var(name, default)</code> Function</h2>\n\n<p><strong>dbt Variable</strong> (placeholder).</p>\n\n<pre><code>{{ var(\'my_var\', 10) }}</code></pre>\n\n<p><strong>Use cases:</strong> dbt compatibility</p>',
      replacedOnClick: 'var()',
      openingTag: '{{',
      closingTag: '}}',
    ),
    SuggestionModelJinja(
      label: 'Env Var',
      description:
          '<h2><code>env_var(name)</code> Function</h2>\n\n<p><strong>Environment Variable</strong> (placeholder).</p>\n\n<pre><code>{{ env_var(\'DB_HOST\') }}</code></pre>\n\n<p><strong>Use cases:</strong> dbt compatibility</p>',
      replacedOnClick: 'env_var()',
      openingTag: '{{',
      closingTag: '}}',
    ),
    SuggestionModelJinja(
      label: 'Log',
      description:
          '<h2><code>log(message)</code> Function</h2>\n\n<p><strong>Log message</strong> (placeholder).</p>\n\n<pre><code>{{ log(\'Starting...\') }}</code></pre>\n\n<p><strong>Use cases:</strong> dbt compatibility</p>',
      replacedOnClick: 'log()',
      openingTag: '{{',
      closingTag: '}}',
    ),
    SuggestionModelJinja(
      label: 'Run Query',
      description:
          '<h2><code>run_query(sql)</code> Function</h2>\n\n<p><strong>Run SQL query</strong> (placeholder).</p>\n\n<pre><code>{{ run_query(\'SELECT * FROM users\') }}</code></pre>\n\n<p><strong>Use cases:</strong> dbt compatibility</p>',
      replacedOnClick: 'run_query()',
      openingTag: '{{',
      closingTag: '}}',
    ),
    SuggestionModelJinja(
      label: 'Modules Datetime Now',
      description:
          '<h2><code>modules.datetime.now()</code> Function</h2>\n\n<p><strong>Get current datetime</strong>.</p>\n\n<pre><code>{{ modules.datetime.now() }}</code></pre>\n\n<p><strong>Use cases:</strong> Timestamps</p>',
      replacedOnClick: 'modules.datetime.now()',
      openingTag: '{{',
      closingTag: '}}',
    ),
    SuggestionModelJinja(
      label: 'Get Current Date',
      description:
          '<h2><code>get_current_date()</code> Function</h2>\n\n<p><strong>Get current date</strong> (dd/MM/yyyy).</p>\n\n<pre><code>{{ get_current_date().value }}</code></pre>\n\n<p><strong>Use cases:</strong> Date display</p>',
      replacedOnClick: 'get_current_date()',
      openingTag: '{{',
      closingTag: '}}',
    ),
    SuggestionModelJinja(
      label: 'Generate List',
      description:
          '<h2><code>generate_list(count, value)</code> Function</h2>\n\n<p><strong>Generate a list</strong> of items.</p>\n\n<pre><code>{{ generate_list(5, \'item\') }}</code></pre>\n\n<p><strong>Use cases:</strong> Mock data, iteration</p>',
      replacedOnClick: 'generate_list()',
      openingTag: '{{',
      closingTag: '}}',
    ),
    SuggestionModelJinja(
      label: 'Get List Of Widgets',
      description:
          '<h2><code>get_list_of_widgets(tree)</code> Function</h2>\n\n<p><strong>Flatten widget tree</strong>.</p>\n\n<pre><code>{{ get_list_of_widgets(root_widgets) }}</code></pre>\n\n<p><strong>Use cases:</strong> Widget processing</p>',
      replacedOnClick: 'get_list_of_widgets()',
      openingTag: '{{',
      closingTag: '}}',
    ),
    SuggestionModelJinja(
      label: 'Get Widget Width',
      description:
          '<h2><code>getWidgetWidth()</code> Function</h2>\n\n<p><strong>Get widget width</strong> (placeholder).</p>\n\n<pre><code>{{ getWidgetWidth() }}</code></pre>\n\n<p><strong>Use cases:</strong> Layout calculations</p>',
      replacedOnClick: 'getWidgetWidth()',
      openingTag: '{{',
      closingTag: '}}',
    ),
    SuggestionModelJinja(
      label: 'Get Widget Height',
      description:
          '<h2><code>getWidgetHeight()</code> Function</h2>\n\n<p><strong>Get widget height</strong> (placeholder).</p>\n\n<pre><code>{{ getWidgetHeight() }}</code></pre>\n\n<p><strong>Use cases:</strong> Layout calculations</p>',
      replacedOnClick: 'getWidgetHeight()',
      openingTag: '{{',
      closingTag: '}}',
    ),
    SuggestionModelJinja(
      label: 'Get Screen Width',
      description:
          '<h2><code>getScreenWidth()</code> Function</h2>\n\n<p><strong>Get device screen width</strong>.</p>\n\n<pre><code>{{ getScreenWidth() }}</code></pre>\n\n<p><strong>Use cases:</strong> Responsive design</p>',
      replacedOnClick: 'getScreenWidth()',
      openingTag: '{{',
      closingTag: '}}',
    ),
    SuggestionModelJinja(
      label: 'Get Screen Height',
      description:
          '<h2><code>getScreenHeight()</code> Function</h2>\n\n<p><strong>Get device screen height</strong>.</p>\n\n<pre><code>{{ getScreenHeight() }}</code></pre>\n\n<p><strong>Use cases:</strong> Responsive design</p>',
      replacedOnClick: 'getScreenHeight()',
      openingTag: '{{',
      closingTag: '}}',
    ),
    SuggestionModelJinja(
      label: 'Change Properties Values',
      description:
          '<h2><code>changePropertiesValues(json, updates)</code> Function</h2>\n\n<p><strong>Update widget properties</strong>.</p>\n\n<pre><code>{{ changePropertiesValues(data, updates) }}</code></pre>\n\n<p><strong>Use cases:</strong> Internal editor logic</p>',
      replacedOnClick: 'changePropertiesValues()',
      openingTag: '{{',
      closingTag: '}}',
    ),
    SuggestionModelJinja(
      label: 'Json Decode Global',
      description:
          '<h2><code>jsonDecode(value)</code> Function</h2>\n\n<p><strong>Decode JSON</strong>.</p>\n\n<pre><code>{{ jsonDecode(json_str) }}</code></pre>\n\n<p><strong>Use cases:</strong> JSON parsing</p>',
      replacedOnClick: 'jsonDecode()',
      openingTag: '{{',
      closingTag: '}}',
    ),
    SuggestionModelJinja(
      label: 'Get',
      description:
          '<h2><code>get(map, key, default)</code> Function</h2>\n\n<p><strong>Get value from map</strong> safely.</p>\n\n<pre><code>{{ get(data, \'key\', \'default\') }}</code></pre>\n\n<p><strong>Use cases:</strong> Safe access, deep retrieval</p>',
      replacedOnClick: 'get()',
      openingTag: '{{',
      closingTag: '}}',
    ),
    SuggestionModelJinja(
      label: 'Is Equal',
      description:
          '<h2><code>is_equal(a, b)</code> Function</h2>\n\n<p><strong>Check equality</strong> (supports Futures).</p>\n\n<pre><code>{{ is_equal(val1, val2) }}</code></pre>\n\n<p><strong>Use cases:</strong> Comparisons</p>',
      replacedOnClick: 'is_equal()',
      openingTag: '{{',
      closingTag: '}}',
    ),
    SuggestionModelJinja(
      label: 'Get Key If In Json',
      description:
          '<h2><code>get_key_if_in_json(map, key)</code> Function</h2>\n\n<p><strong>Return key if exists</strong>.</p>\n\n<pre><code>{{ get_key_if_in_json(data, \'key\') }}</code></pre>\n\n<p><strong>Use cases:</strong> Key validation</p>',
      replacedOnClick: 'get_key_if_in_json()',
      openingTag: '{{',
      closingTag: '}}',
    ),
    SuggestionModelJinja(
      label: 'Json Path',
      description:
          '<h2><code>jsonPath(json, query)</code> Function</h2>\n\n<p><strong>Query JSON</strong> with JSONPath.</p>\n\n<pre><code>{{ jsonPath(data, \'\$.store.book[0]\') }}</code></pre>\n\n<p><strong>Use cases:</strong> Deep data extraction</p>',
      replacedOnClick: 'jsonPath()',
      openingTag: '{{',
      closingTag: '}}',
    ),
  ];
}
