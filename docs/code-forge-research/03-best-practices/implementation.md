# Best Practices & Implementation Guidelines

## 1. Controller Management
*   **Disposal**: Always dispose of `CodeForgeController` and `UndoRedoController` in your widget's `dispose()` method to prevent memory leaks, especially since they manage platform channels and large memory structures (Rope).
*   **Separation**: Keep the controller logic separate from the UI build method. Initialize it in `initState`.

## 2. Large File Handling
*   **Initial Text**: For very large files, avoid passing `initialText` to the widget constructor if you already have a controller. Set `controller.text` or populate the `Rope` directly if possible (though the API abstracts this).
*   **Async Loading**: Load file content asynchronously and update the controller to prevent UI freeze on startup.

## 3. LSP Configuration
*   **Path Validity**: Ensure `filePath` and `workspacePath` are absolute and valid on the filesystem. LSP servers often fail silently if paths are incorrect.
*   **Server Lifecycle**: Use a `FutureBuilder` to initialize `LspStdioConfig`. Do not initialize it in `build()`. Manage the server process lifecycle carefully—shutdown when the editor closes.
*   **Error Handling**: Wrap LSP initialization in try-catch blocks. LSP binaries might be missing or fail to start.

## 4. AI Usage
*   **Cost Management**: Use `debounceTime` (default 1000ms) effectively. Too low triggers API calls on every keystroke ($$$). Too high feels unresponsive.
*   **Manual Trigger**: For paid APIs, consider using `CompletionType.manual` and binding it to a hotkey or button to control costs.

## 5. Theming
*   **Consistency**: Match the `editorTheme` (syntax colors) with `gutterStyle` and `selectionStyle` for a cohesive look.
*   **Font**: Always use a monospaced font (e.g., `GoogleFonts.jetBrainsMono`) for proper alignment of guides and selection.

## 6. Platform Specifics
*   **Mobile**: Be aware that `LspStdioConfig` will likely **not work on Android/iOS** directly unless you are using something like Termux or a specialized environment. Use `LspSocketConfig` for mobile apps connecting to a remote backend.
*   **Web**: CodeForge does not support Web currently. Use `flutter_code_editor` or `code_text_field` if web support is mandatory.

