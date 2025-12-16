import 'package:code_forge/code_forge.dart';
import 'package:code_forge/code_forge/controller.dart';
import 'package:code_forge/code_forge/suggestion_model.dart';

/// Returns HTML-specific suggestions.
List<SuggestionModel> getHtmlSuggestions() {
  return [
    SuggestionModel(
      label: 'Div',
      description:
          '## `<div>` Element\n\n**Block-level container** for grouping content.\n\n```html\n<div>\n  <!-- Content here -->\n</div>\n```\n\n**Use cases:** Layout, grouping, styling containers',
      replacedOnClick: '<div>\n  \n</div>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Span',
      description:
          '## `<span>` Element\n\n**Inline container** for text styling and grouping.\n\n```html\n<span>Inline content</span>\n```\n\n**Use cases:** Text styling, inline grouping',
      replacedOnClick: '<span></span>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Link',
      description:
          '## `<a>` Anchor Link\n\n**Hyperlink** to navigate to other pages or sections.\n\n```html\n<a href="https://example.com">Link Text</a>\n```\n\n**Attributes:**\n- `href` - **URL** or anchor target\n- `target` - Open in new window (`_blank`)',
      replacedOnClick: '<a href="">Link Text</a>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Image',
      description:
          '## `<img>` Image Element\n\n**Embeds an image** in the document.\n\n```html\n<img src="image.jpg" alt="Description" />\n```\n\n**Required attributes:**\n- `src` - **Image URL**\n- `alt` - **Alternative text** (accessibility)\n\n**Optional:** `width`, `height`, `loading="lazy"`',
      replacedOnClick: '<img src="" alt="" />',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Paragraph',
      description:
          '## `<p>` Paragraph\n\n**Block-level element** for text paragraphs.\n\n```html\n<p>Paragraph text content</p>\n```\n\n**Semantic meaning:** Represents a paragraph of text',
      replacedOnClick: '<p>\n  \n</p>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Heading 1',
      description:
          '## `<h1>` Heading Level 1\n\n**Main page title** - highest heading level.\n\n```html\n<h1>Main Title</h1>\n```\n\n**Best practice:** Use **one** `<h1>` per page for SEO',
      replacedOnClick: '<h1>\n  \n</h1>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Heading 2',
      description:
          '## `<h2>` Heading Level 2\n\n**Section heading** - second level.\n\n```html\n<h2>Section Title</h2>\n```\n\n**Hierarchy:** `<h1>` → `<h2>` → `<h3>` → ...',
      replacedOnClick: '<h2>\n  \n</h2>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Button',
      description:
          '## `<button>` Element\n\n**Clickable button** for user interactions.\n\n```html\n<button type="button">Click Me</button>\n```\n\n**Types:**\n- `type="button"` - **Standard button**\n- `type="submit"` - **Form submission**\n- `type="reset"` - **Form reset**',
      replacedOnClick: '<button type="button">Button Text</button>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Input',
      description:
          '## `<input>` Element\n\n**Form input field** for user data entry.\n\n```html\n<input type="text" name="username" value="" />\n```\n\n**Common types:**\n- `text` - **Text input**\n- `email` - **Email validation**\n- `password` - **Password field**\n- `number` - **Numeric input**\n- `checkbox` - **Checkbox**\n- `radio` - **Radio button**\n- `date` - **Date picker**\n- `file` - **File upload**',
      replacedOnClick: '<input type="text" name="" value="" />',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Form',
      description:
          '## `<form>` Element\n\n**Container** for form inputs and submission.\n\n```html\n<form action="/submit" method="post">\n  <!-- Form fields -->\n</form>\n```\n\n**Attributes:**\n- `action` - **Submission URL**\n- `method` - **HTTP method** (`get` or `post`)\n- `enctype` - **Encoding type** (for file uploads)',
      replacedOnClick: '<form action="" method="post">\n  \n</form>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'List',
      description:
          '## `<ul>` Unordered List\n\n**Bulleted list** for items without order.\n\n```html\n<ul>\n  <li>Item 1</li>\n  <li>Item 2</li>\n</ul>\n```\n\n**Styling:** Use CSS to customize bullet styles',
      replacedOnClick: '<ul>\n  <li></li>\n</ul>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Ordered List',
      description:
          '## `<ol>` Ordered List\n\n**Numbered list** for sequential items.\n\n```html\n<ol>\n  <li>First item</li>\n  <li>Second item</li>\n</ol>\n```\n\n**Attributes:** `start`, `reversed`, `type`',
      replacedOnClick: '<ol>\n  <li></li>\n</ol>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Table',
      description:
          '## `<table>` Element\n\n**Structured data table** with rows and columns.\n\n```html\n<table>\n  <tr>\n    <th>Header</th>\n  </tr>\n  <tr>\n    <td>Data</td>\n  </tr>\n</table>\n```\n\n**Structure:** `<thead>`, `<tbody>`, `<tfoot>` for organization',
      replacedOnClick:
          '<table>\n  <tr>\n    <th></th>\n  </tr>\n  <tr>\n    <td></td>\n  </tr>\n</table>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Script',
      description:
          '## `<script>` Element\n\n**Embeds JavaScript** code or references external scripts.\n\n```html\n<script>\n  console.log("Hello World");\n</script>\n```\n\n**External script:**\n```html\n<script src="app.js"></script>\n```\n\n**Attributes:** `src`, `type`, `async`, `defer`',
      replacedOnClick: '<script>\n  \n</script>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Style',
      description:
          '## `<style>` Element\n\n**Embeds CSS** styles directly in the document.\n\n```html\n<style>\n  body { color: #333; }\n</style>\n```\n\n**Best practice:** Use external stylesheets for better organization',
      replacedOnClick: '<style>\n  \n</style>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Meta',
      description:
          '## `<meta>` Element\n\n**Metadata** about the HTML document.\n\n```html\n<meta name="description" content="Page description" />\n```\n\n**Common uses:**\n- `charset` - **Character encoding**\n- `viewport` - **Responsive design**\n- `description` - **SEO description**\n- `keywords` - **SEO keywords**\n- `author` - **Page author**',
      replacedOnClick: '<meta name="" content="" />',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Link CSS',
      description:
          '## `<link>` Stylesheet\n\n**Links external CSS** stylesheet to the document.\n\n```html\n<link rel="stylesheet" href="styles.css" />\n```\n\n**Attributes:**\n- `rel="stylesheet"` - **Stylesheet relationship**\n- `href` - **CSS file URL**\n- `media` - **Media query** (e.g., `print`)',
      replacedOnClick: '<link rel="stylesheet" href="" />',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Section',
      description:
          '## `<section>` Element\n\n**Semantic container** for thematic content grouping.\n\n```html\n<section>\n  <h2>Section Title</h2>\n  <!-- Content -->\n</section>\n```\n\n**Use cases:** Chapters, topics, distinct content areas',
      replacedOnClick: '<section>\n  \n</section>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Article',
      description:
          '## `<article>` Element\n\n**Self-contained content** that can be independently distributed.\n\n```html\n<article>\n  <h2>Article Title</h2>\n  <p>Article content...</p>\n</article>\n```\n\n**Use cases:** Blog posts, news articles, forum posts',
      replacedOnClick: '<article>\n  \n</article>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Header',
      description:
          '## `<header>` Element\n\n**Header section** containing introductory content.\n\n```html\n<header>\n  <h1>Site Title</h1>\n  <nav>...</nav>\n</header>\n```\n\n**Contains:** Logo, navigation, site title',
      replacedOnClick: '<header>\n  \n</header>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Footer',
      description:
          '## `<footer>` Element\n\n**Footer section** with closing information.\n\n```html\n<footer>\n  <p>Copyright © 2024</p>\n</footer>\n```\n\n**Contains:** Copyright, links, contact info',
      replacedOnClick: '<footer>\n  \n</footer>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Nav',
      description:
          '## `<nav>` Element\n\n**Navigation section** with links to other pages.\n\n```html\n<nav>\n  <a href="/">Home</a>\n  <a href="/about">About</a>\n</nav>\n```\n\n**Semantic meaning:** Main navigation links',
      replacedOnClick: '<nav>\n  \n</nav>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Heading 3',
      description:
          '## `<h3>` Heading Level 3\n\n**Subsection heading** - third level.\n\n```html\n<h3>Subsection Title</h3>\n```\n\n**Semantic structure:** Part of document outline',
      replacedOnClick: '<h3>\n  \n</h3>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Heading 4',
      description:
          '## `<h4>` Heading Level 4\n\n**Sub-subsection heading** - fourth level.\n\n```html\n<h4>Minor Section</h4>\n```\n\n**Hierarchy:** Continue heading levels sequentially',
      replacedOnClick: '<h4>\n  \n</h4>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Heading 5',
      description:
          '## `<h5>` Heading Level 5\n\n**Minor heading** - fifth level.\n\n```html\n<h5>Small Section</h5>\n```\n\n**Usage:** For deeply nested content sections',
      replacedOnClick: '<h5>\n  \n</h5>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Heading 6',
      description:
          '## `<h6>` Heading Level 6\n\n**Smallest heading** - sixth and final level.\n\n```html\n<h6>Smallest Heading</h6>\n```\n\n**Note:** Lowest heading level in HTML',
      replacedOnClick: '<h6>\n  \n</h6>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'List Item',
      description:
          '## `<li>` List Item\n\n**Individual item** in ordered or unordered lists.\n\n```html\n<li>List item content</li>\n```\n\n**Parent elements:** `<ul>`, `<ol>`, `<menu>`',
      replacedOnClick: '<li></li>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Label',
      description:
          '## `<label>` Element\n\n**Associates text** with form input for accessibility.\n\n```html\n<label for="username">Username:</label>\n<input id="username" type="text" />\n```\n\n**Benefits:**\n- **Accessibility** - Screen reader support\n- **Usability** - Click label to focus input',
      replacedOnClick: '<label for="">Label Text</label>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Textarea',
      description:
          '## `<textarea>` Element\n\n**Multi-line text input** for longer content.\n\n```html\n<textarea name="message" rows="4" cols="50">\n  Default text\n</textarea>\n```\n\n**Attributes:**\n- `rows` - **Visible height**\n- `cols` - **Visible width**\n- `placeholder` - **Hint text**',
      replacedOnClick: '<textarea name="" rows="4" cols="50"></textarea>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Select',
      description:
          '## `<select>` Dropdown\n\n**Dropdown menu** for selecting from options.\n\n```html\n<select name="country">\n  <option value="us">United States</option>\n  <option value="uk">United Kingdom</option>\n</select>\n```\n\n**Attributes:** `name`, `multiple`, `size`, `required`',
      replacedOnClick:
          '<select name="">\n  <option value="">Option</option>\n</select>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Option',
      description:
          '## `<option>` Element\n\n**Choice** within a `<select>` dropdown.\n\n```html\n<option value="value">Display Text</option>\n```\n\n**Attributes:**\n- `value` - **Submitted value**\n- `selected` - **Pre-selected** option\n- `disabled` - **Disabled** option',
      replacedOnClick: '<option value="">Option Text</option>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Fieldset',
      description:
          '## `<fieldset>` Element\n\n**Groups related form controls** together.\n\n```html\n<fieldset>\n  <legend>Personal Information</legend>\n  <!-- Form fields -->\n</fieldset>\n```\n\n**Benefits:** Visual grouping and semantic organization',
      replacedOnClick: '<fieldset>\n  <legend>Legend</legend>\n  \n</fieldset>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Legend',
      description:
          '## `<legend>` Element\n\n**Caption** for a `<fieldset>` element.\n\n```html\n<legend>Section Title</legend>\n```\n\n**Purpose:** Describes the purpose of the fieldset group',
      replacedOnClick: '<legend>Legend Text</legend>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Strong',
      description:
          '## `<strong>` Element\n\n**Semantic bold** text indicating **strong importance**.\n\n```html\n<strong>Important text</strong>\n```\n\n**Semantic meaning:** More important than `<b>` tag',
      replacedOnClick: '<strong>Bold Text</strong>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Emphasis',
      description:
          '## `<em>` Element\n\n**Semantic italic** text indicating **emphasis**.\n\n```html\n<em>Emphasized text</em>\n```\n\n**Semantic meaning:** Stressed emphasis, better than `<i>` for accessibility',
      replacedOnClick: '<em>Italic Text</em>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Bold',
      description:
          '## `<b>` Element\n\n**Visual bold** text without semantic meaning.\n\n```html\n<b>Bold text</b>\n```\n\n**Note:** Use `<strong>` for semantic importance',
      replacedOnClick: '<b>Bold Text</b>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Italic',
      description:
          '## `<i>` Element\n\n**Visual italic** text without semantic meaning.\n\n```html\n<i>Italic text</i>\n```\n\n**Note:** Use `<em>` for semantic emphasis',
      replacedOnClick: '<i>Italic Text</i>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Code',
      description:
          '## `<code>` Element\n\n**Inline code** snippet for technical terms.\n\n```html\n<code>functionName()</code>\n```\n\n**Styling:** Typically displayed in monospace font',
      replacedOnClick: '<code>code</code>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Pre',
      description:
          '## `<pre>` Element\n\n**Preformatted text** preserving whitespace and line breaks.\n\n```html\n<pre>\n  function example() {\n    return true;\n  }\n</pre>\n```\n\n**Use cases:** Code blocks, ASCII art, formatted text',
      replacedOnClick: '<pre>\n  \n</pre>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Blockquote',
      description:
          '## `<blockquote>` Element\n\n**Block quotation** from another source.\n\n```html\n<blockquote>\n  <p>Quoted text here</p>\n  <cite>— Source Name</cite>\n</blockquote>\n```\n\n**Attribute:** `cite` - Source URL',
      replacedOnClick: '<blockquote>\n  \n</blockquote>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Line Break',
      description:
          '## `<br>` Element\n\n**Line break** - forces a new line.\n\n```html\nLine one<br />\nLine two\n```\n\n**Self-closing:** No closing tag needed',
      replacedOnClick: '<br />',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Horizontal Rule',
      description:
          '## `<hr>` Element\n\n**Horizontal rule** - thematic break between sections.\n\n```html\n<section>Content</section>\n<hr />\n<section>More content</section>\n```\n\n**Visual:** Creates a horizontal line separator',
      replacedOnClick: '<hr />',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Aside',
      description:
          '## `<aside>` Element\n\n**Sidebar content** tangentially related to main content.\n\n```html\n<aside>\n  <h3>Related Links</h3>\n  <!-- Sidebar content -->\n</aside>\n```\n\n**Use cases:** Sidebars, callouts, advertisements',
      replacedOnClick: '<aside>\n  \n</aside>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Main',
      description:
          '## `<main>` Element\n\n**Main content** area of the document.\n\n```html\n<main>\n  <article>...</article>\n</main>\n```\n\n**Best practice:** Use **one** `<main>` per page',
      replacedOnClick: '<main>\n  \n</main>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Details',
      description:
          '## `<details>` Element\n\n**Collapsible disclosure widget** showing/hiding content.\n\n```html\n<details>\n  <summary>Click to expand</summary>\n  <p>Hidden content here</p>\n</details>\n```\n\n**Attribute:** `open` - **Expanded by default**',
      replacedOnClick:
          '<details>\n  <summary>Summary</summary>\n  \n</details>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Summary',
      description:
          '## `<summary>` Element\n\n**Clickable summary** for `<details>` element.\n\n```html\n<summary>Show more</summary>\n```\n\n**Purpose:** Label for collapsible content',
      replacedOnClick: '<summary>Summary Text</summary>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Figure',
      description:
          '## `<figure>` Element\n\n**Self-contained content** with optional caption.\n\n```html\n<figure>\n  <img src="image.jpg" alt="Description" />\n  <figcaption>Image caption</figcaption>\n</figure>\n```\n\n**Use cases:** Images, diagrams, code snippets, quotes',
      replacedOnClick:
          '<figure>\n  \n  <figcaption>Caption</figcaption>\n</figure>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Figcaption',
      description:
          '## `<figcaption>` Element\n\n**Caption** for a `<figure>` element.\n\n```html\n<figcaption>Description of the figure</figcaption>\n```\n\n**Placement:** First or last child of `<figure>`',
      replacedOnClick: '<figcaption>Caption Text</figcaption>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Table Head',
      description:
          '## `<thead>` Element\n\n**Header section** of a table with column headers.\n\n```html\n<thead>\n  <tr>\n    <th>Column 1</th>\n    <th>Column 2</th>\n  </tr>\n</thead>\n```\n\n**Contains:** Header rows with `<th>` elements',
      replacedOnClick: '<thead>\n  <tr>\n    <th></th>\n  </tr>\n</thead>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Table Body',
      description:
          '## `<tbody>` Element\n\n**Body section** containing main table data.\n\n```html\n<tbody>\n  <tr>\n    <td>Data 1</td>\n    <td>Data 2</td>\n  </tr>\n</tbody>\n```\n\n**Contains:** Data rows with `<td>` elements',
      replacedOnClick: '<tbody>\n  <tr>\n    <td></td>\n  </tr>\n</tbody>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Table Foot',
      description:
          '## `<tfoot>` Element\n\n**Footer section** with summary rows.\n\n```html\n<tfoot>\n  <tr>\n    <td>Total</td>\n    <td>\$100</td>\n  </tr>\n</tfoot>\n```\n\n**Use cases:** Totals, summaries, footnotes',
      replacedOnClick: '<tfoot>\n  <tr>\n    <td></td>\n  </tr>\n</tfoot>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Table Row',
      description:
          '## `<tr>` Element\n\n**Table row** containing cells.\n\n```html\n<tr>\n  <td>Cell 1</td>\n  <td>Cell 2</td>\n</tr>\n```\n\n**Contains:** `<th>` (headers) or `<td>` (data) cells',
      replacedOnClick: '<tr>\n  <td></td>\n</tr>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Table Header Cell',
      description:
          '## `<th>` Element\n\n**Header cell** in table header row.\n\n```html\n<th>Column Name</th>\n```\n\n**Attributes:** `colspan`, `rowspan`, `scope`\n\n**Styling:** Bold and centered by default',
      replacedOnClick: '<th></th>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Table Data Cell',
      description:
          '## `<td>` Element\n\n**Data cell** containing table content.\n\n```html\n<td>Cell content</td>\n```\n\n**Attributes:** `colspan`, `rowspan`\n\n**Styling:** Regular text alignment',
      replacedOnClick: '<td></td>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Table Caption',
      description:
          '## `<caption>` Element\n\n**Title or description** for a table.\n\n```html\n<caption>Table Title</caption>\n```\n\n**Placement:** First child of `<table>` element',
      replacedOnClick: '<caption>Caption Text</caption>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Video',
      description:
          '## `<video>` Element\n\n**Embeds video** content with native controls.\n\n```html\n<video width="640" height="360" controls>\n  <source src="video.mp4" type="video/mp4">\n  Your browser does not support video.\n</video>\n```\n\n**Attributes:**\n- `controls` - **Show controls**\n- `autoplay` - **Auto-play** video\n- `loop` - **Loop** video\n- `muted` - **Mute** audio\n- `poster` - **Thumbnail** image',
      replacedOnClick:
          '<video width="" height="" controls>\n  <source src="" type="video/mp4">\n</video>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Audio',
      description:
          '## `<audio>` Element\n\n**Embeds audio** content with native controls.\n\n```html\n<audio controls>\n  <source src="audio.mp3" type="audio/mpeg">\n  Your browser does not support audio.\n</audio>\n```\n\n**Attributes:**\n- `controls` - **Show controls**\n- `autoplay` - **Auto-play** audio\n- `loop` - **Loop** audio\n- `muted` - **Mute** audio',
      replacedOnClick:
          '<audio controls>\n  <source src="" type="audio/mpeg">\n</audio>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Source',
      description:
          '## `<source>` Element\n\n**Media source** for `<video>` and `<audio>` elements.\n\n```html\n<source src="media.mp4" type="video/mp4" />\n```\n\n**Attributes:**\n- `src` - **Media URL**\n- `type` - **MIME type**\n- `media` - **Media query** (for `<picture>`)',
      replacedOnClick: '<source src="" type="" />',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Canvas',
      description:
          '## `<canvas>` Element\n\n**Drawing surface** for JavaScript graphics.\n\n```html\n<canvas id="myCanvas" width="800" height="600"></canvas>\n```\n\n**Usage:**\n```javascript\nconst ctx = canvas.getContext("2d");\nctx.fillRect(10, 10, 100, 100);\n```\n\n**Use cases:** Charts, games, animations',
      replacedOnClick: '<canvas id="" width="" height=""></canvas>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'SVG',
      description:
          '## `<svg>` Element\n\n**Scalable Vector Graphics** container.\n\n```html\n<svg width="100" height="100">\n  <circle cx="50" cy="50" r="40" fill="blue" />\n</svg>\n```\n\n**Benefits:**\n- **Scalable** - No quality loss\n- **Stylable** with CSS\n- **Accessible**',
      replacedOnClick: '<svg width="" height="">\n  \n</svg>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Iframe',
      description:
          '## `<iframe>` Element\n\n**Inline frame** embedding another HTML page.\n\n```html\n<iframe src="https://example.com" width="800" height="600"></iframe>\n```\n\n**Attributes:**\n- `src` - **Page URL**\n- `width`, `height` - **Dimensions**\n- `frameborder` - **Border** (deprecated)\n- `sandbox` - **Security** restrictions',
      replacedOnClick: '<iframe src="" width="" height=""></iframe>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Embed',
      description:
          '## `<embed>` Element\n\n**Embeds external content** or plugin.\n\n```html\n<embed src="plugin.swf" width="400" height="300" />\n```\n\n**Note:** Consider using `<iframe>` or modern alternatives',
      replacedOnClick: '<embed src="" width="" height="" />',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Object',
      description:
          '## `<object>` Element\n\n**Embeds external resource** or plugin.\n\n```html\n<object data="file.pdf" width="800" height="600">\n  <param name="autoplay" value="true" />\n</object>\n```\n\n**Use cases:** PDFs, Flash, plugins\n\n**Fallback:** Content inside tag shown if object fails',
      replacedOnClick: '<object data="" width="" height=""></object>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Title',
      description:
          '## `<title>` Element\n\n**Page title** shown in browser tab and search results.\n\n```html\n<title>My Website - Home Page</title>\n```\n\n**SEO importance:** Critical for search engine optimization\n\n**Placement:** Inside `<head>` element',
      replacedOnClick: '<title>Page Title</title>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Head',
      description:
          '## `<head>` Element\n\n**Document metadata** container (not displayed).\n\n```html\n<head>\n  <meta charset="UTF-8">\n  <title>Page Title</title>\n  <link rel="stylesheet" href="styles.css" />\n</head>\n```\n\n**Contains:** Meta tags, title, links, scripts',
      replacedOnClick:
          '<head>\n  <meta charset="UTF-8">\n  <title>Title</title>\n</head>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Body',
      description:
          '## `<body>` Element\n\n**Main content** area visible to users.\n\n```html\n<body>\n  <header>...</header>\n  <main>...</main>\n  <footer>...</footer>\n</body>\n```\n\n**Contains:** All visible page content',
      replacedOnClick: '<body>\n  \n</body>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'HTML',
      description:
          '## Complete HTML Document\n\n**Full HTML5 document structure** with all essential elements.\n\n```html\n<!DOCTYPE html>\n<html lang="en">\n<head>\n  <meta charset="UTF-8">\n  <meta name="viewport" content="width=device-width">\n  <title>Document</title>\n</head>\n<body>\n  <!-- Content -->\n</body>\n</html>\n```\n\n**Includes:** DOCTYPE, html, head, body',
      replacedOnClick:
          '<!DOCTYPE html>\n<html lang="en">\n<head>\n  <meta charset="UTF-8">\n  <title>Document</title>\n</head>\n<body>\n  \n</body>\n</html>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Mark',
      description:
          '## `<mark>` Element\n\n**Highlighted text** for emphasis or search results.\n\n```html\n<mark>Highlighted content</mark>\n```\n\n**Styling:** Yellow background by default\n\n**Use cases:** Search highlights, important notes',
      replacedOnClick: '<mark>Highlighted Text</mark>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Time',
      description:
          '## `<time>` Element\n\n**Machine-readable time/date** with human-readable display.\n\n```html\n<time datetime="2024-01-15">January 15, 2024</time>\n```\n\n**Attributes:**\n- `datetime` - **ISO 8601** format\n- `pubdate` - **Publication date**',
      replacedOnClick: '<time datetime="">Time</time>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Address',
      description:
          '## `<address>` Element\n\n**Contact information** for the author or organization.\n\n```html\n<address>\n  123 Main St<br />\n  City, State 12345\n</address>\n```\n\n**Use cases:** Author contact, business address',
      replacedOnClick: '<address>\n  \n</address>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Cite',
      description:
          '## `<cite>` Element\n\n**Citation** for a creative work reference.\n\n```html\n<cite>The Art of Web Design</cite>\n```\n\n**Styling:** Italic by default\n\n**Use cases:** Book titles, article sources',
      replacedOnClick: '<cite>Citation</cite>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Abbr',
      description:
          '## `<abbr>` Element\n\n**Abbreviation** with full expansion on hover.\n\n```html\n<abbr title="HyperText Markup Language">HTML</abbr>\n```\n\n**Attribute:** `title` - **Full expansion**\n\n**Accessibility:** Screen readers announce full text',
      replacedOnClick: '<abbr title="">Abbreviation</abbr>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Del',
      description:
          '## `<del>` Element\n\n**Deleted text** showing removed content.\n\n```html\n<del>Old price: \$100</del>\n```\n\n**Styling:** Strikethrough by default\n\n**Use cases:** Edits, price changes, revisions',
      replacedOnClick: '<del>Deleted Text</del>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Ins',
      description:
          '## `<ins>` Element\n\n**Inserted text** showing added content.\n\n```html\n<ins>New price: \$80</ins>\n```\n\n**Styling:** Underlined by default\n\n**Use cases:** Edits, additions, updates',
      replacedOnClick: '<ins>Inserted Text</ins>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Sub',
      description:
          '## `<sub>` Element\n\n**Subscript text** positioned below baseline.\n\n```html\nH<sub>2</sub>O\n```\n\n**Use cases:** Chemical formulas, mathematical notation',
      replacedOnClick: '<sub>Subscript</sub>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Sup',
      description:
          '## `<sup>` Element\n\n**Superscript text** positioned above baseline.\n\n```html\nE = mc<sup>2</sup>\n```\n\n**Use cases:** Mathematical exponents, footnotes, citations',
      replacedOnClick: '<sup>Superscript</sup>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Small',
      description:
          '## `<small>` Element\n\n**Smaller text** for disclaimers or fine print.\n\n```html\n<small>Copyright © 2024</small>\n```\n\n**Semantic meaning:** Side comments, legal text\n\n**Note:** Not just visual styling',
      replacedOnClick: '<small>Small Text</small>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Kbd',
      description:
          '## `<kbd>` Element\n\n**Keyboard input** showing keys to press.\n\n```html\nPress <kbd>Ctrl</kbd> + <kbd>C</kbd> to copy\n```\n\n**Styling:** Monospace font, border\n\n**Use cases:** Keyboard shortcuts, commands',
      replacedOnClick: '<kbd>Ctrl</kbd>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Samp',
      description:
          '## `<samp>` Element\n\n**Sample output** from a program or system.\n\n```html\n<samp>Hello, World!</samp>\n```\n\n**Styling:** Monospace font\n\n**Use cases:** Program output, terminal text',
      replacedOnClick: '<samp>Sample Output</samp>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Var',
      description:
          '## `<var>` Element\n\n**Variable name** in mathematical or programming context.\n\n```html\nThe variable <var>x</var> represents the value\n```\n\n**Styling:** Italic by default\n\n**Use cases:** Math variables, code variables',
      replacedOnClick: '<var>variable</var>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Datalist',
      description:
          '## `<datalist>` Element\n\n**Predefined options** for `<input>` autocomplete.\n\n```html\n<input list="browsers" />\n<datalist id="browsers">\n  <option value="Chrome">\n  <option value="Firefox">\n</datalist>\n```\n\n**Usage:** Connect to input with `list` attribute',
      replacedOnClick:
          '<datalist id="">\n  <option value=""></option>\n</datalist>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Output',
      description:
          '## `<output>` Element\n\n**Calculation result** or form output.\n\n```html\n<output name="result">0</output>\n```\n\n**Use cases:** Calculator results, form calculations\n\n**Attribute:** `for` - **Related input IDs**',
      replacedOnClick: '<output name="">Output</output>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Progress',
      description:
          '## `<progress>` Element\n\n**Progress bar** showing task completion.\n\n```html\n<progress value="70" max="100">70%</progress>\n```\n\n**Attributes:**\n- `value` - **Current value**\n- `max` - **Maximum value**\n\n**Use cases:** File uploads, downloads, task progress',
      replacedOnClick: '<progress value="0" max="100"></progress>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Meter',
      description:
          '## `<meter>` Element\n\n**Gauge** showing a scalar value within a range.\n\n```html\n<meter value="75" min="0" max="100">75%</meter>\n```\n\n**Attributes:**\n- `value` - **Current value**\n- `min`, `max` - **Range**\n- `low`, `high` - **Thresholds**\n- `optimum` - **Optimal value**',
      replacedOnClick: '<meter value="0" min="0" max="100"></meter>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Dialog',
      description:
          '## `<dialog>` Element\n\n**Modal dialog** box for user interaction.\n\n```html\n<dialog open>\n  <p>Dialog content</p>\n  <button>Close</button>\n</dialog>\n```\n\n**JavaScript API:**\n```javascript\ndialog.showModal(); // Show modal\ndialog.close(); // Close\n```\n\n**Attribute:** `open` - **Visible by default**',
      replacedOnClick: '<dialog open>\n  \n</dialog>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Template',
      description:
          '## `<template>` Element\n\n**Inert HTML template** cloned via JavaScript.\n\n```html\n<template id="item-template">\n  <li class="item"></li>\n</template>\n```\n\n**Usage:**\n```javascript\nconst template = document.getElementById("item-template");\nconst clone = template.content.cloneNode(true);\n```\n\n**Benefits:** Not rendered until cloned',
      replacedOnClick: '<template>\n  \n</template>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Noscript',
      description:
          '## `<noscript>` Element\n\n**Fallback content** when JavaScript is disabled.\n\n```html\n<noscript>\n  <p>Please enable JavaScript to use this site.</p>\n</noscript>\n```\n\n**Use cases:** Accessibility, graceful degradation',
      replacedOnClick: '<noscript>\n  \n</noscript>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Description List',
      description:
          '## `<dl>` Description List\n\n**List of terms** with their descriptions.\n\n```html\n<dl>\n  <dt>HTML</dt>\n  <dd>HyperText Markup Language</dd>\n  <dt>CSS</dt>\n  <dd>Cascading Style Sheets</dd>\n</dl>\n```\n\n**Use cases:** Glossaries, definitions, metadata',
      replacedOnClick: '<dl>\n  <dt>Term</dt>\n  <dd>Definition</dd>\n</dl>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Description Term',
      description:
          '## `<dt>` Description Term\n\n**Term** being defined in a description list.\n\n```html\n<dt>Term Name</dt>\n```\n\n**Parent:** Must be inside `<dl>` element',
      replacedOnClick: '<dt>Term</dt>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Description Definition',
      description:
          '## `<dd>` Description Definition\n\n**Definition** of the preceding term.\n\n```html\n<dd>Definition description</dd>\n```\n\n**Parent:** Must be inside `<dl>` element\n\n**Can contain:** Multiple `<dd>` for one `<dt>`',
      replacedOnClick: '<dd>Definition</dd>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Picture',
      description:
          '## `<picture>` Element\n\n**Responsive image** with multiple sources.\n\n```html\n<picture>\n  <source media="(min-width: 800px)" srcset="large.jpg">\n  <source media="(min-width: 400px)" srcset="medium.jpg">\n  <img src="small.jpg" alt="Description" />\n</picture>\n```\n\n**Benefits:** Art direction, responsive images, modern formats',
      replacedOnClick:
          '<picture>\n  <source media="(min-width: 800px)" srcset="">\n  <img src="" alt="" />\n</picture>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Track',
      description:
          '## `<track>` Element\n\n**Text track** for `<video>` and `<audio>` elements.\n\n```html\n<track src="subtitles.vtt" kind="subtitles" srclang="en" label="English" />\n```\n\n**Attributes:**\n- `kind` - **Track type** (`subtitles`, `captions`, `descriptions`)\n- `srclang` - **Language code**\n- `label` - **User-visible label**',
      replacedOnClick:
          '<track src="" kind="subtitles" srclang="en" label="English" />',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Base',
      description:
          '## `<base>` Element\n\n**Base URL** for all relative URLs in document.\n\n```html\n<base href="https://example.com/" target="_blank" />\n```\n\n**Attributes:**\n- `href` - **Base URL**\n- `target` - **Default target** (`_blank`, `_self`)\n\n**Placement:** First child of `<head>`',
      replacedOnClick: '<base href="" target="_blank" />',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Wbr',
      description:
          '## `<wbr>` Element\n\n**Word break opportunity** - suggests where to break long words.\n\n```html\nVeryLongWord<wbr />ThatNeedsBreaking\n```\n\n**Use cases:** Long URLs, technical terms, email addresses\n\n**Note:** Browser decides if break is needed',
      replacedOnClick: '<wbr />',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Q',
      description:
          '## `<q>` Element\n\n**Inline quotation** from another source.\n\n```html\n<q cite="https://example.com">Quoted text</q>\n```\n\n**Styling:** Quotation marks added automatically\n\n**Attribute:** `cite` - **Source URL**',
      replacedOnClick: '<q cite="">Quote</q>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Dfn',
      description:
          '## `<dfn>` Element\n\n**Definition term** marking the term being defined.\n\n```html\n<dfn>HTML</dfn> stands for HyperText Markup Language.\n```\n\n**Styling:** Italic by default\n\n**Use cases:** First occurrence of a term',
      replacedOnClick: '<dfn>Definition Term</dfn>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Data',
      description:
          '## `<data>` Element\n\n**Machine-readable value** with human-readable text.\n\n```html\n<data value="12345">Product #12345</data>\n```\n\n**Use cases:** Product IDs, measurements, dates\n\n**Benefits:** Both human and machine readable',
      replacedOnClick: '<data value="">Data</data>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Ruby',
      description:
          '## `<ruby>` Element\n\n**Ruby annotation** for East Asian typography.\n\n```html\n<ruby>\n  漢 <rt>kan</rt>\n</ruby>\n```\n\n**Use cases:** Pronunciation guides, translations\n\n**Contains:** Base text and `<rt>` annotations',
      replacedOnClick: '<ruby>\n  漢 <rt>kan</rt>\n</ruby>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Rt',
      description:
          '## `<rt>` Element\n\n**Ruby text** annotation above/below base text.\n\n```html\n<rt>pronunciation</rt>\n```\n\n**Parent:** Must be inside `<ruby>` element\n\n**Styling:** Smaller font, positioned above base',
      replacedOnClick: '<rt>Ruby Text</rt>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Rp',
      description:
          '## `<rp>` Element\n\n**Ruby parenthesis** fallback for browsers without ruby support.\n\n```html\n<ruby>\n  漢 <rp>(</rp><rt>kan</rt><rp>)</rp>\n</ruby>\n```\n\n**Purpose:** Shows parentheses when ruby not supported',
      replacedOnClick: '<rp>(</rp>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Bdi',
      description:
          '## `<bdi>` Element\n\n**Bidirectional isolation** for mixed-direction text.\n\n```html\n<bdi>Mixed direction text</bdi>\n```\n\n**Use cases:** User-generated content, mixed languages\n\n**Benefit:** Prevents text direction issues',
      replacedOnClick: '<bdi>Text</bdi>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Bdo',
      description:
          '## `<bdo>` Element\n\n**Bidirectional override** forcing text direction.\n\n```html\n<bdo dir="rtl">Right-to-left text</bdo>\n```\n\n**Attribute:** `dir` - **Direction** (`ltr` or `rtl`)\n\n**Use cases:** Override automatic direction detection',
      replacedOnClick: '<bdo dir="rtl">Text</bdo>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Menu',
      description:
          '## `<menu>` Element\n\n**Menu list** of commands or options.\n\n```html\n<menu>\n  <li><a href="/">Home</a></li>\n  <li><a href="/about">About</a></li>\n</menu>\n```\n\n**Note:** Consider using `<nav>` for navigation menus',
      replacedOnClick: '<menu>\n  <li>Item</li>\n</menu>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Menuitem',
      description:
          '## `<menuitem>` Element\n\n**Menu item** within a `<menu>` element.\n\n```html\n<menuitem>Menu Option</menuitem>\n```\n\n**Note:** Limited browser support, consider alternatives',
      replacedOnClick: '<menuitem>Item</menuitem>',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Param',
      description:
          '## `<param>` Element\n\n**Parameter** for `<object>` element plugins.\n\n```html\n<object data="plugin.swf">\n  <param name="autoplay" value="true" />\n</object>\n```\n\n**Attributes:**\n- `name` - **Parameter name**\n- `value` - **Parameter value**\n\n**Parent:** Must be inside `<object>`',
      replacedOnClick: '<param name="" value="" />',
      triggeredAt: '<',
    ),
    SuggestionModel(
      label: 'Slot',
      description:
          '## `<slot>` Element\n\n**Placeholder** in web component shadow DOM.\n\n```html\n<slot name="content"></slot>\n```\n\n**Usage:**\n```html\n<my-component>\n  <span slot="content">Slotted content</span>\n</my-component>\n```\n\n**Web Components:** Part of Shadow DOM API',
      replacedOnClick: '<slot name=""></slot>',
      triggeredAt: '<',
    ),
  ];
}
