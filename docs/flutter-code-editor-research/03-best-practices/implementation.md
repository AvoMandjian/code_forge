# Best Practices

## 1. Web Optimization
Since this package is popular for web:
*   **Disable Spellcheck**: Use the built-in `disableSpellCheckIfWeb()` if you see browser squiggles interfering with code highlighting.
*   **Font Loading**: Ensure your monospaced font is loaded *before* rendering the editor to avoid layout shifts in the gutter.

## 2. Managing State
*   **FullText vs Text**: Always read `controller.fullText` when saving the file to disk/db. Reading `controller.text` will result in data loss (folded blocks missing).
*   **Disposal**: Dispose the controller to stop the analysis timer and autocomplete listeners.

## 3. Custom Analyzers
If building a serious editor:
*   **Don't use Default**: The default analyzer only checks brackets.
*   **Implement AbstractAnalyzer**: Even if you don't have a full LSP, simple Regex checks for syntax errors in your specific language will vastly improve UX.

## 4. Performance Tuning
*   **Named Sections**: If the file is huge but the user only needs to edit a function, use `visibleSectionNames` to hide the rest. The editor renders faster if the *visible* text is small, even if `fullText` is large.

