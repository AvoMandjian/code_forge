---
name: Add Breakpoint Support to CodeForge
overview: Add breakpoint functionality to CodeForge similar to flutter-code-editor, including breakpoint storage, toggle method, callback, and visual display in the gutter with click handling.
todos:
  - id: controller-breakpoints
    content: Add breakpoints Set<int>, onBreakpointsChanged callback, and toggleBreakpoint method to CodeForgeController
    status: completed
  - id: widget-callback
    content: Add onBreakpointsChanged parameter to CodeForge widget and connect to controller
    status: completed
    dependencies:
      - controller-breakpoints
  - id: gutter-display
    content: Add breakpoint visual display in _drawGutter method with breakpoint column and circle indicators
    status: completed
    dependencies:
      - controller-breakpoints
  - id: click-handling
    content: Add breakpoint toggle click handling in gutter click detection logic
    status: completed
    dependencies:
      - gutter-display
  - id: styling-options
    content: Add breakpointColor and showBreakpoints options to GutterStyle (optional enhancement)
    status: completed
    dependencies:
      - gutter-display
---

# Add Breakpoint Support to CodeForge

## Overview

Add breakpoint functionality to CodeForge similar to flutter-code-editor. This includes breakpoint storage in the controller, toggle method, callback support, visual display in the gutter, and click handling to toggle breakpoints.

## Implementation Plan

### 1. Add Breakpoint Support to CodeForgeController

**File**: `lib/code_forge/controller.dart`

- Add `breakpoints` field as `Set<int>` to store line numbers with breakpoints (similar to line 121 in flutter-code-editor)
- Add `onBreakpointsChanged` callback field: `void Function(Set<int> breakpoints)?` (similar to line 88)
- Add `toggleBreakpoint(int line)` method that:
- Adds/removes the line from the breakpoints set
- Calls `onBreakpointsChanged?.call(breakpoints)` if callback is set
- Calls `notifyListeners()` to trigger UI update
- Initialize `breakpoints` as empty set in constructor
- Accept `onBreakpointsChanged` as optional constructor parameter

### 2. Update CodeForge Widget to Accept Breakpoint Callback

**File**: `lib/code_forge/code_area.dart`

- Add `onBreakpointsChanged` parameter to `CodeForge` widget class
- Pass the callback to `CodeForgeController` when creating/updating the controller
- Store the callback in the widget state

### 3. Add Breakpoint Visual Display in Gutter

**File**: `lib/code_forge/code_area.dart`In `_drawGutter` method (around line 5723):

- Add a breakpoint column area (leftmost part of gutter, before line numbers)
- Calculate breakpoint column width (e.g., `fontSize * 1.5` or similar)
- For each visible line, check if `controller.breakpoints.contains(lineNumber)`
- Draw breakpoint indicator (filled circle) for lines with breakpoints:
- Use `canvas.drawCircle()` or `canvas.drawOval()` 
- Color: red (or configurable via GutterStyle)
- Size: approximately 8-10 pixels diameter
- Position: centered vertically in the line, at left edge of gutter
- Update `_gutterWidth` calculation to include breakpoint column width when breakpoints are enabled

### 4. Add Breakpoint Click Handling

**File**: `lib/code_forge/code_area.dart`In pointer event handling (around line 7107-7125):

- When clicking in gutter (`localPosition.dx < _gutterWidth`):
- Check if click is in breakpoint column area (e.g., `localPosition.dx < breakpointColumnWidth`)
- If yes, toggle breakpoint for the clicked line using `controller.toggleBreakpoint(clickedLine)`
- Return early to prevent other gutter actions (folding, line selection)
- If click is not in breakpoint column but in gutter, continue with existing logic (folding, then line selection)

### 5. Add Breakpoint Styling Option (Optional Enhancement)

**File**: `lib/code_forge/styling.dart`

- Add `breakpointColor` field to `GutterStyle` class (default: `Colors.red`)
- Add `showBreakpoints` boolean field to `GutterStyle` (default: `true`)
- Pass these options through to the renderer

## Implementation Details

### Breakpoint Column Layout

The gutter will have this structure (left to right):

1. **Breakpoint column** (if enabled): ~12-16px wide, shows breakpoint circles
2. **Fold indicator column** (if folding enabled): ~16-20px wide, shows fold icons  
3. **Line number column**: Dynamic width based on line count, shows line numbers

### Breakpoint Toggle Logic

- Line numbers are 0-indexed internally but displayed as 1-indexed
- `toggleBreakpoint` should accept 1-indexed line numbers (matching flutter-code-editor behavior)
- When toggling, convert between 0-indexed (internal) and 1-indexed (display/user-facing) as needed

### Visual Design

- Breakpoint indicator: Filled red circle, ~8-10px diameter
- Position: Vertically centered in line, horizontally at left edge of gutter
- Hover effect: Could show semi-transparent breakpoint on hover (future enhancement)

## Testing Considerations

- Test breakpoint toggle via controller method
- Test breakpoint callback invocation
- Test visual display of breakpoints in gutter
- Test click handling in breakpoint column
- Test breakpoint persistence (if needed)
- Test breakpoint behavior with folding enabled/disabled
- Test breakpoint behavior with gutter enabled/disabled

## Files to Modify

1. `lib/code_forge/controller.dart` - Add breakpoint storage and methods