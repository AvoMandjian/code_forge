# Introduction

## What is Flutter Code Editor?
Flutter Code Editor is a widget built by Akvelon that turns a standard Flutter `TextField` into a code editor. It focuses on providing a familiar API (Controller pattern) while adding essential features like highlighting, line numbers, and folding.

## Core Features

### 🔒 Controlled Editing
*   **Named Sections**: Define regions in code (e.g., `// [START demo]`) that can be hidden or made read-only.
*   **Read-Only Blocks**: Lock specific lines or sections to prevent user modification.
*   **Service Comments**: Automatically hide comments used for configuration.

### 🎨 Visuals
*   **Syntax Highlighting**: Uses `highlight` package. Supports 100+ languages.
*   **Themes**: Compatible with standard highlight themes.
*   **Gutter**: Customizable area for line numbers and fold controls.

### 🛠️ Analysis
*   **Pluggable Analyzers**: Abstract class `AbstractAnalyzer` allowing integration with backends (e.g., DartPad) or local regex checks.
*   **Issues**: Displays errors/warnings in the gutter and underlines code.

## Target Audience
*   **EdTech**: Code learning platforms needing locked template code.
*   **Web Tools**: Online snippet sharers or validators.
*   **Simple Editors**: Apps needing configuration editing (YAML/JSON).

## Limitations
*   **Large Files**: Not optimized for files > 10k lines due to full string rebuilds.
*   **Intelligence**: No built-in LSP client; "Autocomplete" is a simple word-list dictionary, not semantic.

