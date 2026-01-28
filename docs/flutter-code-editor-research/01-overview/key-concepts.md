# Key Concepts

## 1. CodeController
The heart of the package.
*   **Inheritance**: Extends `TextEditingController`.
*   **Dual State**:
    *   `fullText`: The complete content of the file.
    *   `text` (super): The content currently *visible* to the Flutter framework. Folded blocks are stripped out here.
*   **Mapping**: The controller translates cursor positions from "visible" coordinates to "full" coordinates (`CodeLines` class).

## 2. CodeField
The UI widget.
*   **Wrapper**: Wraps a `TextField` (or `LinkedScrollController` setup).
*   **Gutter**: Renders a separate widget side-by-side with the text field for line numbers.
*   **Overlay**: Manages the autocomplete popup and search widgets.

## 3. Modifiers
A plugin system for keystrokes.
*   **CodeModifier**: Abstract class for altering text on specific keys.
*   **Examples**: `IndentModifier` (Tab), `CloseBlockModifier` (auto-closing brackets).

## 4. Folding Engine
*   **Parsers**: Language-specific parsers (`IndentFoldableBlockParser` for Python, `HighlightFoldableBlockParser` for others).
*   **Blocks**: Identifies start/end lines of blocks.
*   **State**: Stores `foldedBlocks` set in the controller.

