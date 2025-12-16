import 'package:code_forge/code_forge.dart';
import 'package:code_forge/code_forge/controller.dart';

/// Returns Markdown-specific suggestions.
List<SuggestionModel> getMarkdownSuggestions() {
  return [
    SuggestionModel(
      label: 'Heading 1',
      description: 'Insert a level 1 heading',
      replacedOnClick: '# Heading 1',
      triggeredAt: '#',
    ),
    SuggestionModel(
      label: 'Heading 2',
      description: 'Insert a level 2 heading',
      replacedOnClick: '## Heading 2',
      triggeredAt: '##',
    ),
    SuggestionModel(
      label: 'Heading 3',
      description: 'Insert a level 3 heading',
      replacedOnClick: '### Heading 3',
      triggeredAt: '###',
    ),
    SuggestionModel(
      label: 'Heading 4',
      description: 'Insert a level 4 heading',
      replacedOnClick: '#### Heading 4',
      triggeredAt: '####',
    ),
    SuggestionModel(
      label: 'Bold Text',
      description: 'Insert bold text',
      replacedOnClick: '**bold text**',
      triggeredAt: '**',
    ),
    SuggestionModel(
      label: 'Italic Text',
      description: 'Insert italic text',
      replacedOnClick: '*italic text*',
      triggeredAt: '*',
    ),
    SuggestionModel(
      label: 'Bold Italic',
      description: 'Insert bold italic text',
      replacedOnClick: '***bold italic text***',
      triggeredAt: '***',
    ),
    SuggestionModel(
      label: 'Inline Code',
      description: 'Insert inline code',
      replacedOnClick: '`code`',
      triggeredAt: '`',
    ),
    SuggestionModel(
      label: 'Code Block',
      description: 'Insert a code block',
      replacedOnClick: '```\ncode here\n```',
      triggeredAt: '```',
    ),
    SuggestionModel(
      label: 'Code Block with Language',
      description: 'Insert a code block with language',
      replacedOnClick: '```language\ncode here\n```',
      triggeredAt: '```',
    ),
    SuggestionModel(
      label: 'Link',
      description: 'Insert a markdown link',
      replacedOnClick: '[link text](https://example.com)',
      triggeredAt: '[',
    ),
    SuggestionModel(
      label: 'Image',
      description: 'Insert an image',
      replacedOnClick: '![alt text](image-url.jpg)',
      triggeredAt: '![',
    ),
    SuggestionModel(
      label: 'Unordered List',
      description: 'Insert an unordered list item',
      replacedOnClick: '- List item',
      triggeredAt: '-',
    ),
    SuggestionModel(
      label: 'Ordered List',
      description: 'Insert an ordered list item',
      replacedOnClick: '1. List item',
      triggeredAt: '1.',
    ),
    SuggestionModel(
      label: 'Blockquote',
      description: 'Insert a blockquote',
      replacedOnClick: '> Quote text',
      triggeredAt: '>',
    ),
    SuggestionModel(
      label: 'Horizontal Rule',
      description: 'Insert a horizontal rule',
      replacedOnClick: '---',
      triggeredAt: '---',
    ),
    SuggestionModel(
      label: 'Table',
      description: 'Insert a markdown table',
      replacedOnClick:
          '| Header 1 | Header 2 |\n|----------|----------|\n| Cell 1   | Cell 2   |',
      triggeredAt: '|',
    ),
    SuggestionModel(
      label: 'Strikethrough',
      description: 'Insert strikethrough text',
      replacedOnClick: '~~strikethrough text~~',
      triggeredAt: '~~',
    ),
    SuggestionModel(
      label: 'Task List',
      description: 'Insert a task list item',
      replacedOnClick: '- [ ] Task item',
      triggeredAt: '- [',
    ),
    SuggestionModel(
      label: 'Checked Task',
      description: 'Insert a checked task item',
      replacedOnClick: '- [x] Completed task',
      triggeredAt: '- [',
    ),
    SuggestionModel(
      label: 'Reference Link',
      description: 'Insert a reference-style link',
      replacedOnClick:
          '[link text][reference]\n\n[reference]: https://example.com',
      triggeredAt: '[',
    ),
    SuggestionModel(
      label: 'Footnote',
      description: 'Insert a footnote',
      replacedOnClick: 'Text[^1]\n\n[^1]: Footnote text',
      triggeredAt: '[^',
    ),
  ];
}
