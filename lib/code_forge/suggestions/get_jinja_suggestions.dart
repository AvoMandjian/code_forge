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
          '## `{% if %}` Conditional Block\n\n**Conditional rendering** based on a boolean expression.\n\n```jinja\n{% if condition %}\n  <!-- Content when true -->\n{% endif %}\n```\n\n**Use cases:** Conditional content display, feature flags, validation',
      replacedOnClick: '{% if condition %}\n  \n{% endif %}',
      triggeredAt: '{%',
    ),
    SuggestionModelJinja(
      label: 'If-Else',
      description:
          '## `{% if %}` with `{% else %}`\n\n**Two-way conditional** with alternative content.\n\n```jinja\n{% if condition %}\n  <!-- True case -->\n{% else %}\n  <!-- False case -->\n{% endif %}\n```\n\n**Use cases:** Default fallbacks, user authentication states',
      replacedOnClick: '{% if condition %}\n  \n{% else %}\n  \n{% endif %}',
      triggeredAt: '{%',
    ),
    SuggestionModelJinja(
      label: 'If-Elif-Else',
      description:
          '## `{% if %}` Multi-Conditional\n\n**Multiple conditions** with elif chains.\n\n```jinja\n{% if condition %}\n  <!-- First case -->\n{% elif other_condition %}\n  <!-- Second case -->\n{% else %}\n  <!-- Default case -->\n{% endif %}\n```\n\n**Use cases:** Status handling, multi-state logic, priority checks',
      replacedOnClick:
          '{% if condition %}\n  \n{% elif other_condition %}\n  \n{% else %}\n  \n{% endif %}',
      triggeredAt: '{%',
    ),
    SuggestionModelJinja(
      label: 'For Loop',
      description:
          '## `{% for %}` Loop Block\n\n**Iterate over** a sequence or iterable.\n\n```jinja\n{% for item in items %}\n  {{ item }}\n{% endfor %}\n```\n\n**Loop variables:** `loop.index`, `loop.index0`, `loop.first`, `loop.last`\n\n**Use cases:** Lists, tables, repeating content',
      replacedOnClick: '{% for item in items %}\n  \n{% endfor %}',
      triggeredAt: '{%',
    ),
    SuggestionModelJinja(
      label: 'For Loop with Index',
      description:
          '## `{% for %}` with Index\n\n**Loop with index** counter for numbering.\n\n```jinja\n{% for item in items %}\n  {{ loop.index }}: {{ item }}\n{% endfor %}\n```\n\n**Index properties:**\n- `loop.index` - **1-based** index\n- `loop.index0` - **0-based** index\n- `loop.first` - **First iteration**\n- `loop.last` - **Last iteration**\n\n**Use cases:** Numbered lists, table rows, pagination',
      replacedOnClick:
          '{% for item in items %}\n  {{ loop.index }}: {{ item }}\n{% endfor %}',
      triggeredAt: '{%',
    ),
    SuggestionModelJinja(
      label: 'For Loop with Key-Value',
      description:
          '## `{% for %}` Dictionary Iteration\n\n**Iterate over** dictionary key-value pairs.\n\n```jinja\n{% for key, value in dict.items() %}\n  {{ key }}: {{ value }}\n{% endfor %}\n```\n\n**Dictionary methods:**\n- `.items()` - **Key-value pairs**\n- `.keys()` - **Keys only**\n- `.values()` - **Values only**\n\n**Use cases:** Configuration display, metadata rendering',
      replacedOnClick:
          '{% for key, value in dict.items() %}\n  {{ key }}: {{ value }}\n{% endfor %}',
      triggeredAt: '{%',
    ),
    SuggestionModelJinja(
      label: 'Block',
      description:
          '## `{% block %}` Template Block\n\n**Define a block** that can be overridden in child templates.\n\n```jinja\n{% block block_name %}\n  <!-- Default content -->\n{% endblock %}\n```\n\n**Use cases:** Template inheritance, content sections, layout customization\n\n**Best practice:** Use descriptive block names like `content`, `sidebar`, `footer`',
      replacedOnClick: '{% block block_name %}\n  \n{% endblock %}',
      triggeredAt: '{%',
    ),
    SuggestionModelJinja(
      label: 'Extends',
      description:
          '## `{% extends %}` Template Inheritance\n\n**Inherit from** a parent template.\n\n```jinja\n{% extends "base.html" %}\n```\n\n**Must be first tag** in the template.\n\n**Use cases:** Base templates, consistent layouts, DRY principle\n\n**Example:** Child templates override parent blocks',
      replacedOnClick: '{% extends "base.html" %}',
      triggeredAt: '{%',
    ),
    SuggestionModelJinja(
      label: 'Include',
      description:
          '## `{% include %}` Template Inclusion\n\n**Include another template** at this location.\n\n```jinja\n{% include "header.html" %}\n{% include "footer.html" %}\n```\n\n**With context:**\n```jinja\n{% include "widget.html" with context %}\n```\n\n**Use cases:** Reusable components, headers/footers, partials\n\n**Note:** Variables are passed from parent context',
      replacedOnClick: '{% include "template.html" %}',
      triggeredAt: '{%',
    ),
    SuggestionModelJinja(
      label: 'Macro',
      description:
          '## `{% macro %}` Function Definition\n\n**Define a reusable** template function.\n\n```jinja\n{% macro macro_name(param) %}\n  <!-- Macro content -->\n  {{ param }}\n{% endmacro %}\n```\n\n**Calling macros:**\n```jinja\n{{ macro_name("value") }}\n```\n\n**Use cases:** Reusable UI components, form fields, buttons\n\n**Benefits:** DRY principle, consistent styling',
      replacedOnClick: '{% macro macro_name(param) %}\n  \n{% endmacro %}',
      triggeredAt: '{%',
    ),
    SuggestionModelJinja(
      label: 'Call Macro',
      description:
          '## `{% call %}` Macro with Caller\n\n**Call a macro** and pass content via `caller()`.\n\n```jinja\n{% call macro_name(param) %}\n  <!-- Content passed to macro -->\n{% endcall %}\n```\n\n**In macro:** Use `{{ caller() }}` to render passed content.\n\n**Use cases:** Wrapper macros, decorated content, flexible components',
      replacedOnClick: '{% call macro_name(param) %}\n  \n{% endcall %}',
      triggeredAt: '{%',
    ),
    SuggestionModelJinja(
      label: 'Set Variable',
      description:
          '## `{% set %}` Variable Assignment\n\n**Assign a value** to a variable.\n\n```jinja\n{% set variable = value %}\n{% set name = "Jinja" %}\n{% set count = items|length %}\n```\n\n**Use cases:** Computed values, temporary variables, simplifying expressions\n\n**Scope:** Variables are available in the current block',
      replacedOnClick: '{% set variable = value %}',
      triggeredAt: '{%',
    ),

    SuggestionModelJinja(
      label: 'Comment',
      description:
          '## `{# #}` Template Comment\n\n**Comment out** template code (not rendered).\n\n```jinja\n{# Comment here #}\n{# Multi-line\n   comment #}\n```\n\n**Use cases:** Documentation, debugging, temporary code removal\n\n**Note:** Comments are **not included** in rendered output',
      replacedOnClick: '{# Comment here #}',
      triggeredAt: '{#',
    ),
    SuggestionModelJinja(
      label: 'With Statement',
      description:
          '## `{% with %}` Scoped Variables\n\n**Create scoped variables** for a block.\n\n```jinja\n{% with variable = value %}\n  {{ variable }}  <!-- Available here -->\n{% endwith %}\n<!-- variable not available here -->\n```\n\n**Multiple variables:**\n```jinja\n{% with var1 = val1, var2 = val2 %}\n  <!-- Both available -->\n{% endwith %}\n```\n\n**Use cases:** Temporary variables, scoped calculations, cleaner code',
      replacedOnClick: '{% with variable = value %}\n  \n{% endwith %}',
      triggeredAt: '{%',
    ),
    SuggestionModelJinja(
      label: 'Raw Block',
      description:
          '## `{% raw %}` Unprocessed Block\n\n**Output raw text** without Jinja processing.\n\n```jinja\n{% raw %}\n  {{ This will be output as-is }}\n  {% tags are not processed %}\n{% endraw %}\n```\n\n**Use cases:**\n- **Documentation** examples\n- **JavaScript** with curly braces\n- **CSS** with `{{ }}` syntax\n- **Escaping** Jinja syntax\n\n**Security:** Use carefully with user input',
      replacedOnClick: '{% raw %}\n  \n{% endraw %}',
      triggeredAt: '{%',
    ),
    SuggestionModelJinja(
      label: 'Filter Block',
      description:
          '## `{% filter %}` Block Filtering\n\n**Apply a filter** to all content in a block.\n\n```jinja\n{% filter upper %}\n  This text will be uppercase\n{% endfilter %}\n```\n\n**Common uses:**\n- `upper`, `lower` - **Case conversion**\n- `trim` - **Whitespace removal**\n- `striptags` - **Remove HTML tags**\n- `markdown` - **Markdown rendering**\n\n**Use cases:** Bulk text transformation, formatting entire sections',
      replacedOnClick: '{% filter filter_name %}\n  \n{% endfilter %}',
      triggeredAt: '{%',
    ),
    SuggestionModelJinja(
      label: 'Test',
      description:
          '## `{% if %}` with Tests\n\n**Conditional logic** using test functions.\n\n```jinja\n{% if value is test_name %}\n  <!-- Content when test passes -->\n{% endif %}\n```\n\n**Common tests:**\n- `is defined` - **Variable exists**\n- `is none` - **Value is None**\n- `is even`, `is odd` - **Number parity**\n- `is divisibleby(3)` - **Divisibility**\n- `is sameas(value)` - **Identity check**\n\n**Use cases:** Type checking, validation, conditional rendering',
      replacedOnClick: '{% if value is test_name %}\n  \n{% endif %}',
      triggeredAt: '{%',
    ),
    SuggestionModelJinja(
      label: 'Import',
      description:
          '## `{% import %}` Macro Import\n\n**Import macros** from another template as a namespace.\n\n```jinja\n{% import "macros.html" as macros %}\n{{ macros.button("Click me") }}\n{{ macros.input("name", "text") }}\n```\n\n**Namespace benefits:**\n- **Avoid conflicts** with local macros\n- **Organized** macro access\n- **Reusable** component library\n\n**Use cases:** Shared macro libraries, component systems',
      replacedOnClick: '{% import "macros.html" as macros %}',
      triggeredAt: '{%',
    ),
    SuggestionModelJinja(
      label: 'From Import',
      description:
          '## `{% from %}` Selective Import\n\n**Import specific macros** directly into current namespace.\n\n```jinja\n{% from "macros.html" import button, input %}\n{{ button("Click me") }}\n{{ input("name", "text") }}\n```\n\n**Multiple imports:**\n```jinja\n{% from "macros.html" import macro1, macro2, macro3 %}\n```\n\n**Use cases:** Selective imports, avoiding namespace prefixes\n\n**Note:** Can cause name conflicts if macros share names',
      replacedOnClick: '{% from "macros.html" import macro_name %}',
      triggeredAt: '{%',
    ),
    SuggestionModelJinja(
      label: 'Do Statement',
      description:
          '## `{% do %}` Side Effect Execution\n\n**Execute code** without producing output.\n\n```jinja\n{% do dict.update({"key": "value"}) %}\n{% do list.append(item) %}\n{% do set.add(value) %}\n```\n\n**Use cases:**\n- **Modifying** data structures\n- **Calling** methods with side effects\n- **Updating** mutable objects\n\n**Note:** Requires `do` extension to be enabled',
      replacedOnClick: '{% do dict.update({"key": "value"}) %}',
      triggeredAt: '{%',
    ),
    SuggestionModelJinja(
      label: 'Break',
      description:
          '## `{% break %}` Loop Exit\n\n**Exit a loop** early when condition is met.\n\n```jinja\n{% for item in items %}\n  {% if item == target %}\n    {% break %}\n  {% endif %}\n  {{ item }}\n{% endfor %}\n```\n\n**Use cases:**\n- **Early termination** when found\n- **Performance** optimization\n- **Conditional** loop exit\n\n**Note:** Only works inside `{% for %}` loops',
      replacedOnClick: '{% break %}',
      triggeredAt: '{%',
    ),
    SuggestionModelJinja(
      label: 'Continue',
      description:
          '## `{% continue %}` Skip Iteration\n\n**Skip to next** loop iteration.\n\n```jinja\n{% for item in items %}\n  {% if item.skip %}\n    {% continue %}\n  {% endif %}\n  {{ item }}\n{% endfor %}\n```\n\n**Use cases:**\n- **Filtering** items during iteration\n- **Skipping** invalid entries\n- **Conditional** processing\n\n**Note:** Only works inside `{% for %}` loops',
      replacedOnClick: '{% continue %}',
      triggeredAt: '{%',
    ),
    SuggestionModelJinja(
      label: 'Set Block',
      description:
          '## `{% set %}` Block Assignment\n\n**Set variable** from block content (captures whitespace).\n\n```jinja\n{% set variable %}\n  Multi-line\n  content value\n{% endset %}\n```\n\n**Use cases:**\n- **Multi-line** string assignment\n- **Capturing** formatted content\n- **Preserving** whitespace\n\n**Note:** Content includes newlines and indentation',
      replacedOnClick: '{% set variable %}\n  value\n{% endset %}',
      triggeredAt: '{%',
    ),
    SuggestionModelJinja(
      label: 'Set Multiple',
      description:
          '## `{% set %}` Multiple Assignment\n\n**Assign multiple variables** in one statement.\n\n```jinja\n{% set var1, var2 = value1, value2 %}\n{% set name, age = user.name, user.age %}\n{% set x, y, z = 1, 2, 3 %}\n```\n\n**Use cases:**\n- **Unpacking** tuples/lists\n- **Multiple** variable initialization\n- **Cleaner** code organization\n\n**Note:** Number of variables must match values',
      replacedOnClick: '{% set var1, var2 = value1, value2 %}',
      triggeredAt: '{%',
    ),
    SuggestionModelJinja(
      label: 'Autoescape',
      description:
          '## `{% autoescape %}` Security Control\n\n**Toggle autoescaping** for XSS protection.\n\n```jinja\n{% autoescape true %}\n  {{ user_input }}  <!-- Escaped -->\n{% endautoescape %}\n\n{% autoescape false %}\n  {{ trusted_html }}  <!-- Not escaped -->\n{% endautoescape %}\n```\n\n**Security:**\n- `true` - **Escape HTML** (default, safe)\n- `false` - **Raw output** (use with caution)\n\n**Note:** Requires `autoescape` extension\n\n**Best practice:** Keep autoescape enabled for user input',
      replacedOnClick: '{% autoescape true %}\n  \n{% endautoescape %}',
      triggeredAt: '{%',
    ),
    SuggestionModelJinja(
      label: 'Cycle',
      description:
          '## `loop.cycle()` Alternating Values\n\n**Cycle through** values in a loop.\n\n```jinja\n{% for item in items %}\n  <div class="{{ loop.cycle(\'odd\', \'even\') }}">\n    {{ item }}\n  </div>\n{% endfor %}\n```\n\n**Multiple values:**\n```jinja\n{{ loop.cycle(\'red\', \'blue\', \'green\') }}\n```\n\n**Use cases:**\n- **Alternating** row colors\n- **Rotating** styles\n- **Zebra striping** tables\n\n**Note:** Available in `{% for %}` loops via `loop.cycle()`',
      replacedOnClick:
          '{% for item in items %}\n  <div class="{{ loop.cycle(\'odd\', \'even\') }}">{{ item }}</div>\n{% endfor %}',
      triggeredAt: '{%',
    ),
    SuggestionModelJinja(
      label: 'Ifchanged',
      description:
          '## `{% ifchanged %}` Change Detection\n\n**Render only** when value changes from previous iteration.\n\n```jinja\n{% for item in items %}\n  {% ifchanged item.category %}\n    <h3>{{ item.category }}</h3>\n  {% endifchanged %}\n  {{ item.name }}\n{% endfor %}\n```\n\n**Use cases:**\n- **Grouping** items by category\n- **Section headers** for grouped data\n- **Avoiding** duplicate headers\n\n**Note:** Django-inspired pattern, useful for grouped lists',
      replacedOnClick: '{% ifchanged %}\n  {{ value }}\n{% endifchanged %}',
      triggeredAt: '{%',
    ),
    SuggestionModelJinja(
      label: 'Namespace',
      description:
          '## `{% namespace %}` Variable Scoping\n\n**Create a namespace** for variable isolation.\n\n```jinja\n{% namespace ns %}\n  {% set var = value %}\n  {{ var }}  <!-- Available here -->\n{% endnamespace %}\n<!-- var not available here -->\n```\n\n**Use cases:**\n- **Isolating** variable scope\n- **Avoiding** name conflicts\n- **Organizing** template logic\n\n**Note:** Requires `namespace` extension to be enabled',
      replacedOnClick:
          '{% namespace ns %}\n  {% set var = value %}\n{% endnamespace %}',
      triggeredAt: '{%',
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
          '## `{{ value | escape }}` Filter\n\n**Escape HTML** characters in the value.\n\n```jinja\n{{ value | escape }}\n```\n\n**Use cases:** Prevent XSS attacks, sanitize user input\n\n**Note:** Available in all templates',
      replacedOnClick: '| escape',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'String',
      description:
          '## `{{ value | string }}` Filter\n\n**Convert value to string**.\n\n```jinja\n{{ value | string }}\n```\n\n**Use cases:** Convert values to strings, format numbers, concatenate strings\n\n**Note:** Available in all templates',
      replacedOnClick: '| string',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Replace',
      description:
          '## `{{ value | replace }}` Filter\n\n**Replace text in the value**.\n\n```jinja\n{{ value | replace("old", "new") }}\n```\n\n**Use cases:** Replace text in strings, format numbers, concatenate strings\n\n**Note:** Available in all templates',
      replacedOnClick: '| replace("old", "new")',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Replace Each',
      description:
          '## `{{ value | replace_each }}` Filter\n\n**Replace multiple** text patterns at once.\n\n```jinja\n{{ value | replace_each([("old1", "new1"), ("old2", "new2")]) }}\n```\n\n**Use cases:** Multiple replacements, bulk text transformation\n\n**Note:** Takes a list of tuples with (old, new) pairs',
      replacedOnClick: '| replace_each([("old", "new")])',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Regex Replace',
      description:
          '## `{{ value | regex_replace }}` Filter\n\n**Replace using** regular expressions.\n\n```jinja\n{{ value | regex_replace("pattern", "replacement") }}\n```\n\n**Use cases:** Pattern-based replacements, complex text transformations\n\n**Note:** Uses regex patterns for matching',
      replacedOnClick: '| regex_replace("pattern", "replacement")',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Upper',
      description:
          '## `{{ value | upper }}` Filter\n\n**Convert text** to uppercase.\n\n```jinja\n{{ value | upper }}\n```\n\n**Use cases:** Text formatting, case normalization, display formatting',
      replacedOnClick: '| upper',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Lower',
      description:
          '## `{{ value | lower }}` Filter\n\n**Convert text** to lowercase.\n\n```jinja\n{{ value | lower }}\n```\n\n**Use cases:** Text formatting, case normalization, case-insensitive comparisons',
      replacedOnClick: '| lower',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Items',
      description:
          '## `{{ dict | items }}` Filter\n\n**Get key-value pairs** from a dictionary.\n\n```jinja\n{{ dict | items }}\n```\n\n**Use cases:** Dictionary iteration, key-value access\n\n**Note:** Returns list of (key, value) tuples',
      replacedOnClick: '| items',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Capitalize',
      description:
          '## `{{ value | capitalize }}` Filter\n\n**Capitalize first letter** of the string.\n\n```jinja\n{{ value | capitalize }}\n```\n\n**Use cases:** Name formatting, title case, text presentation',
      replacedOnClick: '| capitalize',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Title',
      description:
          '## `{{ value | title }}` Filter\n\n**Convert to title case** (each word capitalized).\n\n```jinja\n{{ value | title }}\n```\n\n**Use cases:** Headings, proper names, formatted text display',
      replacedOnClick: '| title',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Dictsort',
      description:
          '## `{{ list | dictsort }}` Filter\n\n**Sort list of dictionaries** by a key.\n\n```jinja\n{{ items | dictsort("name") }}\n```\n\n**Use cases:** Sorting dictionaries, ordered data display\n\n**Note:** Sorts by dictionary key value',
      replacedOnClick: '| dictsort("key")',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Default',
      description:
          '## `{{ value | default }}` Filter\n\n**Provide default value** if variable is undefined or empty.\n\n```jinja\n{{ value | default("default_value") }}\n```\n\n**Use cases:** Fallback values, handling missing data, safe defaults',
      replacedOnClick: '| default("default_value")',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Join',
      description:
          '## `{{ list | join }}` Filter\n\n**Join list items** into a string.\n\n```jinja\n{{ list | join(", ") }}\n```\n\n**Use cases:** Comma-separated lists, string concatenation, formatting arrays',
      replacedOnClick: '| join(", ")',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Center',
      description:
          '## `{{ value | center }}` Filter\n\n**Center text** with padding.\n\n```jinja\n{{ value | center(20) }}\n```\n\n**Use cases:** Text alignment, formatting, display layout',
      replacedOnClick: '| center(20)',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'First',
      description:
          '## `{{ list | first }}` Filter\n\n**Get first item** from a list.\n\n```jinja\n{{ list | first }}\n```\n\n**Use cases:** Accessing first element, default selection, list operations',
      replacedOnClick: '| first',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Last',
      description:
          '## `{{ list | last }}` Filter\n\n**Get last item** from a list.\n\n```jinja\n{{ list | last }}\n```\n\n**Use cases:** Accessing last element, final item selection, list operations',
      replacedOnClick: '| last',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Random',
      description:
          '## `{{ list | random }}` Filter\n\n**Get random item** from a list.\n\n```jinja\n{{ list | random }}\n```\n\n**Use cases:** Random selection, shuffling, random content display',
      replacedOnClick: '| random',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Filesizeformat',
      description:
          '## `{{ size | filesizeformat }}` Filter\n\n**Format file size** in human-readable format.\n\n```jinja\n{{ size | filesizeformat }}\n```\n\n**Use cases:** File size display, storage information, user-friendly sizes\n\n**Output:** Formats as KB, MB, GB, etc.',
      replacedOnClick: '| filesizeformat',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Truncate',
      description:
          '## `{{ value | truncate }}` Filter\n\n**Truncate text** to specified length.\n\n```jinja\n{{ value | truncate(50) }}\n```\n\n**Use cases:** Text previews, summaries, limiting display length',
      replacedOnClick: '| truncate(50)',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Wordwrap',
      description:
          '## `{{ value | wordwrap }}` Filter\n\n**Wrap text** at word boundaries.\n\n```jinja\n{{ value | wordwrap(40) }}\n```\n\n**Use cases:** Text formatting, line breaks, readable text display',
      replacedOnClick: '| wordwrap(40)',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Wordcount',
      description:
          '## `{{ value | wordcount }}` Filter\n\n**Count words** in the text.\n\n```jinja\n{{ value | wordcount }}\n```\n\n**Use cases:** Text statistics, content analysis, word counting',
      replacedOnClick: '| wordcount',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Int',
      description:
          '## `{{ value | int }}` Filter\n\n**Convert value** to integer.\n\n```jinja\n{{ value | int }}\n```\n\n**Use cases:** Type conversion, numeric operations, integer formatting',
      replacedOnClick: '| int',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Float',
      description:
          '## `{{ value | float }}` Filter\n\n**Convert value** to floating-point number.\n\n```jinja\n{{ value | float }}\n```\n\n**Use cases:** Type conversion, decimal numbers, numeric operations',
      replacedOnClick: '| float',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Abs',
      description:
          '## `{{ value | abs }}` Filter\n\n**Get absolute value** of a number.\n\n```jinja\n{{ value | abs }}\n```\n\n**Use cases:** Distance calculations, magnitude, removing negative signs',
      replacedOnClick: '| abs',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Trim',
      description:
          '## `{{ value | trim }}` Filter\n\n**Remove leading and trailing** whitespace.\n\n```jinja\n{{ value | trim }}\n```\n\n**Use cases:** Clean user input, remove extra spaces, text normalization',
      replacedOnClick: '| trim',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Striptags',
      description:
          '## `{{ value | striptags }}` Filter\n\n**Remove HTML tags** from text.\n\n```jinja\n{{ value | striptags }}\n```\n\n**Use cases:** Plain text extraction, sanitization, removing markup',
      replacedOnClick: '| striptags',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Slice',
      description:
          '## `{{ list | slice }}` Filter\n\n**Get slice** of a list or string.\n\n```jinja\n{{ list | slice(0, 10) }}\n```\n\n**Use cases:** Pagination, limiting results, array slicing',
      replacedOnClick: '| slice(0, 10)',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Batch',
      description:
          '## `{{ list | batch }}` Filter\n\n**Split list** into batches of specified size.\n\n```jinja\n{{ list | batch(3) }}\n```\n\n**Use cases:** Grid layouts, pagination, grouping items',
      replacedOnClick: '| batch(3)',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Count',
      description:
          '## `{{ value | count }}` Filter\n\n**Count items** in a list or string length.\n\n```jinja\n{{ list | count }}\n```\n\n**Use cases:** Counting elements, length operations, statistics',
      replacedOnClick: '| count',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Length',
      description:
          '## `{{ value | length }}` Filter\n\n**Get length** of a list, string, or dictionary.\n\n```jinja\n{{ value | length }}\n```\n\n**Use cases:** Size checks, validation, counting elements',
      replacedOnClick: '| length',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Sum',
      description:
          '## `{{ list | sum }}` Filter\n\n**Sum numeric values** in a list.\n\n```jinja\n{{ list | sum }}\n```\n\n**Use cases:** Totals, calculations, aggregations',
      replacedOnClick: '| sum',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'List',
      description:
          '## `{{ value | list }}` Filter\n\n**Convert value** to a list.\n\n```jinja\n{{ value | list }}\n```\n\n**Use cases:** Type conversion, list operations, iterable creation',
      replacedOnClick: '| list',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Reverse',
      description:
          '## `{{ list | reverse }}` Filter\n\n**Reverse order** of a list or string.\n\n```jinja\n{{ list | reverse }}\n```\n\n**Use cases:** Reversed display, backward iteration, order manipulation',
      replacedOnClick: '| reverse',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Attr',
      description:
          '## `{{ obj | attr }}` Filter\n\n**Get attribute** from an object.\n\n```jinja\n{{ obj | attr("attribute_name") }}\n```\n\n**Use cases:** Dynamic attribute access, object property retrieval',
      replacedOnClick: '| attr("attribute_name")',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Item',
      description:
          '## `{{ obj | item }}` Filter\n\n**Get item** from dictionary or list by key/index.\n\n```jinja\n{{ obj | item("key") }}\n```\n\n**Use cases:** Dynamic key access, dictionary lookups, list indexing',
      replacedOnClick: '| item("key")',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Map',
      description:
          '## `{{ list | map }}` Filter\n\n**Apply filter** to each item in a list.\n\n```jinja\n{{ list | map("attribute") }}\n```\n\n**Use cases:** Extracting attributes, transforming lists, bulk operations',
      replacedOnClick: '| map("attribute")',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Tojson',
      description:
          '## `{{ value | tojson }}` Filter\n\n**Convert value** to JSON string.\n\n```jinja\n{{ value | tojson }}\n```\n\n**Use cases:** JSON serialization, API responses, data exchange',
      replacedOnClick: '| tojson',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Runtimetype',
      description:
          '## `{{ value | runtimetype }}` Filter\n\n**Get runtime type** of a value.\n\n```jinja\n{{ value | runtimetype }}\n```\n\n**Use cases:** Type checking, debugging, type information',
      replacedOnClick: '| runtimetype',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Date Diff Days',
      description:
          '## `{{ date | date_diff_days }}` Filter\n\n**Calculate difference** in days between dates.\n\n```jinja\n{{ date | date_diff_days(other_date) }}\n```\n\n**Use cases:** Date calculations, time differences, age calculations',
      replacedOnClick: '| date_diff_days(other_date)',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Merge',
      description:
          '## `{{ dict | merge }}` Filter\n\n**Merge dictionaries** together.\n\n```jinja\n{{ dict1 | merge(dict2) }}\n```\n\n**Use cases:** Combining dictionaries, merging configurations, data aggregation',
      replacedOnClick: '| merge(dict2)',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Tostring',
      description:
          '## `{{ value | tostring }}` Filter\n\n**Convert value** to string representation.\n\n```jinja\n{{ value | tostring }}\n```\n\n**Use cases:** Type conversion, string formatting, display formatting',
      replacedOnClick: '| tostring',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'To Json F',
      description:
          '## `{{ value | toJsonF }}` Filter\n\n**Convert value** to formatted JSON string.\n\n```jinja\n{{ value | toJsonF }}\n```\n\n**Use cases:** Pretty-printed JSON, formatted output, readable JSON',
      replacedOnClick: '| toJsonF',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Chunk',
      description:
          '## `{{ list | chunk }}` Filter\n\n**Split list** into chunks of specified size.\n\n```jinja\n{{ list | chunk(3) }}\n```\n\n**Use cases:** Grid layouts, pagination, grouping items',
      replacedOnClick: '| chunk(3)',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Calculate List Stats',
      description:
          '## `{{ list | calculate_list_stats }}` Filter\n\n**Calculate statistics** for a numeric list.\n\n```jinja\n{{ list | calculate_list_stats }}\n```\n\n**Use cases:** Statistical analysis, data summaries, aggregations',
      replacedOnClick: '| calculate_list_stats',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Max',
      description:
          '## `{{ list | max }}` Filter\n\n**Get maximum value** from a list.\n\n```jinja\n{{ list | max }}\n```\n\n**Use cases:** Finding maximum, comparisons, data analysis',
      replacedOnClick: '| max',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Min',
      description:
          '## `{{ list | min }}` Filter\n\n**Get minimum value** from a list.\n\n```jinja\n{{ list | min }}\n```\n\n**Use cases:** Finding minimum, comparisons, data analysis',
      replacedOnClick: '| min',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Format Number',
      description:
          '## `{{ value | format_number }}` Filter\n\n**Format number** with specified format.\n\n```jinja\n{{ value | format_number }}\n```\n\n**Use cases:** Number formatting, currency, decimal places',
      replacedOnClick: '| format_number',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Capitalize Letters',
      description:
          '## `{{ value | capitalize_letters }}` Filter\n\n**Capitalize specific letters** in the string.\n\n```jinja\n{{ value | capitalize_letters }}\n```\n\n**Use cases:** Custom capitalization, text formatting, special formatting',
      replacedOnClick: '| capitalize_letters',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Get Plain Text From Html',
      description:
          '## `{{ value | get_plain_text_from_html }}` Filter\n\n**Extract plain text** from HTML content.\n\n```jinja\n{{ value | get_plain_text_from_html }}\n```\n\n**Use cases:** Text extraction, content sanitization, plain text conversion',
      replacedOnClick: '| get_plain_text_from_html',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Get Filter Map',
      description:
          '## `{{ list | get_filter_map }}` Filter\n\n**Get filtered map** from a list.\n\n```jinja\n{{ list | get_filter_map("key") }}\n```\n\n**Use cases:** Filtered transformations, conditional mapping, data filtering',
      replacedOnClick: '| get_filter_map("key")',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Filter Map',
      description:
          '## `{{ list | filter_map }}` Filter\n\n**Filter and map** list items.\n\n```jinja\n{{ list | filter_map("attribute") }}\n```\n\n**Use cases:** Combined filtering and mapping, data transformation',
      replacedOnClick: '| filter_map("attribute")',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Get Items From Map',
      description:
          '## `{{ map | get_items_from_map }}` Filter\n\n**Get items** from a map/dictionary.\n\n```jinja\n{{ map | get_items_from_map }}\n```\n\n**Use cases:** Dictionary operations, key-value extraction, map processing',
      replacedOnClick: '| get_items_from_map',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Sort By',
      description:
          '## `{{ list | sort_by }}` Filter\n\n**Sort list** by specified attribute or key.\n\n```jinja\n{{ list | sort_by("attribute") }}\n```\n\n**Use cases:** Custom sorting, ordered display, data organization',
      replacedOnClick: '| sort_by("attribute")',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Select Attr Multi',
      description:
          '## `{{ list | selectattrmulti }}` Filter\n\n**Select items** matching multiple attribute conditions.\n\n```jinja\n{{ list | selectattrmulti("attr", "value") }}\n```\n\n**Use cases:** Multi-attribute filtering, complex queries, data selection',
      replacedOnClick: '| selectattrmulti("attr", "value")',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Select Attr',
      description:
          '## `{{ list | selectattr }}` Filter\n\n**Select items** matching attribute condition.\n\n```jinja\n{{ list | selectattr("attribute", "value") }}\n```\n\n**Use cases:** Attribute filtering, conditional selection, data filtering',
      replacedOnClick: '| selectattr("attribute", "value")',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Round',
      description:
          '## `{{ value | round }}` Filter\n\n**Round number** to specified decimal places.\n\n```jinja\n{{ value | round(2) }}\n```\n\n**Use cases:** Decimal formatting, precision control, number rounding',
      replacedOnClick: '| round(2)',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Index Of By',
      description:
          '## `{{ list | indexOfBy }}` Filter\n\n**Find index** of item by attribute or condition.\n\n```jinja\n{{ list | indexOfBy("attribute", "value") }}\n```\n\n**Use cases:** Finding positions, index lookup, item location',
      replacedOnClick: '| indexOfBy("attribute", "value")',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Sublist',
      description:
          '## `{{ list | sublist }}` Filter\n\n**Get sublist** from a list.\n\n```jinja\n{{ list | sublist(0, 10) }}\n```\n\n**Use cases:** List slicing, pagination, range extraction',
      replacedOnClick: '| sublist(0, 10)',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'To Bool',
      description:
          '## `{{ value | toBool }}` Filter\n\n**Convert value** to boolean.\n\n```jinja\n{{ value | toBool }}\n```\n\n**Use cases:** Type conversion, boolean operations, truthiness checks',
      replacedOnClick: '| toBool',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Json Decode',
      description:
          '## `{{ value | jsonDecode }}` Filter\n\n**Decode JSON string** to object.\n\n```jinja\n{{ value | jsonDecode }}\n```\n\n**Use cases:** JSON parsing, data deserialization, API responses',
      replacedOnClick: '| jsonDecode',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Json Encode',
      description:
          '## `{{ value | jsonEncode }}` Filter\n\n**Encode value** to JSON string.\n\n```jinja\n{{ value | jsonEncode }}\n```\n\n**Use cases:** JSON serialization, data encoding, API requests',
      replacedOnClick: '| jsonEncode',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Is B64',
      description:
          '## `{{ value | isb64 }}` Filter\n\n**Check if value** is base64 encoded.\n\n```jinja\n{{ value | isb64 }}\n```\n\n**Use cases:** Encoding validation, format checking, data verification',
      replacedOnClick: '| isb64',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'B64 Encode',
      description:
          '## `{{ value | b64encode }}` Filter\n\n**Encode value** to base64.\n\n```jinja\n{{ value | b64encode }}\n```\n\n**Use cases:** Base64 encoding, data encoding, secure transmission',
      replacedOnClick: '| b64encode',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'B64 Decode',
      description:
          '## `{{ value | b64decode }}` Filter\n\n**Decode base64** string to original value.\n\n```jinja\n{{ value | b64decode }}\n```\n\n**Use cases:** Base64 decoding, data decoding, encoded content',
      replacedOnClick: '| b64decode',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Sub String',
      description:
          '## `{{ value | sub_string }}` Filter\n\n**Extract substring** from a string.\n\n```jinja\n{{ value | sub_string(0, 10) }}\n```\n\n**Use cases:** String slicing, text extraction, substring operations',
      replacedOnClick: '| sub_string(0, 10)',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'To String',
      description:
          '## `{{ value | to_string }}` Filter\n\n**Convert value** to string.\n\n```jinja\n{{ value | to_string }}\n```\n\n**Use cases:** Type conversion, string formatting, display formatting',
      replacedOnClick: '| to_string',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Split',
      description:
          '## `{{ value | split }}` Filter\n\n**Split string** into a list by delimiter.\n\n```jinja\n{{ value | split(",") }}\n```\n\n**Use cases:** String parsing, CSV processing, text splitting',
      replacedOnClick: '| split(",")',
      triggeredAt: '|',
    ),
    SuggestionModelJinja(
      label: 'Date Format',
      description:
          '## `{{ date | date_format }}` Filter\n\n**Format date** with specified format string.\n\n```jinja\n{{ date | date_format("%Y-%m-%d") }}\n```\n\n**Use cases:** Date formatting, time display, custom date formats',
      replacedOnClick: '| date_format("%Y-%m-%d")',
      triggeredAt: '|',
    ),
  ];
}
