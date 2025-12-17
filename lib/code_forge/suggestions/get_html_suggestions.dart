import 'package:code_forge/code_forge/suggestion_model.dart';

/// Returns HTML-specific suggestions.
List<SuggestionModel> getHtmlSuggestions() {
  return [
    SuggestionModel(
      label: 'Div',
      description:
          '<h2>&lt;div&gt; Element</h2><p><strong>Block-level container</strong> for grouping and organizing content.</p><pre><code>&lt;div&gt;\n  &lt;!-- Content here --&gt;\n&lt;/div&gt;</code></pre><p><strong>Common uses:</strong></p><ul><li>Layout structure</li><li>Content grouping</li><li>Styling containers</li></ul>',
      replacedOnClick: '<div>\n  \n</div>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Span',
      description:
          '<h2>&lt;span&gt; Element</h2><p><strong>Inline container</strong> for text styling and grouping.</p><pre><code>&lt;span&gt;Inline content&lt;/span&gt;</code></pre><p><strong>Common uses:</strong></p><ul><li>Text styling</li><li>Inline content grouping</li><li>Applying CSS to portions of text</li></ul>',
      replacedOnClick: '<span></span>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Link',
      description:
          '<h2>&lt;a&gt; Anchor Link</h2><p><strong>Hyperlink</strong> for navigation to other pages or sections.</p><pre><code>&lt;a href=&quot;https://example.com&quot;&gt;Link Text&lt;/a&gt;</code></pre><p><strong>Key attributes:</strong></p><ul><li><code>href</code> &mdash; URL or anchor target</li><li><code>target</code> &mdash; Open in new window (<code>_blank</code>)</li><li><code>rel</code> &mdash; Relationship type (e.g., <code>noopener</code>)</li></ul>',
      replacedOnClick: '<a href="">Link Text</a>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Image',
      description:
          '<h2>&lt;img&gt; Image Element</h2><p><strong>Embeds an image</strong> in the document.</p><pre><code>&lt;img src=&quot;image.jpg&quot; alt=&quot;Description&quot; /&gt;</code></pre><p><strong>Required:</strong></p><ul><li><code>src</code> &mdash; Image URL or path</li><li><code>alt</code> &mdash; Alternative text for accessibility</li></ul><p><strong>Optional:</strong> <code>width</code>, <code>height</code>, <code>loading=&quot;lazy&quot;</code>, <code>srcset</code></p>',
      replacedOnClick: '<img src="" alt="" />',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Paragraph',
      description:
          '<h2>&lt;p&gt; Paragraph</h2><p><strong>Block-level element</strong> for text paragraphs.</p><pre><code>&lt;p&gt;Paragraph text content&lt;/p&gt;</code></pre><p><strong>Semantic meaning:</strong> Represents a distinct paragraph of text content.</p>',
      replacedOnClick: '<p>\n  \n</p>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Heading 1',
      description:
          '<h2>&lt;h1&gt; Heading Level 1</h2><p><strong>Main page title</strong> &mdash; highest heading level.</p><pre><code>&lt;h1&gt;Main Title&lt;/h1&gt;</code></pre><p><strong>Best practice:</strong> Use <strong>one</strong> <code>&lt;h1&gt;</code> per page for optimal SEO and accessibility.</p>',
      replacedOnClick: '<h1>\n  \n</h1>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Heading 2',
      description:
          '<h2>&lt;h2&gt; Heading Level 2</h2><p><strong>Section heading</strong> &mdash; second level in the document hierarchy.</p><pre><code>&lt;h2&gt;Section Title&lt;/h2&gt;</code></pre><p><strong>Hierarchy:</strong> <code>&lt;h1&gt;</code> &rarr; <code>&lt;h2&gt;</code> &rarr; <code>&lt;h3&gt;</code> &rarr; ...</p>',
      replacedOnClick: '<h2>\n  \n</h2>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Button',
      description:
          '<h2>&lt;button&gt; Element</h2><p><strong>Clickable button</strong> for user interactions.</p><pre><code>&lt;button type=&quot;button&quot;&gt;Click Me&lt;/button&gt;</code></pre><p><strong>Button types:</strong></p><ul><li><code>type=&quot;button&quot;</code> &mdash; Standard clickable button</li><li><code>type=&quot;submit&quot;</code> &mdash; Submits a form</li><li><code>type=&quot;reset&quot;</code> &mdash; Resets form fields</li></ul>',
      replacedOnClick: '<button type="button">Button Text</button>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Input',
      description:
          '<h2>&lt;input&gt; Element</h2><p><strong>Form input field</strong> for user data entry.</p><pre><code>&lt;input type=&quot;text&quot; name=&quot;username&quot; value=&quot;&quot; /&gt;</code></pre><p><strong>Common input types:</strong></p><ul><li><code>text</code> &mdash; Single-line text input</li><li><code>email</code> &mdash; Email with validation</li><li><code>password</code> &mdash; Masked password field</li><li><code>number</code> &mdash; Numeric input</li><li><code>checkbox</code> &mdash; Checkbox toggle</li><li><code>radio</code> &mdash; Radio button</li><li><code>date</code> &mdash; Date picker</li><li><code>file</code> &mdash; File upload</li></ul>',
      replacedOnClick: '<input type="text" name="" value="" />',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Form',
      description:
          '<h2>&lt;form&gt; Element</h2><p><strong>Container</strong> for form inputs and submission handling.</p><pre><code>&lt;form action=&quot;/submit&quot; method=&quot;post&quot;&gt;\n  &lt;!-- Form fields --&gt;\n&lt;/form&gt;</code></pre><p><strong>Key attributes:</strong></p><ul><li><code>action</code> &mdash; Submission URL endpoint</li><li><code>method</code> &mdash; HTTP method (<code>get</code> or <code>post</code>)</li><li><code>enctype</code> &mdash; Encoding type (use <code>multipart/form-data</code> for file uploads)</li></ul>',
      replacedOnClick: '<form action="" method="post">\n  \n</form>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'List',
      description:
          '<h2>&lt;ul&gt; Unordered List</h2><p><strong>Bulleted list</strong> for items without specific order.</p><pre><code>&lt;ul&gt;\n  &lt;li&gt;Item 1&lt;/li&gt;\n  &lt;li&gt;Item 2&lt;/li&gt;\n&lt;/ul&gt;</code></pre><p><strong>Styling:</strong> Use CSS to customize bullet styles (disc, circle, square, or custom).</p>',
      replacedOnClick: '<ul>\n  <li></li>\n</ul>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Ordered List',
      description:
          '<h2>&lt;ol&gt; Ordered List</h2><p><strong>Numbered list</strong> for sequential or ordered items.</p><pre><code>&lt;ol&gt;\n  &lt;li&gt;First item&lt;/li&gt;\n  &lt;li&gt;Second item&lt;/li&gt;\n&lt;/ol&gt;</code></pre><p><strong>Attributes:</strong> <code>start</code>, <code>reversed</code>, <code>type</code> (1, A, a, I, i)</p>',
      replacedOnClick: '<ol>\n  <li></li>\n</ol>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Table',
      description:
          '<h2>&lt;table&gt; Element</h2><p><strong>Structured data table</strong> with rows and columns.</p><pre><code>&lt;table&gt;\n  &lt;tr&gt;\n    &lt;th&gt;Header&lt;/th&gt;\n  &lt;/tr&gt;\n  &lt;tr&gt;\n    &lt;td&gt;Data&lt;/td&gt;\n  &lt;/tr&gt;\n&lt;/table&gt;</code></pre><p><strong>Best structure:</strong> Use <code>&lt;thead&gt;</code>, <code>&lt;tbody&gt;</code>, and <code>&lt;tfoot&gt;</code> for better organization and accessibility.</p>',
      replacedOnClick:
          '<table>\n  <tr>\n    <th></th>\n  </tr>\n  <tr>\n    <td></td>\n  </tr>\n</table>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Script',
      description:
          '<h2>&lt;script&gt; Element</h2><p><strong>Embeds JavaScript</strong> code or references external scripts.</p><pre><code>&lt;script&gt;\n  console.log(&quot;Hello World&quot;);\n&lt;/script&gt;</code></pre><p><strong>External script:</strong></p><pre><code>&lt;script src=&quot;app.js&quot;&gt;&lt;/script&gt;</code></pre><p><strong>Attributes:</strong> <code>src</code>, <code>type</code>, <code>async</code>, <code>defer</code></p>',
      replacedOnClick: '<script>\n  \n</script>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Style',
      description:
          '<h2>&lt;style&gt; Element</h2><p><strong>Embeds CSS</strong> styles directly in the document.</p><pre><code>&lt;style&gt;\n  body { color: #333; }\n&lt;/style&gt;</code></pre><p><strong>Best practice:</strong> Use external stylesheets via <code>&lt;link&gt;</code> for better organization and caching.</p>',
      replacedOnClick: '<style>\n  \n</style>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Meta',
      description:
          '<h2>&lt;meta&gt; Element</h2><p><strong>Metadata</strong> about the HTML document.</p><pre><code>&lt;meta name=&quot;description&quot; content=&quot;Page description&quot; /&gt;</code></pre><p><strong>Common uses:</strong></p><ul><li><code>charset</code> &mdash; Character encoding (UTF-8)</li><li><code>viewport</code> &mdash; Responsive design settings</li><li><code>description</code> &mdash; SEO description</li><li><code>keywords</code> &mdash; SEO keywords</li><li><code>author</code> &mdash; Page author information</li></ul>',
      replacedOnClick: '<meta name="" content="" />',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Link CSS',
      description:
          '<h2>&lt;link&gt; Stylesheet</h2><p><strong>Links external CSS</strong> stylesheet to the document.</p><pre><code>&lt;link rel=&quot;stylesheet&quot; href=&quot;styles.css&quot; /&gt;</code></pre><p><strong>Key attributes:</strong></p><ul><li><code>rel=&quot;stylesheet&quot;</code> &mdash; Stylesheet relationship</li><li><code>href</code> &mdash; CSS file URL or path</li><li><code>media</code> &mdash; Media query (e.g., <code>print</code>, <code>screen</code>)</li></ul>',
      replacedOnClick: '<link rel="stylesheet" href="" />',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Section',
      description:
          '<h2>&lt;section&gt; Element</h2><p><strong>Semantic container</strong> for thematic content grouping.</p><pre><code>&lt;section&gt;\n  &lt;h2&gt;Section Title&lt;/h2&gt;\n  &lt;!-- Content --&gt;\n&lt;/section&gt;</code></pre><p><strong>Common uses:</strong> Chapters, topics, distinct content areas, document sections.</p>',
      replacedOnClick: '<section>\n  \n</section>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Article',
      description:
          '<h2>&lt;article&gt; Element</h2><p><strong>Self-contained content</strong> that can be independently distributed.</p><pre><code>&lt;article&gt;\n  &lt;h2&gt;Article Title&lt;/h2&gt;\n  &lt;p&gt;Article content...&lt;/p&gt;\n&lt;/article&gt;</code></pre><p><strong>Common uses:</strong> Blog posts, news articles, forum posts, product cards.</p>',
      replacedOnClick: '<article>\n  \n</article>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Header',
      description:
          '<h2>&lt;header&gt; Element</h2><p><strong>Header section</strong> containing introductory content.</p><pre><code>&lt;header&gt;\n  &lt;h1&gt;Site Title&lt;/h1&gt;\n  &lt;nav&gt;...&lt;/nav&gt;\n&lt;/header&gt;</code></pre><p><strong>Typically contains:</strong> Logo, navigation, site title, search bar.</p>',
      replacedOnClick: '<header>\n  \n</header>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Footer',
      description:
          '<h2>&lt;footer&gt; Element</h2><p><strong>Footer section</strong> with closing information.</p><pre><code>&lt;footer&gt;\n  &lt;p&gt;Copyright &copy; 2024&lt;/p&gt;\n&lt;/footer&gt;</code></pre><p><strong>Typically contains:</strong> Copyright, links, contact information, social media.</p>',
      replacedOnClick: '<footer>\n  \n</footer>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Nav',
      description:
          '<h2>&lt;nav&gt; Element</h2><p><strong>Navigation section</strong> with links to other pages.</p><pre><code>&lt;nav&gt;\n  &lt;a href=&quot;/&quot;&gt;Home&lt;/a&gt;\n  &lt;a href=&quot;/about&quot;&gt;About&lt;/a&gt;\n&lt;/nav&gt;</code></pre><p><strong>Semantic meaning:</strong> Main navigation links and site structure.</p>',
      replacedOnClick: '<nav>\n  \n</nav>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Heading 3',
      description:
          '<h2>&lt;h3&gt; Heading Level 3</h2><p><strong>Subsection heading</strong> &mdash; third level in the document hierarchy.</p><pre><code>&lt;h3&gt;Subsection Title&lt;/h3&gt;</code></pre><p><strong>Semantic structure:</strong> Part of the document outline and accessibility tree.</p>',
      replacedOnClick: '<h3>\n  \n</h3>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Heading 4',
      description:
          '<h2>&lt;h4&gt; Heading Level 4</h2><p><strong>Sub-subsection heading</strong> &mdash; fourth level in the document hierarchy.</p><pre><code>&lt;h4&gt;Minor Section&lt;/h4&gt;</code></pre><p><strong>Best practice:</strong> Continue heading levels sequentially without skipping levels.</p>',
      replacedOnClick: '<h4>\n  \n</h4>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Heading 5',
      description:
          '<h2>&lt;h5&gt; Heading Level 5</h2><p><strong>Minor heading</strong> &mdash; fifth level in the document hierarchy.</p><pre><code>&lt;h5&gt;Small Section&lt;/h5&gt;</code></pre><p><strong>Common usage:</strong> For deeply nested content sections and subsections.</p>',
      replacedOnClick: '<h5>\n  \n</h5>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Heading 6',
      description:
          '<h2>&lt;h6&gt; Heading Level 6</h2><p><strong>Smallest heading</strong> &mdash; sixth and final level in HTML.</p><pre><code>&lt;h6&gt;Smallest Heading&lt;/h6&gt;</code></pre><p><strong>Note:</strong> This is the lowest heading level available in HTML.</p>',
      replacedOnClick: '<h6>\n  \n</h6>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'List Item',
      description:
          '<h2>&lt;li&gt; List Item</h2><p><strong>Individual item</strong> in ordered or unordered lists.</p><pre><code>&lt;li&gt;List item content&lt;/li&gt;</code></pre><p><strong>Parent elements:</strong> Must be inside <code>&lt;ul&gt;</code>, <code>&lt;ol&gt;</code>, or <code>&lt;menu&gt;</code>.</p>',
      replacedOnClick: '<li></li>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Label',
      description:
          '<h2>&lt;label&gt; Element</h2><p><strong>Associates text</strong> with form input for accessibility.</p><pre><code>&lt;label for=&quot;username&quot;&gt;Username:&lt;/label&gt;\n&lt;input id=&quot;username&quot; type=&quot;text&quot; /&gt;</code></pre><p><strong>Key benefits:</strong></p><ul><li><strong>Accessibility</strong> &mdash; Screen reader support</li><li><strong>Usability</strong> &mdash; Click label to focus input</li><li><strong>Form validation</strong> &mdash; Better error association</li></ul>',
      replacedOnClick: '<label for="">Label Text</label>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Textarea',
      description:
          '<h2>&lt;textarea&gt; Element</h2><p><strong>Multi-line text input</strong> for longer content.</p><pre><code>&lt;textarea name=&quot;message&quot; rows=&quot;4&quot; cols=&quot;50&quot;&gt;\n  Default text\n&lt;/textarea&gt;</code></pre><p><strong>Key attributes:</strong></p><ul><li><code>rows</code> &mdash; Visible height in lines</li><li><code>cols</code> &mdash; Visible width in characters</li><li><code>placeholder</code> &mdash; Hint text</li><li><code>maxlength</code> &mdash; Maximum character count</li></ul>',
      replacedOnClick: '<textarea name="" rows="4" cols="50"></textarea>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Select',
      description:
          '<h2>&lt;select&gt; Dropdown</h2><p><strong>Dropdown menu</strong> for selecting from predefined options.</p><pre><code>&lt;select name=&quot;country&quot;&gt;\n  &lt;option value=&quot;us&quot;&gt;United States&lt;/option&gt;\n  &lt;option value=&quot;uk&quot;&gt;United Kingdom&lt;/option&gt;\n&lt;/select&gt;</code></pre><p><strong>Key attributes:</strong> <code>name</code>, <code>multiple</code>, <code>size</code>, <code>required</code>, <code>disabled</code></p>',
      replacedOnClick:
          '<select name="">\n  <option value="">Option</option>\n</select>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Option',
      description:
          '<h2>&lt;option&gt; Element</h2><p><strong>Choice</strong> within a <code>&lt;select&gt;</code> dropdown.</p><pre><code>&lt;option value=&quot;value&quot;&gt;Display Text&lt;/option&gt;</code></pre><p><strong>Key attributes:</strong></p><ul><li><code>value</code> &mdash; Submitted value (required)</li><li><code>selected</code> &mdash; Pre-selected option</li><li><code>disabled</code> &mdash; Disabled option</li></ul>',
      replacedOnClick: '<option value="">Option Text</option>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Fieldset',
      description:
          '<h2>&lt;fieldset&gt; Element</h2><p><strong>Groups related form controls</strong> together.</p><pre><code>&lt;fieldset&gt;\n  &lt;legend&gt;Personal Information&lt;/legend&gt;\n  &lt;!-- Form fields --&gt;\n&lt;/fieldset&gt;</code></pre><p><strong>Key benefits:</strong> Visual grouping, semantic organization, and improved accessibility.</p>',
      replacedOnClick: '<fieldset>\n  <legend>Legend</legend>\n  \n</fieldset>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Legend',
      description:
          '<h2>&lt;legend&gt; Element</h2><p><strong>Caption</strong> for a <code>&lt;fieldset&gt;</code> element.</p><pre><code>&lt;legend&gt;Section Title&lt;/legend&gt;</code></pre><p><strong>Purpose:</strong> Describes the purpose of the fieldset group and improves accessibility.</p>',
      replacedOnClick: '<legend>Legend Text</legend>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Strong',
      description:
          '<h2>&lt;strong&gt; Element</h2><p><strong>Semantic bold</strong> text indicating strong importance.</p><pre><code>&lt;strong&gt;Important text&lt;/strong&gt;</code></pre><p><strong>Semantic meaning:</strong> Conveys importance and urgency, preferred over <code>&lt;b&gt;</code> for accessibility.</p>',
      replacedOnClick: '<strong>Bold Text</strong>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Emphasis',
      description:
          '<h2>&lt;em&gt; Element</h2><p><strong>Semantic italic</strong> text indicating emphasis.</p><pre><code>&lt;em&gt;Emphasized text&lt;/em&gt;</code></pre><p><strong>Semantic meaning:</strong> Stressed emphasis with proper semantic meaning, preferred over <code>&lt;i&gt;</code> for accessibility.</p>',
      replacedOnClick: '<em>Italic Text</em>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Bold',
      description:
          '<h2>&lt;b&gt; Element</h2><p><strong>Visual bold</strong> text without semantic meaning.</p><pre><code>&lt;b&gt;Bold text&lt;/b&gt;</code></pre><p><strong>Note:</strong> Use <code>&lt;strong&gt;</code> for semantic importance. Use <code>&lt;b&gt;</code> only for stylistic purposes.</p>',
      replacedOnClick: '<b>Bold Text</b>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Italic',
      description:
          '<h2>&lt;i&gt; Element</h2><p><strong>Visual italic</strong> text without semantic meaning.</p><pre><code>&lt;i&gt;Italic text&lt;/i&gt;</code></pre><p><strong>Note:</strong> Use <code>&lt;em&gt;</code> for semantic emphasis. Use <code>&lt;i&gt;</code> only for stylistic purposes (e.g., foreign words, technical terms).</p>',
      replacedOnClick: '<i>Italic Text</i>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Code',
      description:
          '<h2>&lt;code&gt; Element</h2><p><strong>Inline code</strong> snippet for technical terms and code references.</p><pre><code>&lt;code&gt;functionName()&lt;/code&gt;</code></pre><p><strong>Styling:</strong> Typically displayed in monospace font. Use <code>&lt;pre&gt;&lt;code&gt;</code> for code blocks.</p>',
      replacedOnClick: '<code>code</code>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Pre',
      description:
          '<h2>&lt;pre&gt; Element</h2><p><strong>Preformatted text</strong> preserving whitespace and line breaks.</p><pre><code>&lt;pre&gt;\n  function example() {\n    return true;\n  }\n&lt;/pre&gt;</code></pre><p><strong>Common uses:</strong> Code blocks (often with <code>&lt;code&gt;</code>), ASCII art, formatted text, poetry.</p>',
      replacedOnClick: '<pre>\n  \n</pre>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Blockquote',
      description:
          '<h2>&lt;blockquote&gt; Element</h2><p><strong>Block quotation</strong> from another source.</p><pre><code>&lt;blockquote&gt;\n  &lt;p&gt;Quoted text here&lt;/p&gt;\n  &lt;cite&gt;&mdash; Source Name&lt;/cite&gt;\n&lt;/blockquote&gt;</code></pre><p><strong>Attribute:</strong> <code>cite</code> &mdash; Source URL for the quotation.</p>',
      replacedOnClick: '<blockquote>\n  \n</blockquote>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Line Break',
      description:
          '<h2>&lt;br&gt; Element</h2><p><strong>Line break</strong> &mdash; forces a new line.</p><pre><code>Line one&lt;br /&gt;\nLine two</code></pre><p><strong>Note:</strong> Self-closing element. Use sparingly; prefer semantic HTML like <code>&lt;p&gt;</code> for paragraphs.</p>',
      replacedOnClick: '<br />',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Horizontal Rule',
      description:
          '<h2>&lt;hr&gt; Element</h2><p><strong>Horizontal rule</strong> &mdash; thematic break between sections.</p><pre><code>&lt;section&gt;Content&lt;/section&gt;\n&lt;hr /&gt;\n&lt;section&gt;More content&lt;/section&gt;</code></pre><p><strong>Visual:</strong> Creates a horizontal line separator. Use for topic changes, not just styling.</p>',
      replacedOnClick: '<hr />',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Aside',
      description:
          '<h2>&lt;aside&gt; Element</h2><p><strong>Sidebar content</strong> tangentially related to main content.</p><pre><code>&lt;aside&gt;\n  &lt;h3&gt;Related Links&lt;/h3&gt;\n  &lt;!-- Sidebar content --&gt;\n&lt;/aside&gt;</code></pre><p><strong>Common uses:</strong> Sidebars, callouts, advertisements, related links, author information.</p>',
      replacedOnClick: '<aside>\n  \n</aside>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Main',
      description:
          '<h2>&lt;main&gt; Element</h2><p><strong>Main content</strong> area of the document.</p><pre><code>&lt;main&gt;\n  &lt;article&gt;...&lt;/article&gt;\n&lt;/main&gt;</code></pre><p><strong>Best practice:</strong> Use <strong>one</strong> <code>&lt;main&gt;</code> per page for accessibility and semantic structure.</p>',
      replacedOnClick: '<main>\n  \n</main>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Details',
      description:
          '<h2>&lt;details&gt; Element</h2><p><strong>Collapsible disclosure widget</strong> showing/hiding content.</p><pre><code>&lt;details&gt;\n  &lt;summary&gt;Click to expand&lt;/summary&gt;\n  &lt;p&gt;Hidden content here&lt;/p&gt;\n&lt;/details&gt;</code></pre><p><strong>Attribute:</strong> <code>open</code> &mdash; Expanded by default when present.</p>',
      replacedOnClick:
          '<details>\n  <summary>Summary</summary>\n  \n</details>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Summary',
      description:
          '<h2>&lt;summary&gt; Element</h2><p><strong>Clickable summary</strong> for <code>&lt;details&gt;</code> element.</p><pre><code>&lt;summary&gt;Show more&lt;/summary&gt;</code></pre><p><strong>Purpose:</strong> Label for collapsible content. Must be the first child of <code>&lt;details&gt;</code>.</p>',
      replacedOnClick: '<summary>Summary Text</summary>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Figure',
      description:
          '<h2>&lt;figure&gt; Element</h2><p><strong>Self-contained content</strong> with optional caption.</p><pre><code>&lt;figure&gt;\n  &lt;img src=&quot;image.jpg&quot; alt=&quot;Description&quot; /&gt;\n  &lt;figcaption&gt;Image caption&lt;/figcaption&gt;\n&lt;/figure&gt;</code></pre><p><strong>Common uses:</strong> Images, diagrams, code snippets, quotes, illustrations.</p>',
      replacedOnClick:
          '<figure>\n  \n  <figcaption>Caption</figcaption>\n</figure>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Figcaption',
      description:
          '<h2>&lt;figcaption&gt; Element</h2><p><strong>Caption</strong> for a <code>&lt;figure&gt;</code> element.</p><pre><code>&lt;figcaption&gt;Description of the figure&lt;/figcaption&gt;</code></pre><p><strong>Placement:</strong> First or last child of <code>&lt;figure&gt;</code>. Only one <code>&lt;figcaption&gt;</code> per <code>&lt;figure&gt;</code>.</p>',
      replacedOnClick: '<figcaption>Caption Text</figcaption>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Table Head',
      description:
          '<h2>&lt;thead&gt; Element</h2><p><strong>Header section</strong> of a table with column headers.</p><pre><code>&lt;thead&gt;\n  &lt;tr&gt;\n    &lt;th&gt;Column 1&lt;/th&gt;\n    &lt;th&gt;Column 2&lt;/th&gt;\n  &lt;/tr&gt;\n&lt;/thead&gt;</code></pre><p><strong>Contains:</strong> Header rows with <code>&lt;th&gt;</code> elements. Improves accessibility and allows for scrolling headers.</p>',
      replacedOnClick: '<thead>\n  <tr>\n    <th></th>\n  </tr>\n</thead>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Table Body',
      description:
          '<h2>&lt;tbody&gt; Element</h2><p><strong>Body section</strong> containing main table data.</p><pre><code>&lt;tbody&gt;\n  &lt;tr&gt;\n    &lt;td&gt;Data 1&lt;/td&gt;\n    &lt;td&gt;Data 2&lt;/td&gt;\n  &lt;/tr&gt;\n&lt;/tbody&gt;</code></pre><p><strong>Contains:</strong> Data rows with <code>&lt;td&gt;</code> elements. Can have multiple <code>&lt;tbody&gt;</code> sections for grouping.</p>',
      replacedOnClick: '<tbody>\n  <tr>\n    <td></td>\n  </tr>\n</tbody>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Table Foot',
      description:
          '<h2>&lt;tfoot&gt; Element</h2><p><strong>Footer section</strong> with summary rows.</p><pre><code>&lt;tfoot&gt;\n  &lt;tr&gt;\n    &lt;td&gt;Total&lt;/td&gt;\n    &lt;td&gt;\$100&lt;/td&gt;\n  &lt;/tr&gt;\n&lt;/tfoot&gt;</code></pre><p><strong>Common uses:</strong> Totals, summaries, footnotes, column summaries.</p>',
      replacedOnClick: '<tfoot>\n  <tr>\n    <td></td>\n  </tr>\n</tfoot>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Table Row',
      description:
          '<h2>&lt;tr&gt; Element</h2><p><strong>Table row</strong> containing cells.</p><pre><code>&lt;tr&gt;\n  &lt;td&gt;Cell 1&lt;/td&gt;\n  &lt;td&gt;Cell 2&lt;/td&gt;\n&lt;/tr&gt;</code></pre><p><strong>Contains:</strong> <code>&lt;th&gt;</code> (header cells) or <code>&lt;td&gt;</code> (data cells). Must be inside <code>&lt;table&gt;</code>, <code>&lt;thead&gt;</code>, <code>&lt;tbody&gt;</code>, or <code>&lt;tfoot&gt;</code>.</p>',
      replacedOnClick: '<tr>\n  <td></td>\n</tr>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Table Header Cell',
      description:
          '<h2>&lt;th&gt; Element</h2><p><strong>Header cell</strong> in table header row.</p><pre><code>&lt;th&gt;Column Name&lt;/th&gt;</code></pre><p><strong>Key attributes:</strong> <code>colspan</code>, <code>rowspan</code>, <code>scope</code> (row, col, rowgroup, colgroup)</p><p><strong>Styling:</strong> Bold and centered by default. Use <code>scope</code> for accessibility.</p>',
      replacedOnClick: '<th></th>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Table Data Cell',
      description:
          '<h2>&lt;td&gt; Element</h2><p><strong>Data cell</strong> containing table content.</p><pre><code>&lt;td&gt;Cell content&lt;/td&gt;</code></pre><p><strong>Key attributes:</strong> <code>colspan</code>, <code>rowspan</code> for merging cells</p><p><strong>Styling:</strong> Regular text alignment (left by default).</p>',
      replacedOnClick: '<td></td>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Table Caption',
      description:
          '<h2>&lt;caption&gt; Element</h2><p><strong>Title or description</strong> for a table.</p><pre><code>&lt;caption&gt;Table Title&lt;/caption&gt;</code></pre><p><strong>Placement:</strong> First child of <code>&lt;table&gt;</code> element. Improves accessibility and provides context.</p>',
      replacedOnClick: '<caption>Caption Text</caption>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Video',
      description:
          '<h2>&lt;video&gt; Element</h2><p><strong>Embeds video</strong> content with native controls.</p><pre><code>&lt;video width=&quot;640&quot; height=&quot;360&quot; controls&gt;\n  &lt;source src=&quot;video.mp4&quot; type=&quot;video/mp4&quot;&gt;\n  Your browser does not support video.\n&lt;/video&gt;</code></pre><p><strong>Key attributes:</strong></p><ul><li><code>controls</code> &mdash; Show playback controls</li><li><code>autoplay</code> &mdash; Auto-play video (requires <code>muted</code>)</li><li><code>loop</code> &mdash; Loop video playback</li><li><code>muted</code> &mdash; Mute audio by default</li><li><code>poster</code> &mdash; Thumbnail image URL</li></ul>',
      replacedOnClick:
          '<video width="" height="" controls>\n  <source src="" type="video/mp4">\n</video>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Audio',
      description:
          '<h2>&lt;audio&gt; Element</h2><p><strong>Embeds audio</strong> content with native controls.</p><pre><code>&lt;audio controls&gt;\n  &lt;source src=&quot;audio.mp3&quot; type=&quot;audio/mpeg&quot;&gt;\n  Your browser does not support audio.\n&lt;/audio&gt;</code></pre><p><strong>Key attributes:</strong></p><ul><li><code>controls</code> &mdash; Show playback controls</li><li><code>autoplay</code> &mdash; Auto-play audio (may be blocked by browsers)</li><li><code>loop</code> &mdash; Loop audio playback</li><li><code>muted</code> &mdash; Mute audio by default</li></ul>',
      replacedOnClick:
          '<audio controls>\n  <source src="" type="audio/mpeg">\n</audio>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Source',
      description:
          '<h2>&lt;source&gt; Element</h2><p><strong>Media source</strong> for <code>&lt;video&gt;</code>, <code>&lt;audio&gt;</code>, and <code>&lt;picture&gt;</code> elements.</p><pre><code>&lt;source src=&quot;media.mp4&quot; type=&quot;video/mp4&quot; /&gt;</code></pre><p><strong>Key attributes:</strong></p><ul><li><code>src</code> &mdash; Media URL or path</li><li><code>type</code> &mdash; MIME type (e.g., <code>video/mp4</code>, <code>audio/mpeg</code>)</li><li><code>media</code> &mdash; Media query for responsive images (in <code>&lt;picture&gt;</code>)</li></ul>',
      replacedOnClick: '<source src="" type="" />',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Canvas',
      description:
          '<h2>&lt;canvas&gt; Element</h2><p><strong>Drawing surface</strong> for JavaScript graphics and animations.</p><pre><code>&lt;canvas id=&quot;myCanvas&quot; width=&quot;800&quot; height=&quot;600&quot;&gt;&lt;/canvas&gt;</code></pre><p><strong>Usage:</strong></p><pre><code>const ctx = canvas.getContext(&quot;2d&quot;);\nctx.fillRect(10, 10, 100, 100);</code></pre><p><strong>Common uses:</strong> Charts, games, animations, image manipulation, data visualization.</p>',
      replacedOnClick: '<canvas id="" width="" height=""></canvas>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'SVG',
      description:
          '<h2>&lt;svg&gt; Element</h2><p><strong>Scalable Vector Graphics</strong> container for vector-based graphics.</p><pre><code>&lt;svg width=&quot;100&quot; height=&quot;100&quot;&gt;\n  &lt;circle cx=&quot;50&quot; cy=&quot;50&quot; r=&quot;40&quot; fill=&quot;blue&quot; /&gt;\n&lt;/svg&gt;</code></pre><p><strong>Key benefits:</strong></p><ul><li><strong>Scalable</strong> &mdash; No quality loss at any size</li><li><strong>Stylable</strong> &mdash; Can be styled with CSS</li><li><strong>Accessible</strong> &mdash; Supports ARIA attributes and text alternatives</li></ul>',
      replacedOnClick: '<svg width="" height="">\n  \n</svg>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Iframe',
      description:
          '<h2>&lt;iframe&gt; Element</h2><p><strong>Inline frame</strong> embedding another HTML page.</p><pre><code>&lt;iframe src=&quot;https://example.com&quot; width=&quot;800&quot; height=&quot;600&quot;&gt;&lt;/iframe&gt;</code></pre><p><strong>Key attributes:</strong></p><ul><li><code>src</code> &mdash; Page URL to embed</li><li><code>width</code>, <code>height</code> &mdash; Frame dimensions</li><li><code>sandbox</code> &mdash; Security restrictions (recommended)</li><li><code>allow</code> &mdash; Permissions policy (e.g., <code>camera</code>, <code>microphone</code>)</li></ul><p><strong>Note:</strong> <code>frameborder</code> is deprecated; use CSS instead.</p>',
      replacedOnClick: '<iframe src="" width="" height=""></iframe>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Embed',
      description:
          '<h2>&lt;embed&gt; Element</h2><p><strong>Embeds external content</strong> or plugin (legacy element).</p><pre><code>&lt;embed src=&quot;plugin.swf&quot; width=&quot;400&quot; height=&quot;300&quot; /&gt;</code></pre><p><strong>Note:</strong> Consider using <code>&lt;iframe&gt;</code> or modern alternatives. Limited browser support for plugins.</p>',
      replacedOnClick: '<embed src="" width="" height="" />',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Object',
      description:
          '<h2>&lt;object&gt; Element</h2><p><strong>Embeds external resource</strong> or plugin.</p><pre><code>&lt;object data=&quot;file.pdf&quot; width=&quot;800&quot; height=&quot;600&quot;&gt;\n  &lt;param name=&quot;autoplay&quot; value=&quot;true&quot; /&gt;\n&lt;/object&gt;</code></pre><p><strong>Common uses:</strong> PDFs, Flash content (legacy), plugins</p><p><strong>Fallback:</strong> Content inside tag is shown if object fails to load.</p>',
      replacedOnClick: '<object data="" width="" height=""></object>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Title',
      description:
          '<h2>&lt;title&gt; Element</h2><p><strong>Page title</strong> shown in browser tab and search results.</p><pre><code>&lt;title&gt;My Website - Home Page&lt;/title&gt;</code></pre><p><strong>SEO importance:</strong> Critical for search engine optimization and user experience.</p><p><strong>Placement:</strong> Must be inside <code>&lt;head&gt;</code> element. Only one <code>&lt;title&gt;</code> per document.</p>',
      replacedOnClick: '<title>Page Title</title>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Head',
      description:
          '<h2>&lt;head&gt; Element</h2><p><strong>Document metadata</strong> container (not displayed in page).</p><pre><code>&lt;head&gt;\n  &lt;meta charset=&quot;UTF-8&quot;&gt;\n  &lt;title&gt;Page Title&lt;/title&gt;\n  &lt;link rel=&quot;stylesheet&quot; href=&quot;styles.css&quot; /&gt;\n&lt;/head&gt;</code></pre><p><strong>Typically contains:</strong> Meta tags, title, links, scripts, styles.</p>',
      replacedOnClick:
          '<head>\n  <meta charset="UTF-8">\n  <title>Title</title>\n</head>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Body',
      description:
          '<h2>&lt;body&gt; Element</h2><p><strong>Main content</strong> area visible to users.</p><pre><code>&lt;body&gt;\n  &lt;header&gt;...&lt;/header&gt;\n  &lt;main&gt;...&lt;/main&gt;\n  &lt;footer&gt;...&lt;/footer&gt;\n&lt;/body&gt;</code></pre><p><strong>Contains:</strong> All visible page content. Only one <code>&lt;body&gt;</code> per document.</p>',
      replacedOnClick: '<body>\n  \n</body>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'HTML',
      description:
          '<h2>Complete HTML Document</h2><p><strong>Full HTML5 document structure</strong> with all essential elements.</p><pre><code>&lt;!DOCTYPE html&gt;\n&lt;html lang=&quot;en&quot;&gt;\n&lt;head&gt;\n  &lt;meta charset=&quot;UTF-8&quot;&gt;\n  &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width&quot;&gt;\n  &lt;title&gt;Document&lt;/title&gt;\n&lt;/head&gt;\n&lt;body&gt;\n  &lt;!-- Content --&gt;\n&lt;/body&gt;\n&lt;/html&gt;</code></pre><p><strong>Includes:</strong> DOCTYPE declaration, <code>&lt;html&gt;</code>, <code>&lt;head&gt;</code>, and <code>&lt;body&gt;</code> elements.</p>',
      replacedOnClick:
          '<!DOCTYPE html>\n<html lang="en">\n<head>\n  <meta charset="UTF-8">\n  <title>Document</title>\n</head>\n<body>\n  \n</body>\n</html>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Mark',
      description:
          '<h2>&lt;mark&gt; Element</h2><p><strong>Highlighted text</strong> for emphasis or search results.</p><pre><code>&lt;mark&gt;Highlighted content&lt;/mark&gt;</code></pre><p><strong>Styling:</strong> Yellow background by default (customizable with CSS).</p><p><strong>Common uses:</strong> Search highlights, important notes, text references.</p>',
      replacedOnClick: '<mark>Highlighted Text</mark>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Time',
      description:
          '<h2>&lt;time&gt; Element</h2><p><strong>Machine-readable time/date</strong> with human-readable display.</p><pre><code>&lt;time datetime=&quot;2024-01-15&quot;&gt;January 15, 2024&lt;/time&gt;</code></pre><p><strong>Key attributes:</strong></p><ul><li><code>datetime</code> &mdash; ISO 8601 format (e.g., <code>2024-01-15T10:30:00</code>)</li><li><code>pubdate</code> &mdash; Publication date (deprecated in HTML5)</li></ul>',
      replacedOnClick: '<time datetime="">Time</time>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Address',
      description:
          '<h2>&lt;address&gt; Element</h2><p><strong>Contact information</strong> for the author or organization.</p><pre><code>&lt;address&gt;\n  123 Main St&lt;br /&gt;\n  City, State 12345\n&lt;/address&gt;</code></pre><p><strong>Use cases:</strong> Author contact, business address</p>',
      replacedOnClick: '<address>\n  \n</address>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Cite',
      description:
          '<h2>&lt;cite&gt; Element</h2><p><strong>Citation</strong> for a creative work reference.</p><pre><code>&lt;cite&gt;The Art of Web Design&lt;/cite&gt;</code></pre><p><strong>Styling:</strong> Italic by default</p><p><strong>Use cases:</strong> Book titles, article sources</p>',
      replacedOnClick: '<cite>Citation</cite>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Abbr',
      description:
          '<h2>&lt;abbr&gt; Element</h2><p><strong>Abbreviation</strong> with full expansion on hover.</p><pre><code>&lt;abbr title=&quot;HyperText Markup Language&quot;&gt;HTML&lt;/abbr&gt;</code></pre><p><strong>Attribute:</strong> <code>title</code> &mdash; <strong>Full expansion</strong></p><p><strong>Accessibility:</strong> Screen readers announce full text</p>',
      replacedOnClick: '<abbr title="">Abbreviation</abbr>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Del',
      description:
          '<h2>&lt;del&gt; Element</h2><p><strong>Deleted text</strong> showing removed content.</p><pre><code>&lt;del&gt;Old price: \$100&lt;/del&gt;</code></pre><p><strong>Styling:</strong> Strikethrough by default</p><p><strong>Use cases:</strong> Edits, price changes, revisions</p>',
      replacedOnClick: '<del>Deleted Text</del>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Ins',
      description:
          '<h2>&lt;ins&gt; Element</h2><p><strong>Inserted text</strong> showing added content.</p><pre><code>&lt;ins&gt;New price: \$80&lt;/ins&gt;</code></pre><p><strong>Styling:</strong> Underlined by default</p><p><strong>Use cases:</strong> Edits, additions, updates</p>',
      replacedOnClick: '<ins>Inserted Text</ins>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Sub',
      description:
          '<h2>&lt;sub&gt; Element</h2><p><strong>Subscript text</strong> positioned below baseline.</p><pre><code>H&lt;sub&gt;2&lt;/sub&gt;O</code></pre><p><strong>Use cases:</strong> Chemical formulas, mathematical notation</p>',
      replacedOnClick: '<sub>Subscript</sub>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Sup',
      description:
          '<h2>&lt;sup&gt; Element</h2><p><strong>Superscript text</strong> positioned above baseline.</p><pre><code>E = mc&lt;sup&gt;2&lt;/sup&gt;</code></pre><p><strong>Use cases:</strong> Mathematical exponents, footnotes, citations</p>',
      replacedOnClick: '<sup>Superscript</sup>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Small',
      description:
          '<h2>&lt;small&gt; Element</h2><p><strong>Smaller text</strong> for disclaimers or fine print.</p><pre><code>&lt;small&gt;Copyright &copy; 2024&lt;/small&gt;</code></pre><p><strong>Semantic meaning:</strong> Side comments, legal text</p><p><strong>Note:</strong> Not just visual styling</p>',
      replacedOnClick: '<small>Small Text</small>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Kbd',
      description:
          '<h2>&lt;kbd&gt; Element</h2><p><strong>Keyboard input</strong> showing keys to press.</p><pre><code>Press &lt;kbd&gt;Ctrl&lt;/kbd&gt; + &lt;kbd&gt;C&lt;/kbd&gt; to copy</code></pre><p><strong>Styling:</strong> Monospace font, border</p><p><strong>Use cases:</strong> Keyboard shortcuts, commands</p>',
      replacedOnClick: '<kbd>Ctrl</kbd>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Samp',
      description:
          '<h2>&lt;samp&gt; Element</h2><p><strong>Sample output</strong> from a program or system.</p><pre><code>&lt;samp&gt;Hello, World!&lt;/samp&gt;</code></pre><p><strong>Styling:</strong> Monospace font</p><p><strong>Use cases:</strong> Program output, terminal text</p>',
      replacedOnClick: '<samp>Sample Output</samp>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Var',
      description:
          '<h2>&lt;var&gt; Element</h2><p><strong>Variable name</strong> in mathematical or programming context.</p><pre><code>The variable &lt;var&gt;x&lt;/var&gt; represents the value</code></pre><p><strong>Styling:</strong> Italic by default</p><p><strong>Use cases:</strong> Math variables, code variables</p>',
      replacedOnClick: '<var>variable</var>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Datalist',
      description:
          '<h2>&lt;datalist&gt; Element</h2><p><strong>Predefined options</strong> for <code>&lt;input&gt;</code> autocomplete.</p><pre><code>&lt;input list=&quot;browsers&quot; /&gt;\n&lt;datalist id=&quot;browsers&quot;&gt;\n  &lt;option value=&quot;Chrome&quot;&gt;\n  &lt;option value=&quot;Firefox&quot;&gt;\n&lt;/datalist&gt;</code></pre><p><strong>Usage:</strong> Connect to input with <code>list</code> attribute</p>',
      replacedOnClick:
          '<datalist id="">\n  <option value=""></option>\n</datalist>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Output',
      description:
          '<h2>&lt;output&gt; Element</h2><p><strong>Calculation result</strong> or form output.</p><pre><code>&lt;output name=&quot;result&quot;&gt;0&lt;/output&gt;</code></pre><p><strong>Use cases:</strong> Calculator results, form calculations</p><p><strong>Attribute:</strong> <code>for</code> &mdash; <strong>Related input IDs</strong></p>',
      replacedOnClick: '<output name="">Output</output>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Progress',
      description:
          '<h2>&lt;progress&gt; Element</h2><p><strong>Progress bar</strong> showing task completion.</p><pre><code>&lt;progress value=&quot;70&quot; max=&quot;100&quot;&gt;70%&lt;/progress&gt;</code></pre><p><strong>Attributes:</strong></p><ul><li><code>value</code> &mdash; <strong>Current value</strong></li><li><code>max</code> &mdash; <strong>Maximum value</strong></li></ul><p><strong>Use cases:</strong> File uploads, downloads, task progress</p>',
      replacedOnClick: '<progress value="0" max="100"></progress>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Meter',
      description:
          '<h2>&lt;meter&gt; Element</h2><p><strong>Gauge</strong> showing a scalar value within a range.</p><pre><code>&lt;meter value=&quot;75&quot; min=&quot;0&quot; max=&quot;100&quot;&gt;75%&lt;/meter&gt;</code></pre><p><strong>Attributes:</strong></p><ul><li><code>value</code> &mdash; <strong>Current value</strong></li><li><code>min</code>, <code>max</code> &mdash; <strong>Range</strong></li><li><code>low</code>, <code>high</code> &mdash; <strong>Thresholds</strong></li><li><code>optimum</code> &mdash; <strong>Optimal value</strong></li></ul>',
      replacedOnClick: '<meter value="0" min="0" max="100"></meter>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Dialog',
      description:
          '<h2>&lt;dialog&gt; Element</h2><p><strong>Modal dialog</strong> box for user interaction.</p><pre><code>&lt;dialog open&gt;\n  &lt;p&gt;Dialog content&lt;/p&gt;\n  &lt;button&gt;Close&lt;/button&gt;\n&lt;/dialog&gt;</code></pre><p><strong>JavaScript API:</strong></p><pre><code>dialog.showModal(); // Show modal\ndialog.close(); // Close</code></pre><p><strong>Attribute:</strong> <code>open</code> &mdash; <strong>Visible by default</strong></p>',
      replacedOnClick: '<dialog open>\n  \n</dialog>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Template',
      description:
          '<h2>&lt;template&gt; Element</h2><p><strong>Inert HTML template</strong> cloned via JavaScript.</p><pre><code>&lt;template id=&quot;item-template&quot;&gt;\n  &lt;li class=&quot;item&quot;&gt;&lt;/li&gt;\n&lt;/template&gt;</code></pre><p><strong>Usage:</strong></p><pre><code>const template = document.getElementById(&quot;item-template&quot;);\nconst clone = template.content.cloneNode(true);</code></pre><p><strong>Benefits:</strong> Not rendered until cloned</p>',
      replacedOnClick: '<template>\n  \n</template>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Noscript',
      description:
          '<h2>&lt;noscript&gt; Element</h2><p><strong>Fallback content</strong> when JavaScript is disabled.</p><pre><code>&lt;noscript&gt;\n  &lt;p&gt;Please enable JavaScript to use this site.&lt;/p&gt;\n&lt;/noscript&gt;</code></pre><p><strong>Use cases:</strong> Accessibility, graceful degradation</p>',
      replacedOnClick: '<noscript>\n  \n</noscript>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Description List',
      description:
          '<h2>&lt;dl&gt; Description List</h2><p><strong>List of terms</strong> with their descriptions.</p><pre><code>&lt;dl&gt;\n  &lt;dt&gt;HTML&lt;/dt&gt;\n  &lt;dd&gt;HyperText Markup Language&lt;/dd&gt;\n  &lt;dt&gt;CSS&lt;/dt&gt;\n  &lt;dd&gt;Cascading Style Sheets&lt;/dd&gt;\n&lt;/dl&gt;</code></pre><p><strong>Use cases:</strong> Glossaries, definitions, metadata</p>',
      replacedOnClick: '<dl>\n  <dt>Term</dt>\n  <dd>Definition</dd>\n</dl>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Description Term',
      description:
          '<h2>&lt;dt&gt; Description Term</h2><p><strong>Term</strong> being defined in a description list.</p><pre><code>&lt;dt&gt;Term Name&lt;/dt&gt;</code></pre><p><strong>Parent:</strong> Must be inside <code>&lt;dl&gt;</code> element</p>',
      replacedOnClick: '<dt>Term</dt>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Description Definition',
      description:
          '<h2>&lt;dd&gt; Description Definition</h2><p><strong>Definition</strong> of the preceding term.</p><pre><code>&lt;dd&gt;Definition description&lt;/dd&gt;</code></pre><p><strong>Parent:</strong> Must be inside <code>&lt;dl&gt;</code> element</p><p><strong>Can contain:</strong> Multiple <code>&lt;dd&gt;</code> for one <code>&lt;dt&gt;</code></p>',
      replacedOnClick: '<dd>Definition</dd>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Picture',
      description:
          '<h2>&lt;picture&gt; Element</h2><p><strong>Responsive image</strong> with multiple sources.</p><pre><code>&lt;picture&gt;\n  &lt;source media=&quot;(min-width: 800px)&quot; srcset=&quot;large.jpg&quot;&gt;\n  &lt;source media=&quot;(min-width: 400px)&quot; srcset=&quot;medium.jpg&quot;&gt;\n  &lt;img src=&quot;small.jpg&quot; alt=&quot;Description&quot; /&gt;\n&lt;/picture&gt;</code></pre><p><strong>Benefits:</strong> Art direction, responsive images, modern formats</p>',
      replacedOnClick:
          '<picture>\n  <source media="(min-width: 800px)" srcset="">\n  <img src="" alt="" />\n</picture>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Track',
      description:
          '<h2>&lt;track&gt; Element</h2><p><strong>Text track</strong> for <code>&lt;video&gt;</code> and <code>&lt;audio&gt;</code> elements.</p><pre><code>&lt;track src=&quot;subtitles.vtt&quot; kind=&quot;subtitles&quot; srclang=&quot;en&quot; label=&quot;English&quot; /&gt;</code></pre><p><strong>Attributes:</strong></p><ul><li><code>kind</code> &mdash; <strong>Track type</strong> (<code>subtitles</code>, <code>captions</code>, <code>descriptions</code>)</li><li><code>srclang</code> &mdash; <strong>Language code</strong></li><li><code>label</code> &mdash; <strong>User-visible label</strong></li></ul>',
      replacedOnClick:
          '<track src="" kind="subtitles" srclang="en" label="English" />',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Base',
      description:
          '<h2>&lt;base&gt; Element</h2><p><strong>Base URL</strong> for all relative URLs in document.</p><pre><code>&lt;base href=&quot;https://example.com/&quot; target=&quot;_blank&quot; /&gt;</code></pre><p><strong>Attributes:</strong></p><ul><li><code>href</code> &mdash; <strong>Base URL</strong></li><li><code>target</code> &mdash; <strong>Default target</strong> (<code>_blank</code>, <code>_self</code>)</li></ul><p><strong>Placement:</strong> First child of <code>&lt;head&gt;</code></p>',
      replacedOnClick: '<base href="" target="_blank" />',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Wbr',
      description:
          '<h2>&lt;wbr&gt; Element</h2><p><strong>Word break opportunity</strong> &mdash; suggests where to break long words.</p><pre><code>VeryLongWord&lt;wbr /&gt;ThatNeedsBreaking</code></pre><p><strong>Use cases:</strong> Long URLs, technical terms, email addresses</p><p><strong>Note:</strong> Browser decides if break is needed</p>',
      replacedOnClick: '<wbr />',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Q',
      description:
          '<h2>&lt;q&gt; Element</h2><p><strong>Inline quotation</strong> from another source.</p><pre><code>&lt;q cite=&quot;https://example.com&quot;&gt;Quoted text&lt;/q&gt;</code></pre><p><strong>Styling:</strong> Quotation marks added automatically</p><p><strong>Attribute:</strong> <code>cite</code> &mdash; <strong>Source URL</strong></p>',
      replacedOnClick: '<q cite="">Quote</q>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Dfn',
      description:
          '<h2>&lt;dfn&gt; Element</h2><p><strong>Definition term</strong> marking the term being defined.</p><pre><code>&lt;dfn&gt;HTML&lt;/dfn&gt; stands for HyperText Markup Language.</code></pre><p><strong>Styling:</strong> Italic by default</p><p><strong>Use cases:</strong> First occurrence of a term</p>',
      replacedOnClick: '<dfn>Definition Term</dfn>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Data',
      description:
          '<h2>&lt;data&gt; Element</h2><p><strong>Machine-readable value</strong> with human-readable text.</p><pre><code>&lt;data value=&quot;12345&quot;&gt;Product #12345&lt;/data&gt;</code></pre><p><strong>Use cases:</strong> Product IDs, measurements, dates</p><p><strong>Benefits:</strong> Both human and machine readable</p>',
      replacedOnClick: '<data value="">Data</data>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Ruby',
      description:
          '<h2>&lt;ruby&gt; Element</h2><p><strong>Ruby annotation</strong> for East Asian typography.</p><pre><code>&lt;ruby&gt;\n  漢 &lt;rt&gt;kan&lt;/rt&gt;\n&lt;/ruby&gt;</code></pre><p><strong>Use cases:</strong> Pronunciation guides, translations</p><p><strong>Contains:</strong> Base text and <code>&lt;rt&gt;</code> annotations</p>',
      replacedOnClick: '<ruby>\n  漢 <rt>kan</rt>\n</ruby>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Rt',
      description:
          '<h2>&lt;rt&gt; Element</h2><p><strong>Ruby text</strong> annotation above/below base text.</p><pre><code>&lt;rt&gt;pronunciation&lt;/rt&gt;</code></pre><p><strong>Parent:</strong> Must be inside <code>&lt;ruby&gt;</code> element</p><p><strong>Styling:</strong> Smaller font, positioned above base</p>',
      replacedOnClick: '<rt>Ruby Text</rt>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Rp',
      description:
          '<h2>&lt;rp&gt; Element</h2><p><strong>Ruby parenthesis</strong> fallback for browsers without ruby support.</p><pre><code>&lt;ruby&gt;\n  漢 &lt;rp&gt;(&lt;/rp&gt;&lt;rt&gt;kan&lt;/rt&gt;&lt;rp&gt;)&lt;/rp&gt;\n&lt;/ruby&gt;</code></pre><p><strong>Purpose:</strong> Shows parentheses when ruby not supported</p>',
      replacedOnClick: '<rp>(</rp>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Bdi',
      description:
          '<h2>&lt;bdi&gt; Element</h2><p><strong>Bidirectional isolation</strong> for mixed-direction text.</p><pre><code>&lt;bdi&gt;Mixed direction text&lt;/bdi&gt;</code></pre><p><strong>Use cases:</strong> User-generated content, mixed languages</p><p><strong>Benefit:</strong> Prevents text direction issues</p>',
      replacedOnClick: '<bdi>Text</bdi>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Bdo',
      description:
          '<h2>&lt;bdo&gt; Element</h2><p><strong>Bidirectional override</strong> forcing text direction.</p><pre><code>&lt;bdo dir=&quot;rtl&quot;&gt;Right-to-left text&lt;/bdo&gt;</code></pre><p><strong>Attribute:</strong> <code>dir</code> &mdash; <strong>Direction</strong> (<code>ltr</code> or <code>rtl</code>)</p><p><strong>Use cases:</strong> Override automatic direction detection</p>',
      replacedOnClick: '<bdo dir="rtl">Text</bdo>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Menu',
      description:
          '<h2>&lt;menu&gt; Element</h2><p><strong>Menu list</strong> of commands or options.</p><pre><code>&lt;menu&gt;\n  &lt;li&gt;&lt;a href=&quot;/&quot;&gt;Home&lt;/a&gt;&lt;/li&gt;\n  &lt;li&gt;&lt;a href=&quot;/about&quot;&gt;About&lt;/a&gt;&lt;/li&gt;\n&lt;/menu&gt;</code></pre><p><strong>Note:</strong> Consider using <code>&lt;nav&gt;</code> for navigation menus</p>',
      replacedOnClick: '<menu>\n  <li>Item</li>\n</menu>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Menuitem',
      description:
          '<h2>&lt;menuitem&gt; Element</h2><p><strong>Menu item</strong> within a <code>&lt;menu&gt;</code> element.</p><pre><code>&lt;menuitem&gt;Menu Option&lt;/menuitem&gt;</code></pre><p><strong>Note:</strong> Limited browser support, consider alternatives</p>',
      replacedOnClick: '<menuitem>Item</menuitem>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Param',
      description:
          '<h2>&lt;param&gt; Element</h2><p><strong>Parameter</strong> for <code>&lt;object&gt;</code> element plugins.</p><pre><code>&lt;object data=&quot;plugin.swf&quot;&gt;\n  &lt;param name=&quot;autoplay&quot; value=&quot;true&quot; /&gt;\n&lt;/object&gt;</code></pre><p><strong>Attributes:</strong></p><ul><li><code>name</code> &mdash; <strong>Parameter name</strong></li><li><code>value</code> &mdash; <strong>Parameter value</strong></li></ul><p><strong>Parent:</strong> Must be inside <code>&lt;object&gt;</code></p>',
      replacedOnClick: '<param name="" value="" />',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Slot',
      description:
          '<h2>&lt;slot&gt; Element</h2><p><strong>Placeholder</strong> in web component shadow DOM.</p><pre><code>&lt;slot name=&quot;content&quot;&gt;&lt;/slot&gt;</code></pre><p><strong>Usage:</strong></p><pre><code>&lt;my-component&gt;\n  &lt;span slot=&quot;content&quot;&gt;Slotted content&lt;/span&gt;\n&lt;/my-component&gt;</code></pre><p><strong>Web Components:</strong> Part of Shadow DOM API</p>',
      replacedOnClick: '<slot name=""></slot>',
      triggeredAt: '<',
    ),
  ];
}
