# Key Concepts

## 1. Rope Data Structure
CodeForge abandons the standard Dart `String` for text storage in favor of a **Rope**.
*   **Problem**: In a standard `String`, inserting a character at the beginning of a 1MB string requires copying the entire 1MB of data to a new memory location. This is $O(n)$.
*   **Solution**: A Rope is a binary tree where leaf nodes contain short string segments.
*   **Benefit**: Insertion and deletion involve manipulating tree nodes (splitting/concatenating), which is $O(\log n)$. This allows CodeForge to handle massive files with instant keystroke response.

## 2. Custom Rendering Pipeline
Instead of wrapping a `TextField`, CodeForge implements `LeafRenderObjectWidget` (`_CodeField`) and a custom `RenderBox` (`_CodeFieldRenderer`).
*   **Layout**: It calculates layout only for the visible viewport.
*   **Painting**: It uses `TextPainter` and `ParagraphBuilder` directly on the canvas.
*   **Gutter**: The gutter (line numbers, folds) is drawn as part of the same render pass, ensuring perfect synchronization with scrolling.

## 3. Language Server Protocol (LSP)
CodeForge acts as an **LSP Client**.
*   **Server**: It connects to an external process (e.g., `pyright`, `dart language-server`) or a WebSocket.
*   **Communication**: It sends JSON-RPC messages (`textDocument/didChange`, `textDocument/completion`) and receives responses.
*   **Capabilities**:
    *   **Diagnostics**: The server pushes error lists, which CodeForge renders as red squiggles.
    *   **Semantic Tokens**: The server provides token types (e.g., "class", "variable") for high-accuracy highlighting, overriding basic regex highlighting.

## 4. AI Completion Engine
The `AiCompletion` module runs in parallel with editing.
*   **Debounce**: It waits for a pause in typing (configurable, default 1000ms).
*   **Context**: It sends the surrounding code (cursor prefix/suffix) to an LLM.
*   **Ghost Text**: The response is rendered as a semi-transparent overlay *ahead* of the cursor.
*   **Acceptance**: Pressing `Tab` inserts the suggestion.

