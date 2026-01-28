# Architecture & Implementation Details

## Core Components

### 1. Rope (`lib/code_forge/rope.dart`)
The foundation of the editor.
*   **Classes**: `Rope` (wrapper), `_RopeNode` (abstract), `_RopeLeaf` (string content), `_RopeConcat` (internal node).
*   **Operations**: `insert`, `delete`, `substring`, `getLineText`, `findLineStart`.
*   **Balancing**: Implements rebalancing logic to keep the tree height logarithmic.

### 2. Controller (`lib/code_forge/controller.dart`)
Manages state and acts as the bridge between the UI and the Data.
*   **Extends**: `DeltaTextInputClient` (to handle platform keyboard input directly).
*   **State**: Holds the `Rope` instance, selection (`TextSelection`), and scroll state.
*   **APIs**: `foldAll()`, `unfoldAll()`, `toggleFold()`, `copy()`, `paste()`.
*   **Listeners**: Notifies the render object when text or selection changes.

### 3. Renderer (`lib/code_forge/code_area.dart`)
The `_CodeFieldRenderer` is a massive class handling all visual aspects.
*   **Layout**: Determines which lines are visible based on scroll offset and line height.
*   **Painting**:
    1.  **Gutter**: Draws background, line numbers, and fold icons.
    2.  **Selection**: Draws blue rectangles for selected ranges.
    3.  **Text**: Iterates over visible lines, builds `TextSpan`s with syntax highlighting, and paints them.
    4.  **Overlays**: Draws search highlights, diagnostics (squiggles), and AI ghost text.
*   **Input**: Handles mouse/touch events (`handleEvent`) for cursor placement and selection dragging.

### 4. Syntax Highlighter (`lib/code_forge/syntax_highlighter.dart`)
Hybrid highlighting system.
*   **Regex**: Uses `re_highlight` for fast, immediate syntax coloring.
*   **Semantic**: Asynchronously applies LSP semantic tokens on top of regex highlighting for greater accuracy.
*   **Caching**: Caches highlighted lines to avoid re-parsing unchanged code.

### 5. LSP Client (`lib/LSP/lsp.dart`)
Handles the async communication with language servers.
*   **Transport**: `LspStdioConfig` (process `stdin`/`stdout`) or `LspSocketConfig` (WebSocket).
*   **Methods**: `initialize`, `openDocument`, `didChange`, `completion`, `hover`.
*   **Synchronization**: Keeps the server's version of the document in sync with the client's `Rope` via incremental updates.

## Performance Optimization
*   **Lazy Rendering**: Only visible lines are laid out and painted.
*   **Incremental Updates**: `Rope` modification avoids full string copies.
*   **Debouncing**: AI and LSP requests are debounced to prevent flooding.
*   **Async Highlighting**: Syntax highlighting can run in background/microtasks (partial).

