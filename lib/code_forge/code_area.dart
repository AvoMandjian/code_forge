import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:code_forge/code_forge/suggestion_model.dart';
import 'package:code_forge/code_forge/suggestion_model.dart';
import 'package:code_forge/code_forge/suggestions/initialize_language_specific_suggestions.dart';
import 'package:code_forge/code_forge/suggestions/initialize_language_specific_suggestions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:jinja_app_widgets_catalog/jinja_app_widgets_catalog.dart';
import 'package:jinja_app_widgets_catalog/jinja_app_widgets_catalog.dart';
import 'package:re_highlight/languages/dart.dart';
import 'package:re_highlight/languages/dart.dart';
import 'package:re_highlight/re_highlight.dart';
import 'package:re_highlight/re_highlight.dart';
import 'package:re_highlight/styles/vs2015.dart';
import 'package:re_highlight/styles/vs2015.dart';

import '../AI_completion/ai.dart';
import '../AI_completion/ai.dart';
import '../LSP/lsp.dart';
import 'code_formatter.dart';
import 'controller.dart';
import 'find_controller.dart';
import 'scroll.dart';
import 'styling.dart';
import 'syntax_highlighter.dart';
import 'tag_completion.dart';
import 'undo_redo.dart';

/// A highly customizable code editor widget for Flutter.
///
/// [CodeForge] provides a feature-rich code editing experience with support for:
/// - Syntax highlighting for multiple languages
/// - Code folding
/// - Line numbers and gutter
/// - Auto-indentation and bracket matching
/// - LSP (Language Server Protocol) integration
/// - AI code completion
/// - Undo/redo functionality
/// - Search highlighting
///
/// Example:
/// ```dart
/// final controller = CodeForgeController();
///
/// CodeForge(
///   controller: controller,
///   language: langDart,
///   enableFolding: true,
///   enableGutter: true,
///   textStyle: TextStyle(
///     fontFamily: 'JetBrains Mono',
///     fontSize: 14,
///   ),
/// )
/// ```
class CodeForge extends StatefulWidget {
  /// The controller for managing the editor's text content and selection.
  ///
  /// If not provided, an internal controller will be created.
  final CodeForgeController? controller;

  /// The finder controller for managing search functionality.
  ///
  /// If not provided, an internal finder controller will be created.
  final FindController? findController;

  /// The controller for managing undo/redo operations.
  ///
  /// If provided, enables undo/redo functionality in the editor.
  final UndoRedoController? undoController;

  /// The syntax highlighting theme as a map of token types to [TextStyle].
  ///
  /// Uses VS2015 dark theme by default if not specified.
  final Map<String, TextStyle>? editorTheme;

  /// The programming language mode for syntax highlighting.
  ///
  /// Determines which language syntax rules to apply. Uses Python mode
  /// by default if not specified.
  final Mode? language;

  /// The focus node for managing keyboard focus.
  ///
  /// If not provided, an internal focus node will be created.
  final FocusNode? focusNode;

  /// The base text style for the editor content.
  ///
  /// Defines the font family, size, and other text properties.
  final TextStyle? textStyle;

  /// Configuration for AI-powered code completion.
  ///
  /// When provided, enables AI suggestions while typing.
  final AiCompletion? aiCompletion;

  /// The text style for ghost text (inline suggestions).
  ///
  /// This style is applied to the semi-transparent suggestion text
  /// that appears inline. Ghost text is set via the controller's
  /// `setGhostText()` method. If not specified, defaults to the
  /// editor's base text style with reduced opacity.
  ///
  /// Example:
  /// ```dart
  /// CodeForge(
  ///   ghostTextStyle: TextStyle(
  ///     color: Colors.grey.withOpacity(0.5),
  ///     fontStyle: FontStyle.italic,
  ///   ),
  /// )
  /// ```
  final TextStyle? ghostTextStyle;

  /// Padding inside the editor content area.
  final EdgeInsets? innerPadding;

  /// Custom scroll controller for vertical scrolling.
  final ScrollController? verticalScrollController;

  /// Custom scroll controller for horizontal scrolling.
  final ScrollController? horizontalScrollController;

  /// Styling options for text selection and cursor.
  final CodeSelectionStyle? selectionStyle;

  /// Styling options for the gutter (line numbers and fold icons).
  final GutterStyle? gutterStyle;

  /// Styling options for the autocomplete suggestion popup.
  final SuggestionStyle? suggestionStyle;

  /// Styling options for the autocomplete suggestion description popup.
  final SuggestionStyle? suggestionDescriptionStyle;

  /// Styling options for hover documentation popup.
  final HoverDetailsStyle? hoverDetailsStyle;

  /// Styling options for search match highlighting.
  final MatchHighlightStyle? matchHighlightStyle;

  /// The file path for LSP features.
  ///
  /// Required when using LSP integration to identify the document.
  final String? filePath;

  /// Initial text content for the editor.
  ///
  /// Used only during initialization; subsequent changes should use
  /// the controller.
  final String? initialText;

  /// Configuration for Language Server Protocol integration.
  ///
  /// Enables advanced features like hover documentation, diagnostics,
  /// and semantic highlighting.
  final LspConfig? lspConfig;

  /// Whether the editor is in read-only mode.
  ///
  /// When true, the user cannot modify the text content.
  final bool readOnly;

  /// Whether to wrap long lines.
  ///
  /// When true, lines wrap at the editor boundary. When false,
  /// horizontal scrolling is enabled.
  final bool lineWrap;

  /// Whether to automatically focus the editor when mounted.
  final bool autoFocus;

  /// Whether to enable code folding functionality.
  ///
  /// When true, fold icons appear in the gutter and code blocks
  /// can be collapsed.
  final bool enableFolding;

  /// Whether to show indentation guide lines.
  ///
  /// Displays vertical lines at each indentation level to help
  /// visualize code structure.
  final bool enableGuideLines;

  /// Whether to show the gutter with line numbers.
  final bool enableGutter;

  /// Whether to show a divider line between gutter and content.
  final bool enableGutterDivider;

  /// Whether to enable autocomplete suggestions.
  ///
  /// Requires LSP integration for language-aware completions.
  final bool enableSuggestions;

  /// Builder for a custom Finder widget.
  ///
  /// This builder is called to create the finder/search widget. It provides
  /// the [FindController] which can be used to control search functionality.
  /// The returned widget should implement [PreferredSizeWidget].
  final PreferredSizeWidget Function(
    BuildContext context,
    FindController findController,
  )?
  finderBuilder;

  /// Callback function called when Command+S (or Ctrl+S) is pressed.
  ///
  /// This callback is invoked when the user presses the save shortcut.
  /// Typically used to save the current file content.
  final VoidCallback? saveFile;

  /// Callback function called when Command+Shift+F (or Ctrl+Shift+F) is pressed.
  ///
  /// This callback is invoked when the user presses the format shortcut.
  /// If not provided, automatic formatting will be attempted based on the
  /// current language (supports JSON, HTML, SQL, Jinja).
  final String Function(String)? formatCode;

  /// Callback function called when breakpoints are added or removed.
  ///
  /// This callback receives a [Set<int>] containing all current breakpoint
  /// line numbers (1-indexed). Called whenever a breakpoint is toggled.
  final void Function(Set<int> breakpoints)? onBreakpointsChanged;

  /// Creates a [CodeForge] code editor widget.
  const CodeForge({
    super.key,
    this.controller,
    this.undoController,
    this.editorTheme,
    this.language,
    this.lspConfig,
    this.aiCompletion,
    this.ghostTextStyle,
    this.filePath,
    this.initialText,
    this.focusNode,
    this.verticalScrollController,
    this.horizontalScrollController,
    this.textStyle,
    this.innerPadding,
    this.readOnly = false,
    this.autoFocus = false,
    this.lineWrap = false,
    this.enableFolding = true,
    this.enableGuideLines = true,
    this.enableSuggestions = true,
    this.enableGutter = true,
    this.enableGutterDivider = false,
    this.selectionStyle,
    this.gutterStyle,
    this.suggestionStyle,
    this.suggestionDescriptionStyle,
    this.hoverDetailsStyle,
    this.matchHighlightStyle,
    this.finderBuilder,
    this.findController,
    this.saveFile,
    this.formatCode,
    this.onBreakpointsChanged,
  });

  @override
  State<CodeForge> createState() => _CodeForgeState();
}

class _CodeForgeState extends State<CodeForge>
    with SingleTickerProviderStateMixin {
  static const _semanticTokenDebounce = Duration(milliseconds: 500);
  late final ScrollController _hscrollController, _vscrollController;
  late final CodeForgeController _controller;
  late final FocusNode _focusNode;
  late final AnimationController _caretBlinkController;
  late final AnimationController _lineHighlightController;
  late Map<String, TextStyle> _editorTheme;
  late Mode _language;
  late final CodeSelectionStyle _selectionStyle;
  late GutterStyle _gutterStyle;
  late SuggestionStyle _suggestionStyle;
  late SuggestionStyle _suggestionDescriptionStyle;
  final Map<String, String> _cachedResponse = {};

  late HoverDetailsStyle _hoverDetailsStyle;
  late final ValueNotifier<List<dynamic>?> _suggestionNotifier, _hoverNotifier;
  late final ValueNotifier<List<LspErrors>> _diagnosticsNotifier;
  late final ValueNotifier<LspSignatureHelps?> _lspSignatureNotifier;
  late final ValueNotifier<String?> _aiNotifier;
  late final ValueNotifier<Offset?> _aiOffsetNotifier;
  late final ValueNotifier<Offset> _contextMenuOffsetNotifier;
  late final ValueNotifier<bool> _selectionActiveNotifier, _isHoveringPopup;
  late final ValueNotifier<List<dynamic>?> _lspActionNotifier;
  late final UndoRedoController _undoRedoController;
  late final String? _filePath;
  late final VoidCallback _semanticTokensListener;
  late final VoidCallback _controllerListener;
  final ValueNotifier<Offset> _offsetNotifier = ValueNotifier(Offset(0, 0));
  final ValueNotifier<Offset?> _lspActionOffsetNotifier = ValueNotifier(null);
  final bool _isMobile =
      defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS;
  final _suggScrollController = ScrollController();
  final _actionScrollController = ScrollController();
  final Map<String, String> _suggestionDetailsCache = {};
  TextInputConnection? _connection;
  StreamSubscription? _lspResponsesSubscription;
  bool _lspReady = false, _isHovering = false, _isTyping = false;
  bool _isSignatureInvoked = false;
  String _previousValue = "";
  TextSelection _prevSelection = TextSelection.collapsed(offset: 0);
  List<dynamic> _suggestions = [];
  List<LspSemanticToken>? _semanticTokens;
  List<Map<String, dynamic>> _extraText = [];
  int _semanticTokensVersion = 0;
  int _sugSelIndex = 0, _actionSelIndex = 0;
  String? _selectedSuggestionMd;
  Timer? _hoverTimer, _aiDebounceTimer, _semanticTokenTimer;
  late final FindController _findController;

  // Search functionality
  bool _isSearchVisible = false;
  String _searchText = '';
  int _currentMatchIndex = -1;
  List<SearchHighlight> _searchMatches = [];
  final _searchController = TextEditingController();
  final _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? CodeForgeController();
    _findController = widget.findController ?? FindController(_controller);
    _focusNode = widget.focusNode ?? FocusNode();
    _hscrollController =
        widget.horizontalScrollController ?? ScrollController();
    _vscrollController = widget.verticalScrollController ?? ScrollController();
    _editorTheme =
        _controller.currentTheme ?? widget.editorTheme ?? vs2015Theme;
    _language = _controller.currentLanguage ?? widget.language ?? langDart;

    // Sync widget language back to controller if controller doesn't have one
    if (_controller.currentLanguage == null && widget.language != null) {
      _controller.currentLanguage = widget.language;
      // Initialize language-specific suggestions
      initializeLanguageSpecificSuggestions(
        currentLanguage: _language,
        registerCustomSuggestions: _controller.registerCustomSuggestions,
      );
    } else if (_controller.currentLanguage != null) {
      // Initialize suggestions if language is already set
      initializeLanguageSpecificSuggestions(
        currentLanguage: _language,
        registerCustomSuggestions: _controller.registerCustomSuggestions,
      );
    }
    _suggestionNotifier = _controller.suggestionsNotifier;
    _diagnosticsNotifier = _controller.diagnosticsNotifier;
    _lspActionNotifier = _controller.codeActionsNotifier;
    _lspSignatureNotifier = _controller.signatureNotifier;
    _hoverNotifier = ValueNotifier(null);
    _aiNotifier = ValueNotifier(null);
    _aiOffsetNotifier = ValueNotifier(null);
    _contextMenuOffsetNotifier = ValueNotifier(const Offset(-1, -1));
    _selectionActiveNotifier = ValueNotifier(false);
    _isHoveringPopup = ValueNotifier<bool>(false);
    _controller.userCodeAction = _fetchCodeActionsForCurrentPosition;
    _controller.saveFileCallback = widget.saveFile;
    _controller.showCustomSuggestionsCallback = _showCustomSuggestions;
    _controller.setAiCompletion(widget.aiCompletion);
    _controller.readOnly = widget.readOnly;
    _selectionStyle = widget.selectionStyle ?? CodeSelectionStyle();
    _undoRedoController = widget.undoController ?? UndoRedoController();
    _filePath = widget.filePath;

    _controller.setUndoController(_undoRedoController);

    _gutterStyle =
        widget.gutterStyle ??
        GutterStyle(
          lineNumberStyle: null,
          foldedIconColor: _editorTheme['root']?.color,
          unfoldedIconColor: _editorTheme['root']?.color,
          backgroundColor: _editorTheme['root']?.backgroundColor,
        );

    _suggestionStyle =
        widget.suggestionStyle ??
        SuggestionStyle(
          elevation: 6,
          highlightColor: Colors.blueAccent.withAlpha(50),
          textStyle: (() {
            TextStyle style = widget.textStyle ?? TextStyle();
            if (style.color == null) {
              style = style.copyWith(color: _editorTheme['root']!.color);
            }
            return style;
          })(),
          backgroundColor:
              _editorTheme['root']?.backgroundColor ?? Colors.white,
          focusColor: Color(0xff024281),
          hoverColor: Colors.grey.withAlpha(15),
          splashColor: Colors.blueAccent.withAlpha(50),
          shape: BeveledRectangleBorder(
            side: BorderSide(
              color: _editorTheme['root']!.color ?? Colors.grey[400]!,
              width: 0.2,
            ),
          ),
        );

    _hoverDetailsStyle =
        widget.hoverDetailsStyle ??
        HoverDetailsStyle(
          highlightColor: Colors.blueAccent.withAlpha(50),
          shape: BeveledRectangleBorder(
            side: BorderSide(
              color: _editorTheme['root']!.color ?? Colors.grey[400]!,
              width: 0.2,
            ),
          ),
          backgroundColor: (() {
            final lightnessDelta = 0.03;
            final base = _editorTheme['root']!.backgroundColor!;
            final hsl = HSLColor.fromColor(base);
            final newLightness = (hsl.lightness + lightnessDelta).clamp(
              0.0,
              1.0,
            );
            return hsl.withLightness(newLightness).toColor();
          })(),
          focusColor: Colors.blueAccent.withAlpha(50),
          hoverColor: Colors.grey.withAlpha(15),
          splashColor: Colors.blueAccent.withAlpha(50),
          textStyle: (() {
            TextStyle style = widget.textStyle ?? _editorTheme['root']!;
            if (style.color == null) {
              style = style.copyWith(color: _editorTheme['root']!.color);
            }
            return style;
          })(),
        );

    _caretBlinkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);

    _lineHighlightController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _semanticTokensListener = () {
      final tokens = _controller.semanticTokens.value;
      if (!mounted) return;
      setState(() {
        _semanticTokens = tokens.$1;
        _semanticTokensVersion = tokens.$2;
      });
    };
    _controller.semanticTokens.addListener(_semanticTokensListener);

    _focusNode.addListener(() {
      if (_focusNode.hasFocus && !widget.readOnly) {
        if (_connection == null || !_connection!.attached) {
          _connection = TextInput.attach(
            _controller,
            const TextInputConfiguration(
              readOnly: false,
              enableDeltaModel: true,
              inputType: TextInputType.multiline,
              inputAction: TextInputAction.newline,
              autocorrect: false,
            ),
          );

          _controller.connection = _connection;
          _connection!.show();
          _connection!.setEditingState(
            TextEditingValue(
              text: _controller.text,
              selection: _controller.selection,
            ),
          );
        }
      }
    });

    Future.microtask(CustomIcons.loadAllCustomFonts);

    if (_filePath == null && _controller.lspConfig != null) {
      throw ArgumentError(
        "The `filePath` parameter cannot be null inorder to use `LspConfig`."
        "A valid file path is required to use the LSP services.",
      );
    }

    if (_filePath != null) {
      if (widget.initialText != null) {
        throw ArgumentError(
          'Cannot provide both filePath and initialText to CodeForge.',
        );
      } else if (_filePath.isNotEmpty) {
        if (_controller.openedFile != _filePath) {
          _controller.openedFile = _filePath;
        }
      }
    } else if (widget.initialText != null && widget.initialText!.isNotEmpty) {
      _controller.text = widget.initialText!;
    }

    _controllerListener = () {
      _resetCursorBlink();

      if (_controller.lastTypedCharacter == '(') {
        _isSignatureInvoked = true;
      } else if (_controller.lastTypedCharacter == ')') {
        _isSignatureInvoked = false;
      }

      if (_isSignatureInvoked) {
        if (_controller.lspConfig != null) {
          (() async => await _callSignatureHelp())();
        }
      } else if (_lspSignatureNotifier.value != null) {
        _lspSignatureNotifier.value = null;
      }

      if (_hoverNotifier.value != null && mounted) {
        _hoverTimer?.cancel();
        _hoverNotifier.value = null;
      }
    };

    _controller.addListener(_controllerListener);

    _lspSignatureNotifier.addListener(() {
      if (_lspSignatureNotifier.value != null) {
        if (_lspSignatureNotifier.value!.parameters.isEmpty) {
          _lspSignatureNotifier.value = null;
          setState(() {
            _isSignatureInvoked = false;
          });
          return;
        }
      }
    });

    _controller.addListener(() {
      bool styleChanged = false;
      if (_controller.currentLanguage != null &&
          _controller.currentLanguage != _language) {
        _language = _controller.currentLanguage!;
        // Language changed - suggestions will be re-initialized by controller
        styleChanged = true;
      }
      if (_controller.currentTheme != null &&
          _editorTheme != _controller.currentTheme) {
        _editorTheme = _controller.currentTheme!;
        _updateStyles();
        styleChanged = true;
      }

      // Sync rulers from controller to render object
      // This will be handled in updateRenderObject when setState is called

      if (styleChanged) {
        if (mounted) setState(() {});
      }

      final text = _controller.text;
      final currentSelection = _controller.selection;
      final cursorPosition = currentSelection.extentOffset;
      final line = _controller.getLineAtOffset(cursorPosition);
      final lineStartOffset = _controller.getLineStartOffset(line);
      final character = cursorPosition - lineStartOffset;
      final prefix = _getCurrentWordPrefix(text, cursorPosition);

      _isTyping = false;

      _resetCursorBlink();

      final oldText = _previousValue;
      final oldSelection = _prevSelection;

      if (_hoverNotifier.value != null) {
        _hoverTimer?.cancel();
        _hoverNotifier.value = null;
      }

      if (widget.lspConfig != null && _lspReady && text != _previousValue) {
        _previousValue = text;
        (() async {
          final lspConfig = widget.lspConfig!;
          await lspConfig.updateDocument(_filePath!, text);
          _scheduleSemantictokenRefresh();
          final suggestion = await lspConfig.getCompletions(
            _filePath,
            line,
            character,
          );
          _suggestions = suggestion;
        })();
      }

      _aiDebounceTimer?.cancel();

      // Check AI completion from controller if available, otherwise fall back to widget
      final aiCompletion = _controller.aiCompletion ?? widget.aiCompletion;
      if (aiCompletion != null &&
          _controller.selection.isValid &&
          aiCompletion.enableCompletion &&
          _aiNotifier.value == null) {
        if (_suggestionNotifier.value != null) return;
        final text = _controller.text;
        final cursorPosition = _controller.selection.extentOffset.clamp(
          0,
          _controller.length,
        );
        final textAfterCursor = text.substring(cursorPosition);
        if (cursorPosition <= 0) return;
        bool lineEnd =
            textAfterCursor.isEmpty ||
            textAfterCursor.startsWith('\n') ||
            textAfterCursor.trim().isEmpty;
        if (!lineEnd) return;
        final codeToSend =
            "${text.substring(0, cursorPosition)}<|CURSOR|>${text.substring(cursorPosition)}";
        if (aiCompletion.completionType == CompletionType.auto ||
            aiCompletion.completionType == CompletionType.mixed) {
          _aiDebounceTimer = Timer(
            Duration(milliseconds: aiCompletion.debounceTime),
            () async {
              final aiComp = _controller.aiCompletion ?? widget.aiCompletion;
              if (aiComp != null) {
                _aiNotifier.value = await _getCachedResponse(
                  codeToSend,
                  aiComp,
                );
              }
            },
          );
        }
      }

      if (text.length == oldText.length + 1 &&
          currentSelection.baseOffset == oldSelection.baseOffset + 1) {
        final insertedChar = text.substring(
          _prevSelection.baseOffset,
          currentSelection.baseOffset,
        );
        _isTyping =
            insertedChar.isNotEmpty &&
            RegExp(r'[a-zA-Z]').hasMatch(insertedChar);

        // Check for HTML/Jinja tag completion
        final language = _controller.currentLanguage?.name;
        if (widget.enableSuggestions &&
            TagCompletion.supportsTagCompletion(
              language,
              text: text,
              cursorPosition: cursorPosition,
            ) &&
            widget.lspConfig == null) {
          final tagContext = TagCompletion.analyzeTagContext(
            text,
            cursorPosition,
          );

          // Check if we're typing '<', '/', '{', '%', or within a tag
          // For Jinja: typing '{', '%', or '%' after '{%' triggers suggestions
          final twoCharsBefore = cursorPosition >= 2
              ? text.substring(cursorPosition - 2, cursorPosition)
              : '';
          final threeCharsBefore = cursorPosition >= 3
              ? text.substring(cursorPosition - 3, cursorPosition)
              : '';

          final isJinjaTrigger =
              insertedChar == '{' ||
              insertedChar == '%' ||
              twoCharsBefore == '{%' ||
              threeCharsBefore == '{%%';

          if (insertedChar == '<' ||
              insertedChar == '/' ||
              isJinjaTrigger ||
              tagContext.isInTag) {
            final tagSuggestions = TagCompletion.getTagSuggestions(
              text,
              cursorPosition,
              language,
              registeredSuggestions: _controller.registeredCustomSuggestions,
            );
            if (tagSuggestions.isNotEmpty) {
              _suggestions = tagSuggestions;
              _sortSuggestions(tagContext.prefix);
              if (mounted) {
                _sugSelIndex = 0;
                _suggestionNotifier.value = _suggestions;
              }
              _previousValue = text;
              _prevSelection = currentSelection;
              return;
            }
          }
        }

        // Check for custom suggestion triggers
        if (widget.enableSuggestions &&
            _controller.registeredCustomSuggestions.isNotEmpty) {
          final textBeforeCursor = text.substring(0, cursorPosition);
          final textAfterCursor = text.substring(cursorPosition);
          final matchingSuggestions = _checkTriggerPatterns(
            textBeforeCursor,
            textAfterCursor,
            cursorPosition,
          );
          if (matchingSuggestions.isNotEmpty) {
            // Show matching custom suggestions
            _suggestions = matchingSuggestions;
            _sugSelIndex = 0;
            if (mounted) {
              _suggestionNotifier.value = matchingSuggestions;
            }
            _previousValue = text;
            _prevSelection = currentSelection;
            return;
          }
        }

        if (widget.enableSuggestions &&
            _isTyping &&
            prefix.isNotEmpty &&
            _controller.selection.extentOffset > 0) {
          if (widget.lspConfig == null) {
            final regExp = RegExp(r'\b\w+\b');
            final List<String> words = regExp
                .allMatches(text)
                .map((m) => m.group(0)!)
                .toList();
            String currentWord = '';
            if (text.isNotEmpty) {
              final match = RegExp(r'\w+$').firstMatch(text);
              if (match != null) {
                currentWord = match.group(0)!;
              }
            }
            _suggestions.clear();
            for (final i in words) {
              if (!_suggestions.contains(i) && i != currentWord) {
                _suggestions.add(i);
              }
            }
            if (prefix.isNotEmpty) {
              _suggestions = _suggestions
                  .where((s) => s.startsWith(prefix))
                  .toList();
            }
          }
          _sortSuggestions(prefix);
          final triggerChar = text[cursorPosition - 1];
          if (!RegExp(r'[a-zA-Z]').hasMatch(triggerChar)) {
            _suggestionNotifier.value = null;
            return;
          }
          if (mounted && _suggestions.isNotEmpty) {
            _sugSelIndex = 0;
            _suggestionNotifier.value = _suggestions;
          }
        } else {
          _suggestionNotifier.value = null;
        }
      }

      // Also check for custom suggestion triggers on any text change
      // This handles cases like typing within a trigger pattern after it was already started
      if (widget.enableSuggestions &&
          _controller.registeredCustomSuggestions.isNotEmpty &&
          text != oldText) {
        final textBeforeCursor = text.substring(0, cursorPosition);
        final textAfterCursor = text.substring(cursorPosition);
        final matchingSuggestions = _checkTriggerPatterns(
          textBeforeCursor,
          textAfterCursor,
          cursorPosition,
        );
        if (matchingSuggestions.isNotEmpty) {
          // Show matching custom suggestions
          _suggestions = matchingSuggestions;
          _sugSelIndex = 0;
          if (mounted) {
            _suggestionNotifier.value = matchingSuggestions;
          }
        } else if (_suggestionNotifier.value != null &&
            _suggestionNotifier.value!.isNotEmpty &&
            _suggestionNotifier.value!.first is SuggestionModel) {
          // Clear custom suggestions if trigger pattern is no longer present
          _suggestionNotifier.value = null;
        }
      }

      // Also check for tag completion on any text change (not just single char insertions)
      // This handles cases like typing within a tag after it was already opened
      if (widget.enableSuggestions &&
          TagCompletion.supportsTagCompletion(
            _controller.currentLanguage?.name,
            text: text,
            cursorPosition: cursorPosition,
          ) &&
          widget.lspConfig == null &&
          text != oldText) {
        final tagContext = TagCompletion.analyzeTagContext(
          text,
          cursorPosition,
        );
        if (tagContext.isInTag) {
          final tagSuggestions = TagCompletion.getTagSuggestions(
            text,
            cursorPosition,
            _controller.currentLanguage?.name,
            registeredSuggestions: _controller.registeredCustomSuggestions,
          );
          if (tagSuggestions.isNotEmpty) {
            _suggestions = tagSuggestions;
            _sortSuggestions(tagContext.prefix);
            if (mounted) {
              _sugSelIndex = 0;
              _suggestionNotifier.value = _suggestions;
            }
          } else {
            _suggestionNotifier.value = null;
          }
        }
      }

      _previousValue = text;
      _prevSelection = currentSelection;
    });

    _isHoveringPopup.addListener(() {
      if (!_isHoveringPopup.value && _hoverNotifier.value != null) {
        _hoverNotifier.value = null;
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.autoFocus) {
        _focusNode.requestFocus();
      }
    });
  }

  void _scrollToSelectedSuggestion() {
    if (!_suggScrollController.hasClients) return;

    final itemExtent = (widget.textStyle?.fontSize ?? 14) + 6.5;
    final selectedOffset = _sugSelIndex * itemExtent;
    final currentScroll = _suggScrollController.offset;
    final viewportHeight = _suggScrollController.position.viewportDimension;

    double? targetOffset;

    if (selectedOffset < currentScroll) {
      targetOffset = selectedOffset;
    } else if (selectedOffset + itemExtent > currentScroll + viewportHeight) {
      targetOffset = selectedOffset - viewportHeight + itemExtent;
    }

    if (targetOffset != null) {
      _suggScrollController.jumpTo(
        targetOffset.clamp(
          _suggScrollController.position.minScrollExtent,
          _suggScrollController.position.maxScrollExtent,
        ),
      );
    }
  }

  void _scrollToSelectedAction() {
    if (!_actionScrollController.hasClients) return;

    final itemExtent = (widget.textStyle?.fontSize ?? 14) + 6.5;
    final selectedOffset = _actionSelIndex * itemExtent;
    final currentScroll = _actionScrollController.offset;
    final viewportHeight = _actionScrollController.position.viewportDimension;

    double? targetOffset;

    if (selectedOffset < currentScroll) {
      targetOffset = selectedOffset;
    } else if (selectedOffset + itemExtent > currentScroll + viewportHeight) {
      targetOffset = selectedOffset - viewportHeight + itemExtent;
    }

    if (targetOffset != null) {
      _actionScrollController.jumpTo(
        targetOffset.clamp(
          _actionScrollController.position.minScrollExtent,
          _actionScrollController.position.maxScrollExtent,
        ),
      );
    }
  }

  String _getCurrentWordPrefix(String text, int offset) {
    final safeOffset = offset.clamp(0, text.length);
    final beforeCursor = text.substring(0, safeOffset);
    final match = RegExp(r'([a-zA-Z_][a-zA-Z0-9_]*)$').firstMatch(beforeCursor);
    return match?.group(0) ?? '';
  }

  /// Checks if the cursor is within a Jinja block (`{% ... %}` or `{{ ... }}`).
  ///
  /// Searches backwards from the cursor for opening tags (`{%` or `{{`) and
  /// forwards for closing tags (`%}` or `}}`), ensuring they match correctly.
  ///
  /// Returns true if the cursor is between matching Jinja tags.
  bool isCursorInJinjaBlock(
    String textBeforeCursor,
    String? textAfterCursor,
    int cursorPosition,
  ) {
    textAfterCursor ??= '';

    // Find the nearest opening tag before cursor
    int statementOpenIndex = textBeforeCursor.lastIndexOf('{%');
    int expressionOpenIndex = textBeforeCursor.lastIndexOf('{{');

    // Determine which type of block we're potentially in
    bool inStatementBlock = statementOpenIndex != -1;
    bool inExpressionBlock = expressionOpenIndex != -1;

    // If we found both, use the one closest to cursor
    if (inStatementBlock && inExpressionBlock) {
      if (statementOpenIndex > expressionOpenIndex) {
        inExpressionBlock = false;
      } else {
        inStatementBlock = false;
      }
    }

    if (!inStatementBlock && !inExpressionBlock) {
      return false;
    }

    // Find the corresponding closing tag after cursor
    int closingIndex = -1;
    if (inStatementBlock) {
      closingIndex = textAfterCursor.indexOf('%}');
    } else if (inExpressionBlock) {
      closingIndex = textAfterCursor.indexOf('}}');
    }

    if (closingIndex == -1) {
      // No closing tag found, but we might be typing it
      // Check if we're in an incomplete block (opening without closing)
      // For filter suggestions, we allow incomplete blocks
      return true;
    }

    // Verify the block is properly formed
    // Check that there's no unmatched closing tag before our opening tag
    final openIndex = inStatementBlock
        ? statementOpenIndex
        : expressionOpenIndex;
    final openTag = inStatementBlock ? '{%' : '{{';
    final closeTag = inStatementBlock ? '%}' : '}}';

    // Count nested blocks between opening and cursor
    final textBetween = textBeforeCursor.substring(openIndex + 2);

    // Count opening and closing tags in the text between opening tag and cursor
    int openCount = textBetween.split(openTag).length - 1;
    int closeCount = textBetween.split(closeTag).length - 1;

    // If we have more closing tags than opening tags before cursor, we're outside
    if (closeCount > openCount) {
      return false;
    }

    // Check if there are any unmatched closing tags before our opening tag
    final beforeOpen = textBeforeCursor.substring(0, openIndex);
    final unmatchedCloses =
        (beforeOpen.split(closeTag).length - 1) -
        (beforeOpen.split(openTag).length - 1);
    if (unmatchedCloses > 0) {
      // There are unmatched closing tags, so we might be in a nested block
      // This is acceptable - we're still in a Jinja block
    }

    return true;
  }

  /// Checks for matching trigger patterns in the text before cursor.
  ///
  /// Returns a list of suggestions whose trigger patterns match as a prefix
  /// of the text before the cursor. Handles multiple triggers by prioritizing
  /// longest matches first. Also handles cases where the cursor is in the middle
  /// of a trigger pattern (e.g., "{{|}}" where | is cursor).
  ///
  /// Validates context requirements before including suggestions in the results.
  List<SuggestionModel> _checkTriggerPatterns(
    String textBeforeCursor,
    String? textAfterCursor,
    int cursorPosition,
  ) {
    final registeredSuggestions = _controller.registeredCustomSuggestions;
    if (registeredSuggestions.isEmpty) {
      return [];
    }

    // Find the maximum trigger length to optimize substring extraction
    final maxTriggerLength = registeredSuggestions
        .map((s) => s.triggeredAt.length)
        .reduce((a, b) => a > b ? a : b);

    // Get enough text before cursor to check all possible triggers
    final checkLength = textBeforeCursor.length.clamp(0, maxTriggerLength);
    final textToCheck = textBeforeCursor.substring(
      textBeforeCursor.length - checkLength,
    );

    // Find all matching triggers (prioritize longer matches)
    final matchingSuggestions = <SuggestionModel>[];
    final matchedTriggers = <String>{};

    // Sort triggers by length (longest first) to prioritize longer matches
    final sortedSuggestions = List<SuggestionModel>.from(registeredSuggestions)
      ..sort((a, b) => b.triggeredAt.length.compareTo(a.triggeredAt.length));

    for (final suggestion in sortedSuggestions) {
      final trigger = suggestion.triggeredAt;
      if (trigger.isEmpty) continue;

      // Check if trigger matches as prefix of text before cursor
      if (textToCheck.endsWith(trigger) || textToCheck == trigger) {
        // Only add if we haven't already matched this exact trigger
        if (!matchedTriggers.contains(trigger)) {
          matchedTriggers.add(trigger);
          // Add all suggestions with this trigger, validating context
          final suggestionsWithTrigger = registeredSuggestions
              .where((s) => s.triggeredAt == trigger)
              .where(
                (s) => validateSuggestionContext(
                  s,
                  textBeforeCursor,
                  textAfterCursor,
                  cursorPosition,
                ),
              )
              .toList();
          matchingSuggestions.addAll(suggestionsWithTrigger);
        }
      } else if (trigger.length <= textToCheck.length) {
        // Check if trigger is a prefix of what we're typing (for partial matches)
        // For example, if trigger is "{{}}" and user typed "{{", we should show suggestions
        final textEnd = textToCheck.substring(
          textToCheck.length - trigger.length,
        );
        if (trigger.startsWith(textEnd)) {
          // Partial match - user is typing the trigger
          if (!matchedTriggers.contains(trigger)) {
            matchedTriggers.add(trigger);
            final suggestionsWithTrigger = registeredSuggestions
                .where((s) => s.triggeredAt == trigger)
                .where(
                  (s) => validateSuggestionContext(
                    s,
                    textBeforeCursor,
                    textAfterCursor,
                    cursorPosition,
                  ),
                )
                .toList();
            matchingSuggestions.addAll(suggestionsWithTrigger);
          }
        }
      }

      // Check if cursor is in the middle of the trigger pattern
      // e.g., trigger is "{{}}" and we have "{{" before cursor and "}}" after cursor
      if (textAfterCursor != null && trigger.length > 2) {
        // Try to find if the trigger pattern spans across the cursor
        for (int i = 1; i < trigger.length; i++) {
          final triggerPrefix = trigger.substring(0, i);
          final triggerSuffix = trigger.substring(i);
          if (textBeforeCursor.endsWith(triggerPrefix) &&
              textAfterCursor.startsWith(triggerSuffix)) {
            // Cursor is in the middle of the trigger pattern
            if (!matchedTriggers.contains(trigger)) {
              matchedTriggers.add(trigger);
              final suggestionsWithTrigger = registeredSuggestions
                  .where((s) => s.triggeredAt == trigger)
                  .where(
                    (s) => validateSuggestionContext(
                      s,
                      textBeforeCursor,
                      textAfterCursor,
                      cursorPosition,
                    ),
                  )
                  .toList();
              matchingSuggestions.addAll(suggestionsWithTrigger);
            }
            break;
          }
        }
      }
    }

    return matchingSuggestions;
  }

  /// Validates if a suggestion's context requirement is satisfied.
  ///
  /// Returns true if the suggestion should be shown based on its context
  /// requirement, false otherwise.
  bool validateSuggestionContext(
    SuggestionModel suggestion,
    String textBeforeCursor,
    String? textAfterCursor,
    int cursorPosition,
  ) {
    final context = suggestion.context;
    if (context == null || context == SuggestionContext.none) {
      return true; // No context restriction
    }

    switch (context) {
      case SuggestionContext.jinjaBlock:
        return isCursorInJinjaBlock(
          textBeforeCursor,
          textAfterCursor,
          cursorPosition,
        );
      case SuggestionContext.none:
        return true;
    }
  }

  int _scoreMatch(String label, String prefix) {
    if (prefix.isEmpty) return 0;

    final lowerLabel = label.toLowerCase();
    final lowerPrefix = prefix.toLowerCase();

    if (!lowerLabel.contains(lowerPrefix)) return -1000000;

    int score = 0;

    if (label.startsWith(prefix)) {
      score += 100000;
    } else if (lowerLabel.startsWith(lowerPrefix)) {
      score += 50000;
    } else {
      score += 10000;
    }

    final matchIndex = lowerLabel.indexOf(lowerPrefix);
    score -= matchIndex * 100;

    if (matchIndex > 0) {
      final charBefore = label[matchIndex - 1];
      final matchChar = label[matchIndex];
      if (charBefore.toLowerCase() == charBefore &&
          matchChar.toUpperCase() == matchChar) {
        score += 5000;
      } else if (charBefore == '_' || charBefore == '-') {
        score += 5000;
      }
    }

    score -= label.length;

    return score;
  }

  void _sortSuggestions(String prefix) {
    _suggestions.sort((a, b) {
      final aLabel = a is LspCompletion
          ? a.label
          : (a is SuggestionModel ? a.label : a.toString());
      final bLabel = b is LspCompletion
          ? b.label
          : (b is SuggestionModel ? b.label : b.toString());
      final aScore = _scoreMatch(aLabel, prefix);
      final bScore = _scoreMatch(bLabel, prefix);

      if (aScore != bScore) {
        return bScore.compareTo(aScore);
      }

      return aLabel.compareTo(bLabel);
    });
  }

  Future<void> _fetchSemanticTokensFull() async {
    if (widget.lspConfig == null || !_lspReady) return;

    try {
      final tokens = await widget.lspConfig!.getSemanticTokensFull(_filePath!);
      if (mounted) {
        setState(() {
          _semanticTokens = tokens;
          _semanticTokensVersion++;
        });
      }
    } catch (e) {
      debugPrint('Error fetching semantic tokens: $e');
    }
  }

  void _scheduleSemantictokenRefresh() {
    _semanticTokenTimer?.cancel();
    _semanticTokenTimer = Timer(_semanticTokenDebounce, () async {
      if (!mounted || !_lspReady) return;

      await _fetchSemanticTokensFull();
    });
  }

  String _getSuggestionCacheKey(dynamic item) {
    if (item is LspCompletion) {
      final map = item.completionItem;
      final id = map['id']?.toString() ?? '';
      final sort = map['sortText']?.toString() ?? '';
      final source = map['source']?.toString() ?? '';
      final label = item.label;
      final importUri = (item.importUri != null && item.importUri!.isNotEmpty)
          ? item.importUri![0]
          : '';
      return 'lsp|$label|$id|$sort|$source|$importUri';
    }
    return 'str|${item.toString()}';
  }

  Future<void> _fetchCodeActionsForCurrentPosition() async {
    if (_controller.lspConfig == null) return;
    final sel = _controller.selection;
    final cursor = sel.extentOffset;
    final line = _controller.getLineAtOffset(cursor);
    final lineStart = _controller.getLineStartOffset(line);
    final character = cursor - lineStart;

    final actions = await _controller.lspConfig!.getCodeActions(
      filePath: _filePath!,
      startLine: line,
      startCharacter: character,
      endLine: line,
      endCharacter: character,
      diagnostics: _diagnosticsNotifier.value
          .map((item) => item.toJson())
          .toList(),
    );

    _suggestionNotifier.value = null;
    _lspActionNotifier.value = actions;
    _actionSelIndex = 0;
    _lspActionOffsetNotifier.value = _offsetNotifier.value;
  }

  void _resetCursorBlink() {
    if (!mounted) return;
    _caretBlinkController.value = 1.0;
    _caretBlinkController
      ..stop()
      ..repeat(reverse: true);
  }

  void _updateStyles() {
    _gutterStyle =
        widget.gutterStyle ??
        GutterStyle(
          lineNumberStyle: null,
          foldedIconColor: _editorTheme['root']?.color,
          unfoldedIconColor: _editorTheme['root']?.color,
          backgroundColor: _editorTheme['root']?.backgroundColor,
        );

    _suggestionStyle =
        widget.suggestionStyle ??
        SuggestionStyle(
          elevation: 6,
          highlightColor: Colors.blueAccent.withAlpha(50),
          textStyle: (() {
            TextStyle style = widget.textStyle ?? TextStyle();
            if (style.color == null) {
              style = style.copyWith(color: _editorTheme['root']!.color);
            }
            return style;
          })(),
          backgroundColor:
              _editorTheme['root']?.backgroundColor ?? Colors.white,
          focusColor: Colors.blueAccent.withAlpha(50),
          hoverColor: Colors.grey.withAlpha(15),
          splashColor: Colors.blueAccent.withAlpha(50),
          shape: BeveledRectangleBorder(
            side: BorderSide(
              color: _editorTheme['root']!.color ?? Colors.grey[400]!,
              width: 0.2,
            ),
          ),
        );

    _suggestionDescriptionStyle =
        widget.suggestionDescriptionStyle ??
        SuggestionStyle(
          elevation: 6,
          highlightColor: Colors.blueAccent.withAlpha(50),
          textStyle: (() {
            TextStyle style = widget.textStyle ?? TextStyle();
            if (style.color == null) {
              style = style.copyWith(color: _editorTheme['root']!.color);
            }
            return style;
          })(),
          backgroundColor:
              _editorTheme['root']?.backgroundColor ?? Colors.white,
          focusColor: Colors.blueAccent.withAlpha(50),
          hoverColor: Colors.grey.withAlpha(15),
          splashColor: Colors.blueAccent.withAlpha(50),
          shape: BeveledRectangleBorder(
            side: BorderSide(
              color: _editorTheme['root']!.color ?? Colors.grey[400]!,
              width: 0.2,
            ),
          ),
        );

    _hoverDetailsStyle =
        widget.hoverDetailsStyle ??
        HoverDetailsStyle(
          highlightColor: Colors.blueAccent.withAlpha(50),
          shape: BeveledRectangleBorder(
            side: BorderSide(
              color: _editorTheme['root']!.color ?? Colors.grey[400]!,
              width: 0.2,
            ),
          ),
          backgroundColor: (() {
            final lightnessDelta = -0.06;
            final base = _editorTheme['root']?.backgroundColor ?? Colors.black;
            final hsl = HSLColor.fromColor(base);
            final newLightness = (hsl.lightness + lightnessDelta).clamp(
              0.0,
              1.0,
            );
            return hsl.withLightness(newLightness).toColor();
          })(),
          focusColor: Colors.blueAccent.withAlpha(50),
          hoverColor: Colors.grey.withAlpha(15),
          splashColor: Colors.blueAccent.withAlpha(50),
          textStyle: (() {
            TextStyle style = widget.textStyle ?? _editorTheme['root']!;
            if (style.color == null) {
              style = style.copyWith(color: _editorTheme['root']?.color);
            }
            return style;
          })(),
        );
  }

  @override
  void dispose() {
    _controller.removeListener(_controllerListener);
    _controller.semanticTokens.removeListener(_semanticTokensListener);
    _connection?.close();
    _lspResponsesSubscription?.cancel();
    _caretBlinkController.dispose();
    _lineHighlightController.dispose();
    _hoverNotifier.dispose();
    _aiNotifier.dispose();
    _aiOffsetNotifier.dispose();
    _contextMenuOffsetNotifier.dispose();
    _selectionActiveNotifier.dispose();
    _isHoveringPopup.dispose();
    _offsetNotifier.dispose();
    _lspActionOffsetNotifier.dispose();
    _suggScrollController.dispose();
    _actionScrollController.dispose();
    _hoverTimer?.cancel();
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void handleArrowRight(bool withShift) {
    final ghost = _controller.ghostText;
    if (ghost != null && !ghost.shouldPersist && !withShift) {
      acceptControllerGhostText();
      return;
    }

    if (_aiNotifier.value != null) {
      acceptGhostText();
      return;
    }

    if (_suggestionNotifier.value != null) {
      _suggestionNotifier.value = null;
    }

    final sel = _controller.selection;
    final textLength = _controller.length;

    int newOffset;
    if (!withShift && sel.start != sel.end) {
      newOffset = sel.end;
    } else if (sel.extentOffset < textLength) {
      newOffset = sel.extentOffset + 1;
    } else {
      newOffset = textLength;
    }

    if (withShift) {
      _controller.setSelectionSilently(
        TextSelection(baseOffset: sel.baseOffset, extentOffset: newOffset),
      );
    } else {
      _controller.setSelectionSilently(
        TextSelection.collapsed(offset: newOffset),
      );
    }
  }

  Future<void> _callSignatureHelp() async {
    final lspConfig = _controller.lspConfig;
    if (lspConfig != null) {
      final cursorPosition = _controller.selection.extentOffset;
      final line = _controller.getLineAtOffset(cursorPosition);
      final lineStartOffset = _controller.getLineStartOffset(line);
      final character = cursorPosition - lineStartOffset;
      _lspSignatureNotifier.value = await lspConfig.getSignatureHelp(
        widget.filePath!,
        line,
        character,
        1,
      );
    }
  }

  Widget buildContextMenu() {
    return ValueListenableBuilder<Offset>(
      valueListenable: _contextMenuOffsetNotifier,
      builder: (context, offset, _) {
        if (offset.dx < 0 || offset.dy < 0) return const SizedBox.shrink();

        final hasSelection =
            _controller.selection.start != _controller.selection.end;

        if (_isMobile) {
          return TextSelectionToolbar(
            anchorAbove: offset,
            anchorBelow: Offset(offset.dx, offset.dy + 40),
            toolbarBuilder: (BuildContext context, Widget child) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: _hoverDetailsStyle.backgroundColor,
                ),
                child: child,
              );
            },
            children: [
              if (hasSelection) ...[
                if (!_controller.readOnly)
                  TextSelectionToolbarTextButton(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    onPressed: () {
                      _controller.cut();
                      _contextMenuOffsetNotifier.value = const Offset(-1, -1);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.cut,
                          size: 16,
                          color: _editorTheme['root']?.color,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Cut',
                          style: TextStyle(
                            color: _editorTheme['root']?.color,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                TextSelectionToolbarTextButton(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  onPressed: () {
                    _controller.copy();
                    _contextMenuOffsetNotifier.value = const Offset(-1, -1);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.copy,
                        size: 16,
                        color: _editorTheme['root']?.color,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Copy',
                        style: TextStyle(
                          color: _editorTheme['root']?.color,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              if (!_controller.readOnly)
                TextSelectionToolbarTextButton(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  onPressed: () async {
                    await _controller.paste();
                    _contextMenuOffsetNotifier.value = const Offset(-1, -1);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.paste,
                        size: 16,
                        color: _editorTheme['root']?.color,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Paste',
                        style: TextStyle(
                          color: _editorTheme['root']?.color,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              TextSelectionToolbarTextButton(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                onPressed: () {
                  _controller.selectAll();
                  _contextMenuOffsetNotifier.value = const Offset(-1, -1);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.select_all,
                      size: 16,
                      color: _editorTheme['root']?.color,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Select All',
                      style: TextStyle(
                        color: _editorTheme['root']?.color,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return Positioned(
            left: offset.dx,
            top: offset.dy,
            child: Card(
              elevation: 8,
              color: _editorTheme['root']?.backgroundColor ?? Colors.grey[900],
              shape: _suggestionStyle.shape,
              child: IntrinsicWidth(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (hasSelection) ...[
                      if (!_controller.readOnly)
                        buildDesktopContextMenuItem(
                          'Cut',
                          'Ctrl+X',
                          () => _controller.cut(),
                        ),
                      buildDesktopContextMenuItem(
                        'Copy',
                        'Ctrl+C',
                        () => _controller.copy(),
                      ),
                    ],
                    if (!_controller.readOnly)
                      buildDesktopContextMenuItem(
                        'Paste',
                        'Ctrl+V',
                        () => _controller.paste(),
                      ),
                    buildDesktopContextMenuItem(
                      'Select All',
                      'Ctrl+A',
                      () => _controller.selectAll(),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget buildDesktopContextMenuItem(
    String label,
    String shortcut,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: () {
        onTap();
        _contextMenuOffsetNotifier.value = const Offset(-1, -1);
      },
      hoverColor: _suggestionStyle.hoverColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: _suggestionStyle.textStyle),
            const SizedBox(width: 24),
            Text(
              shortcut,
              style: _suggestionStyle.textStyle.copyWith(
                color: _suggestionStyle.textStyle.color!.withAlpha(150),
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void commonKeyFunctions() {
    if (_aiNotifier.value != null) {
      _aiNotifier.value = null;
    }

    final ghost = _controller.ghostText;
    if (ghost != null && !ghost.shouldPersist) {
      _controller.clearGhostText();
    }

    _resetCursorBlink();
  }

  void deleteWordBackward() {
    if (widget.readOnly) return;
    final selection = _controller.selection;
    final text = _controller.text;

    if (!selection.isCollapsed) {
      _controller.replaceRange(selection.start, selection.end, '');
      return;
    }

    int caret = selection.extentOffset;
    if (caret <= 0) return;

    final prevChar = text[caret - 1];
    if (prevChar == '\n') {
      _controller.replaceRange(caret - 1, caret, '');
      return;
    }

    final before = text.substring(0, caret);
    final lineStart = text.lastIndexOf('\n', caret - 1) + 1;
    final lineText = before.substring(lineStart);

    final match = RegExp(r'(\w+|[^\w\s]+)\s*$').firstMatch(lineText);
    int deleteFrom = caret;
    if (match != null) {
      deleteFrom = lineStart + match.start;
    } else {
      deleteFrom = caret - 1;
    }

    _controller.replaceRange(deleteFrom, caret, '');
  }

  void deleteWordForward() {
    if (widget.readOnly) return;
    final selection = _controller.selection;
    final text = _controller.text;

    if (!selection.isCollapsed) {
      _controller.replaceRange(selection.start, selection.end, '');
      return;
    }

    int caret = selection.extentOffset;
    if (caret >= text.length) return;

    final after = text.substring(caret);
    final match = RegExp(r'^(\s*\w+|\s*[^\w\s]+)').firstMatch(after);
    int deleteTo = caret;
    if (match != null) {
      deleteTo = caret + match.end;
    } else {
      deleteTo = caret + 1;
    }

    _controller.replaceRange(caret, deleteTo, '');
  }

  void moveWordLeft(bool withShift) {
    final selection = _controller.selection;
    final text = _controller.text;
    int caret = selection.extentOffset;

    if (caret <= 0) return;

    final prevNewline = text.lastIndexOf('\n', caret - 1);
    final lineStart = prevNewline == -1 ? 0 : prevNewline + 1;
    if (caret == lineStart && lineStart > 0) {
      final newOffset = lineStart - 1;
      _controller.setSelectionSilently(
        withShift
            ? TextSelection(
                baseOffset: selection.baseOffset,
                extentOffset: newOffset,
              )
            : TextSelection.collapsed(offset: newOffset),
      );
      return;
    }

    final lineText = text.substring(lineStart, caret);
    final wordMatches = RegExp(r'\w+|[^\w\s]+').allMatches(lineText).toList();

    int newOffset = lineStart;
    for (final match in wordMatches) {
      if (match.end >= lineText.length) break;
      newOffset = lineStart + match.start;
    }

    _controller.setSelectionSilently(
      withShift
          ? TextSelection(
              baseOffset: selection.baseOffset,
              extentOffset: newOffset,
            )
          : TextSelection.collapsed(offset: newOffset),
    );
  }

  void moveWordRight(bool withShift) {
    final selection = _controller.selection;
    final text = _controller.text;
    int caret = selection.extentOffset;

    if (caret >= text.length) return;

    if (caret < text.length && text[caret] == '\n') {
      final newOffset = caret + 1;
      _controller.setSelectionSilently(
        withShift
            ? TextSelection(
                baseOffset: selection.baseOffset,
                extentOffset: newOffset,
              )
            : TextSelection.collapsed(offset: newOffset),
      );
      return;
    }

    final regex = RegExp(r'\w+|[^\w\s]+|\s+');
    final matches = regex.allMatches(text, caret);

    int newOffset = caret;
    for (final match in matches) {
      if (match.start > caret) {
        newOffset = match.start;
        break;
      }
    }
    if (newOffset == caret) newOffset = text.length;

    _controller.setSelectionSilently(
      withShift
          ? TextSelection(
              baseOffset: selection.baseOffset,
              extentOffset: newOffset,
            )
          : TextSelection.collapsed(offset: newOffset),
    );
  }

  void moveLineUp() {
    if (widget.readOnly) return;
    final selection = _controller.selection;
    final text = _controller.text;
    final selStart = selection.start;
    final selEnd = selection.end;
    final lineStart = selStart > 0
        ? text.lastIndexOf('\n', selStart - 1) + 1
        : 0;
    int lineEnd = text.indexOf('\n', selEnd);
    if (lineEnd == -1) lineEnd = text.length;
    if (lineStart == 0) return;

    final prevLineEnd = lineStart - 1;
    final prevLineStart = text.lastIndexOf('\n', prevLineEnd - 1) + 1;
    final prevLine = text.substring(prevLineStart, prevLineEnd);
    final currentLines = text.substring(lineStart, lineEnd);

    _controller.replaceRange(
      prevLineStart,
      lineEnd,
      '$currentLines\n$prevLine',
    );

    final prevLineLen = prevLineEnd - prevLineStart;
    final offsetDelta = prevLineLen + 1;
    final newSelection = TextSelection(
      baseOffset: selection.baseOffset - offsetDelta,
      extentOffset: selection.extentOffset - offsetDelta,
    );
    _controller.setSelectionSilently(newSelection);
  }

  void moveLineDown() {
    if (widget.readOnly) return;
    final selection = _controller.selection;
    final text = _controller.text;
    final selStart = selection.start;
    final selEnd = selection.end;
    final lineStart = text.lastIndexOf('\n', selStart - 1) + 1;
    int lineEnd = text.indexOf('\n', selEnd);
    if (lineEnd == -1) lineEnd = text.length;
    final nextLineStart = lineEnd + 1;
    if (nextLineStart >= text.length) return;
    int nextLineEnd = text.indexOf('\n', nextLineStart);
    if (nextLineEnd == -1) nextLineEnd = text.length;

    final currentLines = text.substring(lineStart, lineEnd);
    final nextLine = text.substring(nextLineStart, nextLineEnd);

    _controller.replaceRange(
      lineStart,
      nextLineEnd,
      '$nextLine\n$currentLines',
    );

    final offsetDelta = nextLine.length + 1;
    final newSelection = TextSelection(
      baseOffset: selection.baseOffset + offsetDelta,
      extentOffset: selection.extentOffset + offsetDelta,
    );
    _controller.setSelectionSilently(newSelection);
  }

  void duplicateLine() {
    if (widget.readOnly) return;
    final text = _controller.text;
    final selection = _controller.selection;
    final caret = selection.extentOffset;
    final prevNewline = (caret > 0) ? text.lastIndexOf('\n', caret - 1) : -1;
    final nextNewline = text.indexOf('\n', caret);
    final lineStart = prevNewline == -1 ? 0 : prevNewline + 1;
    final lineEnd = nextNewline == -1 ? text.length : nextNewline;
    final lineText = text.substring(lineStart, lineEnd);

    _controller.replaceRange(lineEnd, lineEnd, '\n$lineText');
    _controller.setSelectionSilently(
      TextSelection.collapsed(offset: lineEnd + 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return ColoredBox(
      color: _editorTheme['root']?.backgroundColor ?? Colors.grey[900]!,
      child: Column(
        children: [
          if (widget.finderBuilder != null)
            ListenableBuilder(
              listenable: _findController,
              builder: (context, _) {
                if (!_findController.isActive) {
                  return const SizedBox.shrink();
                }
                return widget.finderBuilder!(context, _findController);
              },
            ),
          Expanded(
            child: LayoutBuilder(
              builder: (_, constraints) {
                return Stack(
                  children: [
                    RawScrollbar(
                      controller: _vscrollController,
                      thumbVisibility: _isHovering,
                      child: RawScrollbar(
                        thumbVisibility: _isHovering,
                        controller: _hscrollController,
                        child: GestureDetector(
                          onTap: () {
                            _focusNode.requestFocus();
                            if (_contextMenuOffsetNotifier.value.dx >= 0) {
                              _contextMenuOffsetNotifier.value = const Offset(
                                -1,
                                -1,
                              );
                            }
                            _suggestionNotifier.value = null;
                            _lspSignatureNotifier.value = null;
                          },
                          onDoubleTapDown: (details) {
                            if (_controller.text.isNotEmpty) return;
                            _contextMenuOffsetNotifier.value =
                                details.localPosition;
                          },
                          child: MouseRegion(
                            onEnter: (event) {
                              if (mounted) setState(() => _isHovering = true);
                            },
                            onExit: (event) {
                              if (mounted) setState(() => _isHovering = false);
                            },
                            child: ValueListenableBuilder(
                              valueListenable: _selectionActiveNotifier,
                              builder: (context, selVal, child) {
                                return TwoDimensionalScrollable(
                                  horizontalDetails: ScrollableDetails.horizontal(
                                    controller: _hscrollController,
                                    physics: selVal
                                        ? const NeverScrollableScrollPhysics()
                                        : const ClampingScrollPhysics(),
                                  ),
                                  verticalDetails: ScrollableDetails.vertical(
                                    controller: _vscrollController,
                                    physics: selVal
                                        ? const NeverScrollableScrollPhysics()
                                        : const ClampingScrollPhysics(),
                                  ),
                                  viewportBuilder: (_, voffset, hoffset) => CustomViewport(
                                    verticalOffset: voffset,
                                    verticalAxisDirection: AxisDirection.down,
                                    horizontalOffset: hoffset,
                                    horizontalAxisDirection:
                                        AxisDirection.right,
                                    mainAxis: Axis.vertical,
                                    lineWrap: widget.lineWrap,
                                    delegate: TwoDimensionalChildBuilderDelegate(
                                      maxXIndex: 0,
                                      maxYIndex: 0,
                                      builder: (_, vic) {
                                        return Focus(
                                          focusNode: _focusNode,
                                          onKeyEvent: (node, event) {
                                            if (event is KeyDownEvent ||
                                                event is KeyRepeatEvent) {
                                              final isShiftPressed =
                                                  HardwareKeyboard
                                                      .instance
                                                      .isShiftPressed;
                                              final isCtrlPressed =
                                                  HardwareKeyboard
                                                      .instance
                                                      .isControlPressed ||
                                                  HardwareKeyboard
                                                      .instance
                                                      .isMetaPressed;
                                              if (_suggestionNotifier.value !=
                                                      null &&
                                                  _suggestionNotifier
                                                      .value!
                                                      .isNotEmpty) {
                                                final suggestions =
                                                    _suggestionNotifier.value!;
                                                switch (event.logicalKey) {
                                                  case LogicalKeyboardKey
                                                      .arrowDown:
                                                    if (mounted) {
                                                      setState(() {
                                                        _sugSelIndex =
                                                            (_sugSelIndex + 1) %
                                                            suggestions.length;
                                                        _scrollToSelectedSuggestion();
                                                      });
                                                    }
                                                    return KeyEventResult
                                                        .handled;
                                                  case LogicalKeyboardKey
                                                      .arrowUp:
                                                    if (mounted) {
                                                      setState(() {
                                                        _sugSelIndex =
                                                            (_sugSelIndex -
                                                                1 +
                                                                suggestions
                                                                    .length) %
                                                            suggestions.length;
                                                        _scrollToSelectedSuggestion();
                                                      });
                                                    }
                                                    return KeyEventResult
                                                        .handled;
                                                  case LogicalKeyboardKey.enter:
                                                  case LogicalKeyboardKey.tab:
                                                    acceptSuggestion();
                                                    if (_extraText.isNotEmpty) {
                                                      _controller
                                                          .applyWorkspaceEdit(
                                                            _extraText,
                                                          );
                                                    }
                                                    setState(() {
                                                      _isSignatureInvoked =
                                                          true;
                                                    });
                                                    return KeyEventResult
                                                        .handled;
                                                  case LogicalKeyboardKey
                                                      .escape:
                                                    _suggestionNotifier.value =
                                                        null;
                                                    return KeyEventResult
                                                        .handled;
                                                  default:
                                                    break;
                                                }
                                              }

                                              if (_lspActionNotifier.value !=
                                                      null &&
                                                  _lspActionOffsetNotifier
                                                          .value !=
                                                      null &&
                                                  _lspActionNotifier
                                                      .value!
                                                      .isNotEmpty) {
                                                final actions =
                                                    _lspActionNotifier.value!;
                                                switch (event.logicalKey) {
                                                  case LogicalKeyboardKey
                                                      .arrowDown:
                                                    if (mounted) {
                                                      setState(() {
                                                        _actionSelIndex =
                                                            (_actionSelIndex +
                                                                1) %
                                                            actions.length;
                                                        _scrollToSelectedAction();
                                                      });
                                                    }
                                                    return KeyEventResult
                                                        .handled;
                                                  case LogicalKeyboardKey
                                                      .arrowUp:
                                                    if (mounted) {
                                                      setState(() {
                                                        _actionSelIndex =
                                                            (_actionSelIndex -
                                                                1 +
                                                                actions
                                                                    .length) %
                                                            actions.length;
                                                        _scrollToSelectedAction();
                                                      });
                                                    }
                                                    return KeyEventResult
                                                        .handled;
                                                  case LogicalKeyboardKey.enter:
                                                  case LogicalKeyboardKey.tab:
                                                    (() async {
                                                      await _controller
                                                          .applyWorkspaceEdit(
                                                            _lspActionNotifier
                                                                .value![_actionSelIndex],
                                                          );
                                                    })();
                                                    _lspActionNotifier.value =
                                                        null;
                                                    _lspActionOffsetNotifier
                                                            .value =
                                                        null;
                                                    return KeyEventResult
                                                        .handled;
                                                  case LogicalKeyboardKey
                                                      .escape:
                                                    _lspActionNotifier.value =
                                                        null;
                                                    _lspActionOffsetNotifier
                                                            .value =
                                                        null;
                                                    return KeyEventResult
                                                        .handled;
                                                  default:
                                                    break;
                                                }
                                              }

                                              if (isCtrlPressed &&
                                                  isShiftPressed) {
                                                switch (event.logicalKey) {
                                                  case LogicalKeyboardKey.space:
                                                    setState(() {
                                                      _isSignatureInvoked =
                                                          true;
                                                    });
                                                    (() async =>
                                                        await _callSignatureHelp())();
                                                    return KeyEventResult
                                                        .handled;
                                                  case LogicalKeyboardKey
                                                      .arrowUp:
                                                    moveLineUp();
                                                    commonKeyFunctions();
                                                    return KeyEventResult
                                                        .handled;
                                                  case LogicalKeyboardKey
                                                      .arrowDown:
                                                    moveLineDown();
                                                    commonKeyFunctions();
                                                    return KeyEventResult
                                                        .handled;
                                                  case LogicalKeyboardKey
                                                      .arrowLeft:
                                                    moveWordLeft(true);
                                                    commonKeyFunctions();
                                                    return KeyEventResult
                                                        .handled;
                                                  case LogicalKeyboardKey
                                                      .arrowRight:
                                                    moveWordRight(true);
                                                    commonKeyFunctions();
                                                    return KeyEventResult
                                                        .handled;
                                                  default:
                                                    break;
                                                }
                                              }

                                              if (isCtrlPressed) {
                                                switch (event.logicalKey) {
                                                  case LogicalKeyboardKey.keyF:
                                                    final isAlt =
                                                        HardwareKeyboard
                                                            .instance
                                                            .isAltPressed;
                                                    _findController.isActive =
                                                        true;
                                                    _findController
                                                            .isReplaceMode =
                                                        isAlt;
                                                    return KeyEventResult
                                                        .handled;
                                                  case LogicalKeyboardKey.keyH:
                                                    if (!HardwareKeyboard
                                                        .instance
                                                        .isMetaPressed) {
                                                      _findController.isActive =
                                                          true;
                                                      _findController
                                                              .isReplaceMode =
                                                          true;

                                                      return KeyEventResult
                                                          .handled;
                                                    }
                                                    break;
                                                  case LogicalKeyboardKey.keyF:
                                                    // Search shortcut: Command+F (or Ctrl+F)
                                                    if (!_isSearchVisible) {
                                                      setState(() {
                                                        _isSearchVisible = true;
                                                      });
                                                      _searchFocusNode
                                                          .requestFocus();
                                                      _searchController
                                                              .selection =
                                                          TextSelection(
                                                            baseOffset: 0,
                                                            extentOffset:
                                                                _searchController
                                                                    .text
                                                                    .length,
                                                          );
                                                    } else {
                                                      _searchFocusNode
                                                          .requestFocus();
                                                    }
                                                    return KeyEventResult
                                                        .handled;
                                                  case LogicalKeyboardKey.keyS:
                                                    if (widget.saveFile !=
                                                        null) {
                                                      widget.saveFile!();
                                                      return KeyEventResult
                                                          .handled;
                                                    }
                                                    break;
                                                  case LogicalKeyboardKey.keyC:
                                                    _controller.copy();
                                                    return KeyEventResult
                                                        .handled;
                                                  case LogicalKeyboardKey.keyX:
                                                    if (widget.readOnly) {
                                                      return KeyEventResult
                                                          .handled;
                                                    }
                                                    _controller.cut();
                                                    return KeyEventResult
                                                        .handled;
                                                  case LogicalKeyboardKey.keyV:
                                                    if (widget.readOnly) {
                                                      return KeyEventResult
                                                          .handled;
                                                    }
                                                    _controller.paste();
                                                    return KeyEventResult
                                                        .handled;
                                                  case LogicalKeyboardKey.keyA:
                                                    _controller.selectAll();
                                                    return KeyEventResult
                                                        .handled;
                                                  case LogicalKeyboardKey.keyD:
                                                    if (widget.readOnly) {
                                                      return KeyEventResult
                                                          .handled;
                                                    }
                                                    duplicateLine();
                                                    commonKeyFunctions();
                                                    return KeyEventResult
                                                        .handled;
                                                  case LogicalKeyboardKey.keyZ:
                                                    if (widget.readOnly) {
                                                      return KeyEventResult
                                                          .handled;
                                                    }
                                                    if (_undoRedoController
                                                        .canUndo) {
                                                      _undoRedoController
                                                          .undo();
                                                      commonKeyFunctions();
                                                    }
                                                    return KeyEventResult
                                                        .handled;
                                                  case LogicalKeyboardKey.keyY:
                                                    if (widget.readOnly) {
                                                      return KeyEventResult
                                                          .handled;
                                                    }
                                                    if (_undoRedoController
                                                        .canRedo) {
                                                      _undoRedoController
                                                          .redo();
                                                      commonKeyFunctions();
                                                    }
                                                    return KeyEventResult
                                                        .handled;
                                                  case LogicalKeyboardKey
                                                      .backspace:
                                                    if (widget.readOnly) {
                                                      return KeyEventResult
                                                          .handled;
                                                    }
                                                    deleteWordBackward();
                                                    commonKeyFunctions();
                                                    return KeyEventResult
                                                        .handled;
                                                  case LogicalKeyboardKey
                                                      .delete:
                                                    if (widget.readOnly) {
                                                      return KeyEventResult
                                                          .handled;
                                                    }
                                                    deleteWordForward();
                                                    commonKeyFunctions();
                                                    return KeyEventResult
                                                        .handled;
                                                  case LogicalKeyboardKey
                                                      .arrowLeft:
                                                    moveWordLeft(false);
                                                    commonKeyFunctions();
                                                    return KeyEventResult
                                                        .handled;
                                                  case LogicalKeyboardKey
                                                      .arrowRight:
                                                    moveWordRight(false);
                                                    commonKeyFunctions();
                                                    return KeyEventResult
                                                        .handled;
                                                  case LogicalKeyboardKey
                                                      .period:
                                                    (() async {
                                                      _suggestionNotifier
                                                              .value =
                                                          null;
                                                      await _fetchCodeActionsForCurrentPosition();
                                                    })();
                                                    return KeyEventResult
                                                        .handled;
                                                  default:
                                                    break;
                                                }
                                              }

                                              if (isShiftPressed &&
                                                  !isCtrlPressed) {
                                                switch (event.logicalKey) {
                                                  case LogicalKeyboardKey.tab:
                                                    if (widget.readOnly) {
                                                      return KeyEventResult
                                                          .handled;
                                                    }
                                                    _controller.unindent();
                                                    commonKeyFunctions();
                                                    return KeyEventResult
                                                        .handled;
                                                  case LogicalKeyboardKey
                                                      .arrowLeft:
                                                    _controller
                                                        .pressLetfArrowKey(
                                                          isShiftPressed:
                                                              isShiftPressed,
                                                        );
                                                    commonKeyFunctions();
                                                    return KeyEventResult
                                                        .handled;
                                                  case LogicalKeyboardKey
                                                      .arrowRight:
                                                    handleArrowRight(true);
                                                    commonKeyFunctions();
                                                    return KeyEventResult
                                                        .handled;
                                                  case LogicalKeyboardKey
                                                      .arrowUp:
                                                    _controller.pressUpArrowKey(
                                                      isShiftPressed:
                                                          isShiftPressed,
                                                    );
                                                    commonKeyFunctions();
                                                    return KeyEventResult
                                                        .handled;
                                                  case LogicalKeyboardKey
                                                      .arrowDown:
                                                    _controller
                                                        .pressDownArrowKey(
                                                          isShiftPressed:
                                                              isShiftPressed,
                                                        );
                                                    commonKeyFunctions();
                                                    return KeyEventResult
                                                        .handled;
                                                  case LogicalKeyboardKey.home:
                                                    _controller.pressHomeKey(
                                                      isShiftPressed:
                                                          isShiftPressed,
                                                    );
                                                    commonKeyFunctions();
                                                    return KeyEventResult
                                                        .handled;
                                                  case LogicalKeyboardKey.end:
                                                    _controller.pressEndKey(
                                                      isShiftPressed:
                                                          isShiftPressed,
                                                    );
                                                    commonKeyFunctions();
                                                    return KeyEventResult
                                                        .handled;
                                                  default:
                                                    break;
                                                }
                                              }

                                              switch (event.logicalKey) {
                                                case LogicalKeyboardKey
                                                    .backspace:
                                                  if (widget.readOnly) {
                                                    return KeyEventResult
                                                        .handled;
                                                  }
                                                  _controller.backspace();
                                                  if (_suggestionNotifier
                                                          .value !=
                                                      null) {
                                                    _suggestionNotifier.value =
                                                        null;
                                                  }
                                                  commonKeyFunctions();
                                                  return KeyEventResult.handled;

                                                case LogicalKeyboardKey.delete:
                                                  if (widget.readOnly) {
                                                    return KeyEventResult
                                                        .handled;
                                                  }
                                                  _controller.delete();
                                                  if (_suggestionNotifier
                                                          .value !=
                                                      null) {
                                                    _suggestionNotifier.value =
                                                        null;
                                                  }
                                                  commonKeyFunctions();
                                                  return KeyEventResult.handled;

                                                case LogicalKeyboardKey
                                                    .arrowDown:
                                                  _controller.pressDownArrowKey(
                                                    isShiftPressed:
                                                        isShiftPressed,
                                                  );
                                                  commonKeyFunctions();
                                                  return KeyEventResult.handled;

                                                case LogicalKeyboardKey.arrowUp:
                                                  _controller.pressUpArrowKey(
                                                    isShiftPressed:
                                                        isShiftPressed,
                                                  );
                                                  commonKeyFunctions();
                                                  return KeyEventResult.handled;

                                                case LogicalKeyboardKey
                                                    .arrowRight:
                                                  handleArrowRight(
                                                    isShiftPressed,
                                                  );
                                                  commonKeyFunctions();
                                                  return KeyEventResult.handled;

                                                case LogicalKeyboardKey
                                                    .arrowLeft:
                                                  _controller.pressLetfArrowKey(
                                                    isShiftPressed:
                                                        isShiftPressed,
                                                  );
                                                  if (_suggestionNotifier
                                                          .value !=
                                                      null) {
                                                    _suggestionNotifier.value =
                                                        null;
                                                  }
                                                  commonKeyFunctions();
                                                  return KeyEventResult.handled;

                                                case LogicalKeyboardKey.home:
                                                  if (_suggestionNotifier
                                                          .value !=
                                                      null) {
                                                    _suggestionNotifier.value =
                                                        null;
                                                  }
                                                  _controller.pressHomeKey(
                                                    isShiftPressed:
                                                        isShiftPressed,
                                                  );
                                                  commonKeyFunctions();
                                                  return KeyEventResult.handled;

                                                case LogicalKeyboardKey.end:
                                                  if (_suggestionNotifier
                                                          .value !=
                                                      null) {
                                                    _suggestionNotifier.value =
                                                        null;
                                                  }
                                                  _controller.pressEndKey(
                                                    isShiftPressed:
                                                        isShiftPressed,
                                                  );
                                                  commonKeyFunctions();
                                                  return KeyEventResult.handled;

                                                case LogicalKeyboardKey.escape:
                                                  _hoverTimer?.cancel();
                                                  _lspSignatureNotifier.value =
                                                      null;
                                                  _contextMenuOffsetNotifier
                                                      .value = const Offset(
                                                    -1,
                                                    -1,
                                                  );
                                                  _findController.isActive =
                                                      false;
                                                  _findController
                                                          .isReplaceMode =
                                                      false;
                                                  _aiNotifier.value = null;
                                                  _suggestionNotifier.value =
                                                      null;
                                                  _hoverNotifier.value = null;
                                                  setState(() {
                                                    _isSignatureInvoked = false;
                                                  });
                                                  return KeyEventResult.handled;

                                                case LogicalKeyboardKey.tab:
                                                  if (widget.readOnly) {
                                                    return KeyEventResult
                                                        .handled;
                                                  }
                                                  // Check for ghost text from controller (non-persistent)
                                                  final ghost =
                                                      _controller.ghostText;
                                                  if (ghost != null &&
                                                      !ghost.shouldPersist) {
                                                    acceptControllerGhostText();
                                                    return KeyEventResult
                                                        .handled;
                                                  }
                                                  if (_aiNotifier.value !=
                                                      null) {
                                                    acceptGhostText();
                                                  } else if (_suggestionNotifier
                                                          .value ==
                                                      null) {
                                                    _controller.indent();
                                                    commonKeyFunctions();
                                                  }
                                                  return KeyEventResult.handled;

                                                case LogicalKeyboardKey.enter:
                                                  if (_aiNotifier.value !=
                                                      null) {
                                                    _aiNotifier.value = null;
                                                  }
                                                  break;
                                                default:
                                              }
                                            }
                                            return KeyEventResult.ignored;
                                          },
                                          child: _CodeField(
                                            context: context,
                                            controller: _controller,
                                            editorTheme: _editorTheme,
                                            language: _language,
                                            languageId: _controller
                                                .lspConfig
                                                ?.languageId,
                                            lspConfig: _controller.lspConfig,
                                            semanticTokens: _semanticTokens,
                                            semanticTokensVersion:
                                                _semanticTokensVersion,
                                            innerPadding: widget.innerPadding,
                                            vscrollController:
                                                _vscrollController,
                                            hscrollController:
                                                _hscrollController,
                                            focusNode: _focusNode,
                                            readOnly: widget.readOnly,
                                            caretBlinkController:
                                                _caretBlinkController,
                                            lineHighlightController:
                                                _lineHighlightController,
                                            textStyle: widget.textStyle,
                                            enableFolding: widget.enableFolding,
                                            enableGuideLines:
                                                widget.enableGuideLines,
                                            enableGutter: widget.enableGutter,
                                            enableGutterDivider:
                                                widget.enableGutterDivider,
                                            gutterStyle: _gutterStyle,
                                            selectionStyle: _selectionStyle,
                                            diagnostics:
                                                _diagnosticsNotifier.value,
                                            isMobile: _isMobile,
                                            selectionActiveNotifier:
                                                _selectionActiveNotifier,
                                            contextMenuOffsetNotifier:
                                                _contextMenuOffsetNotifier,
                                            hoverNotifier: _hoverNotifier,
                                            lineWrap: widget.lineWrap,
                                            offsetNotifier: _offsetNotifier,
                                            aiNotifier: _aiNotifier,
                                            aiOffsetNotifier: _aiOffsetNotifier,
                                            isHoveringPopup: _isHoveringPopup,
                                            suggestionNotifier:
                                                _suggestionNotifier,
                                            ghostTextStyle:
                                                widget.ghostTextStyle,
                                            matchHighlightStyle:
                                                widget.matchHighlightStyle,
                                            lspActionNotifier:
                                                _lspActionNotifier,
                                            lspActionOffsetNotifier:
                                                _lspActionOffsetNotifier,
                                            signatureNotifier:
                                                _lspSignatureNotifier,
                                            filePath: _filePath,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    buildContextMenu(),
                    ValueListenableBuilder(
                      valueListenable: _offsetNotifier,
                      builder: (_, offset, __) {
                        return ValueListenableBuilder(
                          valueListenable: _lspSignatureNotifier,
                          builder: (_, signature, __) {
                            if (signature == null ||
                                signature.activeParameter < 0 ||
                                signature.parameters.isEmpty) {
                              return SizedBox.shrink();
                            }
                            final sigScrollCtrl = ScrollController();
                            return Positioned(
                              width: screenWidth < 700
                                  ? screenWidth * 0.63
                                  : null,
                              top:
                                  offset.dy +
                                  (widget.textStyle?.fontSize ?? 14) +
                                  10 +
                                  (screenWidth < 700
                                      ? (offset.dy < screenHeight / 2)
                                            ? 0
                                            : -150
                                      : 0),
                              left: offset.dx,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: 420,
                                  maxHeight: 400,
                                  minWidth: 70,
                                ),
                                child: Card(
                                  color: _hoverDetailsStyle.backgroundColor,
                                  shape: _hoverDetailsStyle.shape,
                                  child: RawScrollbar(
                                    interactive: true,
                                    controller: sigScrollCtrl,
                                    thumbVisibility: true,
                                    thumbColor: _editorTheme['root']!.color!
                                        .withAlpha(100),
                                    child: SingleChildScrollView(
                                      controller: sigScrollCtrl,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 7,
                                              left: 6.5,
                                            ),
                                            child: RichText(
                                              text: (() {
                                                final label = signature.label;
                                                final activeParamIndex =
                                                    signature.activeParameter;

                                                if (activeParamIndex < 0 ||
                                                    activeParamIndex >=
                                                        signature
                                                            .parameters
                                                            .length) {
                                                  return TextSpan(text: label);
                                                }

                                                final paramLabel = signature
                                                    .parameters[activeParamIndex]['label'];

                                                if (paramLabel is List &&
                                                    paramLabel.length >= 2) {
                                                  final range = paramLabel
                                                      .cast<int>();
                                                  final firstPart = label
                                                      .substring(0, range[0]);
                                                  final highlightPart = label
                                                      .substring(
                                                        range[0],
                                                        range[1],
                                                      );
                                                  final finalPart = label
                                                      .substring(range[1]);

                                                  return TextSpan(
                                                    style: TextStyle(
                                                      fontSize:
                                                          (widget
                                                                  .textStyle
                                                                  ?.fontSize ??
                                                              15) +
                                                          1.75,
                                                      color:
                                                          _editorTheme['root']
                                                              ?.color,
                                                    ),
                                                    children: [
                                                      TextSpan(text: firstPart),
                                                      TextSpan(
                                                        text: highlightPart,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.blue,
                                                        ),
                                                      ),
                                                      TextSpan(text: finalPart),
                                                    ],
                                                  );
                                                } else if (paramLabel
                                                    is String) {
                                                  final paramText = paramLabel;
                                                  final paramIndex = label
                                                      .indexOf(paramText);

                                                  if (paramIndex >= 0) {
                                                    final firstPart = label
                                                        .substring(
                                                          0,
                                                          paramIndex,
                                                        );
                                                    final highlightPart =
                                                        paramText;
                                                    final finalPart = label
                                                        .substring(
                                                          paramIndex +
                                                              paramText.length,
                                                        );

                                                    return TextSpan(
                                                      style: TextStyle(
                                                        fontSize:
                                                            (widget
                                                                    .textStyle
                                                                    ?.fontSize ??
                                                                15) +
                                                            1.75,
                                                        color:
                                                            _editorTheme['root']
                                                                ?.color,
                                                      ),
                                                      children: [
                                                        TextSpan(
                                                          text: firstPart,
                                                        ),
                                                        TextSpan(
                                                          text: highlightPart,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.blue,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: finalPart,
                                                        ),
                                                      ],
                                                    );
                                                  }
                                                }

                                                return TextSpan(
                                                  text: label,
                                                  style: TextStyle(
                                                    fontSize:
                                                        (widget
                                                                .textStyle
                                                                ?.fontSize ??
                                                            15) +
                                                        1.75,
                                                    color: _editorTheme['root']
                                                        ?.color,
                                                  ),
                                                );
                                              })(),
                                            ),
                                          ),
                                          Divider(
                                            color:
                                                signature
                                                    .documentation
                                                    .isNotEmpty
                                                ? _editorTheme['root']?.color
                                                : Colors.transparent,
                                            thickness: 0.5,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 6.5,
                                            ),
                                            child: MarkdownBlock(
                                              data: signature.documentation,
                                              config: MarkdownConfig.darkConfig.copy(
                                                configs: [
                                                  PConfig(
                                                    textStyle:
                                                        _hoverDetailsStyle
                                                            .textStyle,
                                                  ),
                                                  PreConfig(
                                                    language:
                                                        _controller
                                                            .lspConfig
                                                            ?.languageId
                                                            .toLowerCase() ??
                                                        'dart',
                                                    theme: _editorTheme,
                                                    textStyle: TextStyle(
                                                      fontSize:
                                                          _hoverDetailsStyle
                                                              .textStyle
                                                              .fontSize,
                                                    ),
                                                    styleNotMatched: TextStyle(
                                                      color:
                                                          _editorTheme['root']!
                                                              .color,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color:
                                                          _editorTheme['root']!
                                                              .backgroundColor!,
                                                      borderRadius:
                                                          BorderRadius.zero,
                                                      border: Border.all(
                                                        width: 0.2,
                                                        color:
                                                            _editorTheme['root']!
                                                                .color ??
                                                            Colors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: _offsetNotifier,
                      builder: (context, offset, child) {
                        if (offset.dy < 0 ||
                            offset.dx < 0 ||
                            !widget.enableSuggestions) {
                          return SizedBox.shrink();
                        }
                        return ValueListenableBuilder(
                          valueListenable: _suggestionNotifier,
                          builder: (_, sugg, child) {
                            if (_aiNotifier.value != null) {
                              return SizedBox.shrink();
                            }
                            if (sugg == null || sugg.isEmpty) {
                              _sugSelIndex = 0;
                              return SizedBox.shrink();
                            }
                            final completionScrlCtrl = ScrollController();
                            return Stack(
                              children: [
                                Positioned(
                                  width: screenWidth < 700
                                      ? screenWidth * 0.63
                                      : screenWidth * 0.3,
                                  top:
                                      offset.dy +
                                      (widget.textStyle?.fontSize ?? 14) +
                                      10,
                                  left: offset.dx,
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxHeight: 400,
                                      maxWidth: 400,
                                      minWidth: 70,
                                    ),
                                    child: Card(
                                      shape: _suggestionStyle.shape,
                                      elevation: _suggestionStyle.elevation,
                                      color: _suggestionStyle.backgroundColor,
                                      margin: EdgeInsets.zero,
                                      child: RawScrollbar(
                                        thumbVisibility: true,
                                        thumbColor: _editorTheme['root']!.color!
                                            .withAlpha(80),
                                        interactive: true,
                                        controller: _suggScrollController,
                                        child: ListView.builder(
                                          itemExtent:
                                              (widget.textStyle?.fontSize ??
                                                  14) +
                                              6.5,
                                          controller: _suggScrollController,
                                          padding: EdgeInsets.only(right: 5),
                                          shrinkWrap: true,
                                          itemCount: sugg.length,
                                          itemBuilder: (_, indx) {
                                            final item = sugg[indx];
                                            if (item is LspCompletion &&
                                                indx == _sugSelIndex) {
                                              final key =
                                                  _getSuggestionCacheKey(item);
                                              if (!_suggestionDetailsCache
                                                      .containsKey(key) &&
                                                  _controller.lspConfig !=
                                                      null) {
                                                (() async {
                                                  try {
                                                    final data = await _controller
                                                        .lspConfig!
                                                        .resolveCompletionItem(
                                                          item.completionItem,
                                                        );
                                                    final mdText =
                                                        "${data['detail'] ?? ''}\n${(() {
                                                          final doc = data['documentation'];
                                                          if (doc == null) {
                                                            return '';
                                                          }

                                                          if (doc is Map<String, dynamic> && doc.containsKey('value')) {
                                                            return doc['value'];
                                                          }

                                                          return doc;
                                                        })()}";
                                                    if (!mounted) return;
                                                    setState(() {
                                                      final edits =
                                                          data['additionalTextEdits'];
                                                      if (edits is List) {
                                                        try {
                                                          _extraText = edits
                                                              .map(
                                                                (e) =>
                                                                    Map<
                                                                      String,
                                                                      dynamic
                                                                    >.from(
                                                                      e as Map,
                                                                    ),
                                                              )
                                                              .toList();
                                                        } catch (_) {
                                                          _extraText = edits
                                                              .cast<
                                                                Map<
                                                                  String,
                                                                  dynamic
                                                                >
                                                              >();
                                                        }
                                                      } else {
                                                        _extraText = [];
                                                      }
                                                      _suggestionDetailsCache[key] =
                                                          mdText;
                                                      _selectedSuggestionMd =
                                                          mdText;
                                                    });
                                                  } catch (e) {
                                                    debugPrint(
                                                      "Completion Resolve failed: ${e.toString()}",
                                                    );
                                                  }
                                                })();
                                              } else if (_suggestionDetailsCache
                                                  .containsKey(key)) {
                                                final cached =
                                                    _suggestionDetailsCache[key];
                                                if (_selectedSuggestionMd !=
                                                    cached) {
                                                  WidgetsBinding.instance
                                                      .addPostFrameCallback((
                                                        _,
                                                      ) {
                                                        if (!mounted) return;
                                                        setState(() {
                                                          _selectedSuggestionMd =
                                                              cached;
                                                        });
                                                      });
                                                }
                                              }
                                            } else if (indx == _sugSelIndex &&
                                                item is! LspCompletion) {
                                              if (_selectedSuggestionMd !=
                                                  null) {
                                                WidgetsBinding.instance
                                                    .addPostFrameCallback((_) {
                                                      if (!mounted) return;
                                                      setState(() {
                                                        _selectedSuggestionMd =
                                                            null;
                                                      });
                                                    });
                                              }
                                            }

                                            return Container(
                                              color: _sugSelIndex == indx
                                                  ? _suggestionStyle.focusColor
                                                  : Colors.transparent,
                                              child: InkWell(
                                                canRequestFocus: false,
                                                hoverColor:
                                                    _suggestionStyle.hoverColor,
                                                focusColor:
                                                    _suggestionStyle.focusColor,
                                                splashColor: _suggestionStyle
                                                    .splashColor,
                                                onTap: () {
                                                  if (mounted) {
                                                    setState(() {
                                                      _sugSelIndex = indx;
                                                      final text =
                                                          item is LspCompletion
                                                          ? item.label
                                                          : item as String;
                                                      _controller
                                                          .insertAtCurrentCursor(
                                                            text,
                                                            replaceTypedChar:
                                                                true,
                                                          );
                                                      if (_extraText
                                                          .isNotEmpty) {
                                                        _controller
                                                            .applyWorkspaceEdit(
                                                              _extraText,
                                                            );
                                                      }
                                                      _suggestionNotifier
                                                              .value =
                                                          null;
                                                      _isSignatureInvoked =
                                                          true;
                                                      _callSignatureHelp();
                                                    });
                                                  }
                                                },
                                                child: Row(
                                                  children: [
                                                    if (item
                                                        is LspCompletion) ...[
                                                      item.icon,
                                                      const SizedBox(width: 10),
                                                      Expanded(
                                                        child: Text(
                                                          item.label,
                                                          style:
                                                              _suggestionStyle
                                                                  .textStyle,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      const Expanded(
                                                        child: SizedBox(),
                                                      ),
                                                      if (item.importUri?[0] !=
                                                          null)
                                                        Expanded(
                                                          child: Text(
                                                            item.importUri![0],
                                                            style: _suggestionStyle
                                                                .textStyle
                                                                .copyWith(
                                                                  color: _suggestionStyle
                                                                      .textStyle
                                                                      .color
                                                                      ?.withAlpha(
                                                                        150,
                                                                      ),
                                                                ),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                    ],
                                                    if (item is String)
                                                      Expanded(
                                                        child: Text(
                                                          item,
                                                          style:
                                                              _suggestionStyle
                                                                  .textStyle,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                if (_selectedSuggestionMd != null &&
                                    _lspSignatureNotifier.value == null)
                                  Positioned(
                                    width: screenWidth < 700
                                        ? screenWidth * 0.63
                                        : null,
                                    top:
                                        offset.dy +
                                        (widget.textStyle?.fontSize ?? 14) +
                                        10 +
                                        (screenWidth < 700
                                            ? (offset.dy < (screenWidth / 2) &&
                                                      400 < screenHeight)
                                                  ? (((widget.textStyle?.fontSize ??
                                                                    14) +
                                                                6.5) *
                                                            (_suggestionNotifier
                                                                    .value
                                                                    ?.length ??
                                                                0))
                                                        .clamp(0, 400)
                                                  : -100
                                            : 0),
                                    left: screenWidth < 700
                                        ? offset.dx
                                        : offset.dx + screenWidth * 0.3 + 8,
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxWidth: 420,
                                        maxHeight: 400,
                                        minWidth: 70,
                                      ),
                                      child: Card(
                                        color:
                                            _hoverDetailsStyle.backgroundColor,
                                        shape: _hoverDetailsStyle.shape,
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                            _selectedSuggestionMd!
                                                    .trim()
                                                    .isEmpty
                                                ? 0
                                                : 8.0,
                                          ),
                                          child: RawScrollbar(
                                            interactive: true,
                                            controller: completionScrlCtrl,
                                            thumbVisibility: true,
                                            thumbColor: _editorTheme['root']!
                                                .color!
                                                .withAlpha(100),
                                            child: SingleChildScrollView(
                                              controller: completionScrlCtrl,
                                              child: MarkdownBlock(
                                                data: _selectedSuggestionMd!,
                                                config: MarkdownConfig.darkConfig.copy(
                                                  configs: [
                                                    PConfig(
                                                      textStyle:
                                                          _hoverDetailsStyle
                                                              .textStyle,
                                                    ),
                                                    PreConfig(
                                                      language:
                                                          _controller
                                                              .lspConfig
                                                              ?.languageId
                                                              .toLowerCase() ??
                                                          'dart',
                                                      theme: _editorTheme,
                                                      textStyle: TextStyle(
                                                        fontSize:
                                                            _hoverDetailsStyle
                                                                .textStyle
                                                                .fontSize,
                                                      ),
                                                      styleNotMatched: TextStyle(
                                                        color:
                                                            _editorTheme['root']!
                                                                .color,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            _editorTheme['root']!
                                                                .backgroundColor!,
                                                        borderRadius:
                                                            BorderRadius.zero,
                                                        border: Border.all(
                                                          width: 0.2,
                                                          color:
                                                              _editorTheme['root']!
                                                                  .color ??
                                                              Colors.grey,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: _hoverNotifier,
                      builder: (_, hov, c) {
                        if (hov == null ||
                            _controller.lspConfig == null ||
                            !widget.enableSuggestions) {
                          return SizedBox.shrink();
                        }
                        final Offset position = hov[0];
                        final Map<String, int> lineChar = hov[1];
                        final width = _isMobile
                            ? screenWidth * 0.63
                            : screenWidth * 0.3;
                        final maxHeight = _isMobile
                            ? screenHeight * 0.4
                            : 550.0;

                        return Positioned(
                          top: position.dy,
                          left: position.dx,
                          child: MouseRegion(
                            onEnter: (_) => _isHoveringPopup.value = true,
                            onExit: (_) => _isHoveringPopup.value = false,
                            child: FutureBuilder<Map<String, dynamic>>(
                              future: (() async {
                                final lspConfig = _controller.lspConfig;
                                final line = lineChar['line']!;
                                final character = lineChar['character']!;

                                String diagnosticMessage = '';
                                int severity = 0;
                                String hoverMessage = '';

                                final diagnostic = _diagnosticsNotifier.value
                                    .firstWhere(
                                      (diag) {
                                        final diagStartLine =
                                            diag.range['start']['line'] as int;
                                        final diagEndLine =
                                            diag.range['end']['line'] as int;
                                        final diagStartChar =
                                            diag.range['start']['character']
                                                as int;
                                        final diagEndChar =
                                            diag.range['end']['character']
                                                as int;

                                        if (line < diagStartLine ||
                                            line > diagEndLine) {
                                          return false;
                                        }

                                        if (line == diagStartLine &&
                                            line == diagEndLine) {
                                          return character >= diagStartChar &&
                                              character < diagEndChar;
                                        } else if (line == diagStartLine) {
                                          return character >= diagStartChar;
                                        } else if (line == diagEndLine) {
                                          return character < diagEndChar;
                                        } else {
                                          return true;
                                        }
                                      },
                                      orElse: () => LspErrors(
                                        severity: 0,
                                        range: {},
                                        message: '',
                                      ),
                                    );

                                if (diagnostic.message.isNotEmpty) {
                                  diagnosticMessage = diagnostic.message;
                                  severity = diagnostic.severity;
                                }

                                if (lspConfig != null) {
                                  hoverMessage = await lspConfig.getHover(
                                    _filePath!,
                                    line,
                                    character,
                                  );
                                }

                                return {
                                  'diagnostic': diagnosticMessage,
                                  'severity': severity,
                                  'hover': hoverMessage,
                                };
                              })(),
                              builder: (_, snapShot) {
                                if (snapShot.hasError) {
                                  return SizedBox.shrink();
                                }

                                if (snapShot.connectionState ==
                                    ConnectionState.waiting) {
                                  return ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxWidth: width,
                                      maxHeight: maxHeight,
                                    ),
                                    child: Card(
                                      color: _hoverDetailsStyle.backgroundColor,
                                      shape: _hoverDetailsStyle.shape,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Loading...",
                                          style: _hoverDetailsStyle.textStyle,
                                        ),
                                      ),
                                    ),
                                  );
                                }

                                final data = snapShot.data;
                                if (data == null) {
                                  return SizedBox.shrink();
                                }

                                final diagnosticMessage =
                                    data['diagnostic'] ?? '';
                                final severity = data['severity'] ?? 0;
                                final hoverMessage = data['hover'] ?? '';

                                if (diagnosticMessage.isEmpty &&
                                    hoverMessage.isEmpty) {
                                  return SizedBox.shrink();
                                }

                                IconData diagnosticIcon;
                                Color diagnosticColor;

                                switch (severity) {
                                  case 1:
                                    diagnosticIcon = Icons.error_outline;
                                    diagnosticColor = Colors.red;
                                    break;
                                  case 2:
                                    diagnosticIcon =
                                        Icons.warning_amber_outlined;
                                    diagnosticColor = Colors.orange;
                                    break;
                                  case 3:
                                    diagnosticIcon = Icons.info_outline;
                                    diagnosticColor = Colors.blue;
                                    break;
                                  case 4:
                                    diagnosticIcon = Icons.lightbulb_outline;
                                    diagnosticColor = Colors.grey;
                                    break;
                                  default:
                                    diagnosticIcon = Icons.info_outline;
                                    diagnosticColor = Colors.grey;
                                }

                                final hoverScrollController =
                                    ScrollController();
                                final errorSCrollController =
                                    ScrollController();

                                return ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: width,
                                    maxHeight: maxHeight,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (diagnosticMessage.isNotEmpty)
                                        Card(
                                          surfaceTintColor: diagnosticColor,
                                          color: _hoverDetailsStyle
                                              .backgroundColor,
                                          shape: BeveledRectangleBorder(
                                            side: BorderSide(
                                              color: diagnosticColor,
                                              width: 0.2,
                                            ),
                                          ),
                                          margin: EdgeInsets.only(
                                            bottom: hoverMessage.isNotEmpty
                                                ? 4
                                                : 0,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: RawScrollbar(
                                              controller: errorSCrollController,
                                              thumbVisibility: true,
                                              thumbColor: _editorTheme['root']!
                                                  .color!
                                                  .withAlpha(100),
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                controller:
                                                    errorSCrollController,
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      diagnosticIcon,
                                                      color: diagnosticColor,
                                                      size: 16,
                                                    ),
                                                    SizedBox(width: 8),
                                                    Text(
                                                      diagnosticMessage,
                                                      style: _hoverDetailsStyle
                                                          .textStyle,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                      if (hoverMessage.isNotEmpty)
                                        Flexible(
                                          child: Card(
                                            color: _hoverDetailsStyle
                                                .backgroundColor,
                                            shape: _hoverDetailsStyle.shape,
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                8.0,
                                              ),
                                              child: RawScrollbar(
                                                controller:
                                                    hoverScrollController,
                                                thumbVisibility: true,
                                                thumbColor:
                                                    _editorTheme['root']!.color!
                                                        .withAlpha(100),
                                                child: SingleChildScrollView(
                                                  controller:
                                                      hoverScrollController,
                                                  child: MarkdownBlock(
                                                    data: hoverMessage,
                                                    config: MarkdownConfig.darkConfig.copy(
                                                      configs: [
                                                        PConfig(
                                                          textStyle:
                                                              _hoverDetailsStyle
                                                                  .textStyle,
                                                        ),
                                                        PreConfig(
                                                          language:
                                                              _controller
                                                                  .lspConfig
                                                                  ?.languageId
                                                                  .toLowerCase() ??
                                                              "dart",
                                                          theme: _editorTheme,
                                                          textStyle: TextStyle(
                                                            fontSize:
                                                                _hoverDetailsStyle
                                                                    .textStyle
                                                                    .fontSize,
                                                          ),
                                                          styleNotMatched:
                                                              TextStyle(
                                                                color:
                                                                    _editorTheme['root']!
                                                                        .color,
                                                              ),
                                                          decoration: BoxDecoration(
                                                            color: _editorTheme['root']!
                                                                .backgroundColor!,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .zero,
                                                            border: Border.all(
                                                              width: 0.2,
                                                              color:
                                                                  _editorTheme['root']!
                                                                      .color ??
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    ValueListenableBuilder<Offset?>(
                      valueListenable: _aiOffsetNotifier,
                      builder: (context, offvalue, child) {
                        return _isMobile &&
                                _aiNotifier.value != null &&
                                offvalue != null &&
                                _aiNotifier.value!.isNotEmpty
                            ? Positioned(
                                top:
                                    offvalue.dy +
                                    (widget.textStyle?.fontSize ?? 14) *
                                        _aiNotifier.value!.split('\n').length +
                                    15,
                                left:
                                    offvalue.dx +
                                    (_aiNotifier.value!.split('\n')[0].length *
                                        (widget.textStyle?.fontSize ?? 14) /
                                        2),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if (_aiNotifier.value == null) return;
                                        _controller.insertAtCurrentCursor(
                                          _aiNotifier.value!,
                                        );
                                        _aiNotifier.value = null;
                                        _aiOffsetNotifier.value = null;
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: _editorTheme['root']
                                              ?.backgroundColor,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                          border: BoxBorder.all(
                                            width: 1.5,
                                            color: Color(0xff64b5f6),
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.check,
                                          color: _editorTheme['root']?.color,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 30),
                                    InkWell(
                                      onTap: () {
                                        _aiNotifier.value = null;
                                        _aiOffsetNotifier.value = null;
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: _editorTheme['root']
                                              ?.backgroundColor,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                          border: BoxBorder.all(
                                            width: 1.5,
                                            color: Colors.red,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.close,
                                          color: _editorTheme['root']?.color,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox.shrink();
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: _lspActionOffsetNotifier,
                      builder: (_, offset, child) {
                        if (offset == null ||
                            _lspActionNotifier.value == null ||
                            _controller.lspConfig == null ||
                            !widget.enableSuggestions) {
                          return SizedBox.shrink();
                        }

                        return Positioned(
                          width: screenWidth < 700
                              ? screenWidth * 0.63
                              : screenWidth * 0.3,
                          top:
                              offset.dy +
                              (widget.textStyle?.fontSize ?? 14) +
                              10,
                          left: offset.dx,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: 400,
                              maxWidth: 400,
                              minWidth: 70,
                            ),
                            child: Card(
                              shape: _suggestionStyle.shape,
                              elevation: _suggestionStyle.elevation,
                              color: _suggestionStyle.backgroundColor,
                              margin: EdgeInsets.zero,
                              child: RawScrollbar(
                                controller: _actionScrollController,
                                thumbVisibility: true,
                                thumbColor: _editorTheme['root']!.color!
                                    .withAlpha(80),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  controller: _actionScrollController,
                                  itemExtent:
                                      (widget.textStyle?.fontSize ?? 14) + 6.5,
                                  itemCount: _lspActionNotifier.value!.length,
                                  itemBuilder: (_, indx) {
                                    final actionData = List.from(
                                      _lspActionNotifier.value!,
                                    ).cast<Map<String, dynamic>>();
                                    return Tooltip(
                                      message: actionData[indx]['title'],
                                      child: InkWell(
                                        hoverColor: _suggestionStyle.hoverColor,
                                        onTap: () {
                                          try {
                                            (() async {
                                              await _controller
                                                  .applyWorkspaceEdit(
                                                    actionData[indx],
                                                  );
                                            })();
                                          } catch (e, st) {
                                            debugPrint(
                                              'Code action failed: $e\n$st',
                                            );
                                          } finally {
                                            _lspActionNotifier.value = null;
                                            _lspActionOffsetNotifier.value =
                                                null;
                                          }
                                        },
                                        child: Container(
                                          color: indx == _actionSelIndex
                                              ? _suggestionStyle.focusColor
                                              : Colors.transparent,
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 5.5,
                                                ),
                                                child: Icon(
                                                  Icons.lightbulb_outline,
                                                  color: Colors.yellowAccent,
                                                  size:
                                                      _suggestionStyle
                                                          .textStyle
                                                          .fontSize ??
                                                      14,
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        left: 20,
                                                      ),
                                                  child: Text(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    actionData[indx]['title'],
                                                    style: _suggestionStyle
                                                        .textStyle,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSearchOverlay() {
    return Positioned(
      top: 8,
      right: 8,
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(4),
        color: _editorTheme['root']?.backgroundColor ?? Colors.grey[900],
        child: Container(
          padding: const EdgeInsets.all(8),
          width: 400,
          child: TextField(
            controller: _searchController,
            focusNode: _searchFocusNode,
            style: TextStyle(
              color: _editorTheme['root']?.color ?? Colors.white,
              fontSize: 14,
            ),
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: TextStyle(
                color: (_editorTheme['root']?.color ?? Colors.white)
                    .withOpacity(0.5),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(
                  color: _editorTheme['root']?.color ?? Colors.white,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(
                  color: (_editorTheme['root']?.color ?? Colors.white)
                      .withOpacity(0.5),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(
                  color: _editorTheme['root']?.color ?? Colors.white,
                  width: 2,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 8,
              ),
              isDense: true,
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Match counter
                  if (_searchMatches.isNotEmpty || _searchText.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        _searchMatches.isEmpty && _searchText.isNotEmpty
                            ? 'No matches'
                            : _searchMatches.isEmpty
                            ? ''
                            : '${_currentMatchIndex + 1} of ${_searchMatches.length}',
                        style: TextStyle(
                          color: (_editorTheme['root']?.color ?? Colors.white)
                              .withOpacity(0.7),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  // Previous button
                  IconButton(
                    icon: const Icon(Icons.arrow_upward, size: 18),
                    color: _editorTheme['root']?.color ?? Colors.white,
                    onPressed: _searchMatches.isEmpty
                        ? null
                        : () => navigateToPreviousMatch(),
                    tooltip: 'Previous (Shift+Enter)',
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 32,
                      minHeight: 32,
                    ),
                  ),
                  // Next button
                  IconButton(
                    icon: const Icon(Icons.arrow_downward, size: 18),
                    color: _editorTheme['root']?.color ?? Colors.white,
                    onPressed: _searchMatches.isEmpty
                        ? null
                        : () => navigateToNextMatch(),
                    tooltip: 'Next (Enter)',
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 32,
                      minHeight: 32,
                    ),
                  ),
                  // Close button
                  IconButton(
                    icon: const Icon(Icons.close, size: 20),
                    color: _editorTheme['root']?.color ?? Colors.white,
                    onPressed: () {
                      setState(() {
                        _isSearchVisible = false;
                        _searchText = '';
                        _currentMatchIndex = -1;
                        _searchMatches = [];
                      });
                      _controller.clearSearchHighlights();
                      _focusNode.requestFocus();
                    },
                    tooltip: 'Close (Esc)',
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 32,
                      minHeight: 32,
                    ),
                  ),
                ],
              ),
            ),
            onChanged: (value) {
              setState(() {
                _searchText = value;
                _currentMatchIndex = -1;
              });
              performSearch();
            },
          ),
        ),
      ),
    );
  }

  void performSearch() {
    if (_searchText.isEmpty) {
      _controller.clearSearchHighlights();
      _searchMatches = [];
      _currentMatchIndex = -1;
      return;
    }

    final text = _controller.text;
    final searchText = _searchText;
    _searchMatches = [];

    int offset = 0;
    while (offset < text.length) {
      final index = text.indexOf(searchText, offset);
      if (index == -1) break;

      _searchMatches.add(
        SearchHighlight(
          start: index,
          end: index + searchText.length,
          style: TextStyle(
            backgroundColor: Colors.amberAccent.withOpacity(0.3),
          ),
        ),
      );

      offset = index + 1;
    }

    _controller.searchHighlights = _searchMatches;
    _controller.searchHighlightsChanged = true;
    _controller.notifyListeners();

    setState(() {
      if (_searchMatches.isNotEmpty) {
        _currentMatchIndex = 0;
      } else {
        _currentMatchIndex = -1;
      }
    });

    if (_searchMatches.isNotEmpty) {
      scrollToMatch(_currentMatchIndex);
    }
  }

  void navigateToNextMatch() {
    if (_searchMatches.isEmpty) return;

    setState(() {
      _currentMatchIndex = (_currentMatchIndex + 1) % _searchMatches.length;
    });
    scrollToMatch(_currentMatchIndex);
    highlightCurrentMatch();
  }

  void navigateToPreviousMatch() {
    if (_searchMatches.isEmpty) return;

    setState(() {
      _currentMatchIndex =
          (_currentMatchIndex - 1 + _searchMatches.length) %
          _searchMatches.length;
    });
    scrollToMatch(_currentMatchIndex);
    highlightCurrentMatch();
  }

  void scrollToMatch(int index) {
    if (index < 0 || index >= _searchMatches.length) return;

    final match = _searchMatches[index];
    final startLine = _controller.getLineAtOffset(match.start);

    // Estimate line height (using font size from text style)
    final fontSize = widget.textStyle?.fontSize ?? 14.0;
    final lineHeight = fontSize * 1.5; // Approximate line height multiplier
    final targetY = startLine * lineHeight;

    // Scroll to make the match visible
    if (_vscrollController.hasClients) {
      final viewportHeight = _vscrollController.position.viewportDimension;
      final currentOffset = _vscrollController.offset;

      if (targetY < currentOffset) {
        _vscrollController.jumpTo(targetY);
      } else if (targetY + lineHeight > currentOffset + viewportHeight) {
        _vscrollController.jumpTo(targetY + lineHeight - viewportHeight);
      }
    }

    // Set selection to the match
    _controller.setSelectionSilently(
      TextSelection(baseOffset: match.start, extentOffset: match.end),
    );
  }

  void highlightCurrentMatch() {
    if (_currentMatchIndex < 0 || _currentMatchIndex >= _searchMatches.length) {
      return;
    }

    // Update highlights to show current match differently
    final updatedHighlights = <SearchHighlight>[];
    for (int i = 0; i < _searchMatches.length; i++) {
      final match = _searchMatches[i];
      updatedHighlights.add(
        SearchHighlight(
          start: match.start,
          end: match.end,
          style: TextStyle(
            backgroundColor: i == _currentMatchIndex
                ? Colors.amberAccent.withOpacity(0.6)
                : Colors.amberAccent.withOpacity(0.3),
          ),
        ),
      );
    }

    _controller.searchHighlights = updatedHighlights;
    _controller.searchHighlightsChanged = true;
    _controller.notifyListeners();
  }

  void acceptSuggestion() {
    final suggestions = _suggestionNotifier.value;
    if (suggestions == null || suggestions.isEmpty) return;

    final selected = suggestions[_sugSelIndex];
    String insertText = '';

    if (selected is LspCompletion) {
      insertText = selected.label;
    } else if (selected is SuggestionModel) {
      // Custom suggestions with SuggestionModel
      // Check if trigger pattern exists before cursor and replace it entirely
      // Also handle cases where cursor is in the middle of the trigger pattern
      final text = _controller.text;
      final cursorPos = _controller.selection.extentOffset;
      final textBeforeCursor = text.substring(0, cursorPos);
      final textAfterCursor = text.substring(cursorPos);
      final triggerPattern = selected.triggeredAt;

      if (triggerPattern.isNotEmpty) {
        // Check if trigger pattern exists entirely before cursor
        if (textBeforeCursor.endsWith(triggerPattern)) {
          // Trigger pattern found - replace the entire trigger pattern with replacedOnClick
          final triggerStartPos = cursorPos - triggerPattern.length;
          _controller.replaceRange(
            triggerStartPos,
            cursorPos,
            selected.replacedOnClick,
          );
          _suggestionNotifier.value = null;
          _sugSelIndex = 0;
          return;
        }

        // Check if cursor is in the middle of the trigger pattern
        // e.g., trigger is "{{}}" and we have "{{" before cursor and "}}" after cursor
        for (int i = 1; i < triggerPattern.length; i++) {
          final triggerPrefix = triggerPattern.substring(0, i);
          final triggerSuffix = triggerPattern.substring(i);
          if (textBeforeCursor.endsWith(triggerPrefix) &&
              textAfterCursor.startsWith(triggerSuffix)) {
            // Cursor is in the middle of the trigger pattern - replace entire pattern
            final triggerStartPos = cursorPos - triggerPrefix.length;
            final triggerEndPos = cursorPos + triggerSuffix.length;
            _controller.replaceRange(
              triggerStartPos,
              triggerEndPos,
              selected.replacedOnClick,
            );
            _suggestionNotifier.value = null;
            _sugSelIndex = 0;
            return;
          }
        }
      }

      // No trigger pattern found or partial match - use normal insertion
      insertText = selected.replacedOnClick;
    } else if (selected is Map) {
      // Legacy map format support
      insertText =
          selected['replaced_on_click'] ??
          selected['insertText'] ??
          selected['label'] ??
          '';
    } else if (selected is String) {
      insertText = selected;
    }

    if (insertText.isNotEmpty) {
      // Check if this is a tag completion
      final language = _controller.currentLanguage?.name;
      final text = _controller.text;
      final cursorPos = _controller.selection.extentOffset;
      if (TagCompletion.supportsTagCompletion(
            language,
            text: text,
            cursorPosition: cursorPos,
          ) &&
          widget.lspConfig == null &&
          selected is String) {
        final tagContext = TagCompletion.analyzeTagContext(text, cursorPos);

        if (tagContext.isInTag) {
          // Get the template for this tag
          final templateText = TagCompletion.getInsertTextForTag(
            insertText,
            tagContext.isClosingTag,
            tagContext,
          );

          // Calculate what to replace
          // For HTML: Replace from after '<' (or '</') to cursor
          // For Jinja: Replace from after '{%' to cursor (or up to '%}' if tag is already closed)
          final replaceStart = tagContext.isJinjaTag
              ? (tagContext.isClosingTag
                    ? tagContext.tagStart +
                          5 // '{% end'
                    : tagContext.tagStart + 2) // '{%'
              : (tagContext.isClosingTag
                    ? tagContext.tagStart +
                          2 // '</'
                    : tagContext.tagStart + 1); // '<'

          // For Jinja tags, if tagEnd is found (meaning '%}' exists),
          // replace up to tagEnd+1 (to include the '}') to avoid duplicating '%}'
          int replaceEnd = cursorPos;
          if (tagContext.isJinjaTag && tagContext.tagEnd != null) {
            // tagEnd points to the '}' character, so include it
            replaceEnd = tagContext.tagEnd! + 1;
          }

          // Replace the prefix with the template
          _controller.replaceRange(replaceStart, replaceEnd, templateText);

          // Position cursor appropriately
          if (!tagContext.isClosingTag) {
            if (tagContext.isJinjaTag) {
              // For Jinja tags, place cursor after '%}' if template has it
              if (templateText.contains('%}')) {
                final tagEndIndex = templateText.indexOf('%}');
                final newCursorPos = replaceStart + tagEndIndex + 2;
                _controller.selection = TextSelection.collapsed(
                  offset: newCursorPos.clamp(0, _controller.length),
                );
              }
            } else {
              // For HTML tags, place cursor after '>'
              if (templateText.contains('>')) {
                final tagEndIndex = templateText.indexOf('>');
                final newCursorPos = replaceStart + tagEndIndex + 1;
                _controller.selection = TextSelection.collapsed(
                  offset: newCursorPos.clamp(0, _controller.length),
                );
              }
            }
          }
        } else {
          // Fallback to normal insertion
          _controller.insertAtCurrentCursor(insertText, replaceTypedChar: true);
        }
      } else {
        // Normal suggestion insertion
        _controller.insertAtCurrentCursor(insertText, replaceTypedChar: true);
      }
    }

    _suggestionNotifier.value = null;
    _sugSelIndex = 0;
  }

  /// Handles showing custom suggestions popup.
  ///
  /// This is called by the controller when [_showCustomSuggestions] is invoked.
  void _showCustomSuggestions(List<SuggestionModel> suggestions) {
    if (!mounted) return;

    // Set suggestions and show popup
    _suggestions = suggestions;
    _sugSelIndex = 0;
    _suggestionNotifier.value = suggestions;
  }

  Future<void> getManualAiSuggestion() async {
    _suggestionNotifier.value = null;
    final aiCompletion = _controller.aiCompletion ?? widget.aiCompletion;
    if (aiCompletion?.completionType == CompletionType.manual ||
        aiCompletion?.completionType == CompletionType.mixed) {
      final String text = _controller.text;
      final int cursorPosition = _controller.selection.extentOffset;
      final String codeToSend =
          "${text.substring(0, cursorPosition)}<|CURSOR|>${text.substring(cursorPosition)}";
      _aiNotifier.value = await _getCachedResponse(codeToSend, aiCompletion!);
    }
  }

  Future<String> _getCachedResponse(
    String codeToSend,
    AiCompletion aiCompletion,
  ) async {
    final String key = codeToSend.hashCode.toString();
    if (_cachedResponse.containsKey(key)) {
      return _cachedResponse[key]!;
    }
    final String aiResponse = await aiCompletion.model.completionResponse(
      codeToSend,
    );
    _cachedResponse[key] = aiResponse;
    return aiResponse;
  }

  void _acceptAiCompletion() {
    final aiText = _aiNotifier.value;
    if (aiText == null || aiText.isEmpty) return;
    _controller.insertAtCurrentCursor(aiText);
    _aiNotifier.value = null;
    _aiOffsetNotifier.value = null;
  }

  void acceptGhostText() {
    final ghostText = _aiNotifier.value;
    if (ghostText == null || ghostText.isEmpty) return;
    _controller.insertAtCurrentCursor(ghostText);
    _aiNotifier.value = null;
    _aiOffsetNotifier.value = null;
  }

  void acceptControllerGhostText() {
    final ghost = _controller.ghostText;
    if (ghost == null || ghost.text.isEmpty) return;
    _controller.insertAtCurrentCursor(ghost.text);
    _controller.clearGhostText();
  }
}

class _CodeField extends LeafRenderObjectWidget {
  final CodeForgeController controller;
  final Map<String, TextStyle> editorTheme;
  final Mode language;
  final String? languageId;
  final LspConfig? lspConfig;
  final List<LspSemanticToken>? semanticTokens;
  final int semanticTokensVersion;
  final EdgeInsets? innerPadding;
  final ScrollController vscrollController, hscrollController;
  final FocusNode focusNode;
  final bool readOnly, isMobile, lineWrap;
  final AnimationController caretBlinkController;
  final AnimationController lineHighlightController;
  final TextStyle? textStyle;
  final bool enableFolding, enableGuideLines, enableGutter, enableGutterDivider;
  final GutterStyle gutterStyle;
  final CodeSelectionStyle selectionStyle;
  final List<LspErrors> diagnostics;
  final ValueNotifier<bool> selectionActiveNotifier, isHoveringPopup;
  final ValueNotifier<Offset> contextMenuOffsetNotifier, offsetNotifier;
  final ValueNotifier<List<dynamic>?> hoverNotifier, suggestionNotifier;
  final ValueNotifier<List<dynamic>?> lspActionNotifier;
  final ValueNotifier<String?> aiNotifier;
  final ValueNotifier<LspSignatureHelps?> signatureNotifier;
  final ValueNotifier<Offset?> aiOffsetNotifier, lspActionOffsetNotifier;
  final BuildContext context;
  final TextStyle? ghostTextStyle;
  final String? filePath;
  final MatchHighlightStyle? matchHighlightStyle;

  const _CodeField({
    required this.controller,
    required this.editorTheme,
    required this.language,
    required this.vscrollController,
    required this.hscrollController,
    required this.focusNode,
    required this.readOnly,
    required this.caretBlinkController,
    required this.lineHighlightController,
    required this.enableFolding,
    required this.enableGuideLines,
    required this.enableGutter,
    required this.enableGutterDivider,
    required this.gutterStyle,
    required this.selectionStyle,
    required this.diagnostics,
    required this.isMobile,
    required this.selectionActiveNotifier,
    required this.contextMenuOffsetNotifier,
    required this.offsetNotifier,
    required this.hoverNotifier,
    required this.suggestionNotifier,
    required this.aiNotifier,
    required this.signatureNotifier,
    required this.aiOffsetNotifier,
    required this.lspActionNotifier,
    required this.lspActionOffsetNotifier,
    required this.isHoveringPopup,
    required this.context,
    required this.lineWrap,
    this.filePath,
    this.textStyle,
    this.languageId,
    this.lspConfig,
    this.semanticTokens,
    this.semanticTokensVersion = 0,
    this.innerPadding,
    this.ghostTextStyle,
    this.matchHighlightStyle,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _CodeFieldRenderer(
      context: context,
      controller: controller,
      editorTheme: editorTheme,
      language: language,
      languageId: languageId,
      lspConfig: lspConfig,
      innerPadding: innerPadding,
      vscrollController: vscrollController,
      hscrollController: hscrollController,
      focusNode: focusNode,
      readOnly: readOnly,
      caretBlinkController: caretBlinkController,
      lineHighlightController: lineHighlightController,
      textStyle: textStyle,
      matchHighlightStyle: matchHighlightStyle,
      enableFolding: enableFolding,
      enableGuideLines: enableGuideLines,
      enableGutter: enableGutter,
      enableGutterDivider: enableGutterDivider,
      gutterStyle: gutterStyle,
      selectionStyle: selectionStyle,
      diagnostics: diagnostics,
      isMobile: isMobile,
      selectionActiveNotifier: selectionActiveNotifier,
      contextMenuOffsetNotifier: contextMenuOffsetNotifier,
      hoverNotifier: hoverNotifier,
      lineWrap: lineWrap,
      offsetNotifier: offsetNotifier,
      aiNotifier: aiNotifier,
      aiOffsetNotifier: aiOffsetNotifier,
      isHoveringPopup: isHoveringPopup,
      suggestionNotifier: suggestionNotifier,
      lspActionNotifier: lspActionNotifier,
      lspActionOffsetNotifier: lspActionOffsetNotifier,
      signatureNotifier: signatureNotifier,
      ghostTextStyle: ghostTextStyle,
      filePath: filePath,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    _CodeFieldRenderer renderObject,
  ) {
    renderObject
      ..updateDiagnostics(diagnostics)
      ..editorTheme = editorTheme
      ..language = language
      ..textStyle = textStyle
      ..innerPadding = innerPadding
      ..readOnly = readOnly
      ..lineWrap = lineWrap
      ..enableFolding = enableFolding
      ..enableGuideLines = enableGuideLines
      ..enableGutter = enableGutter
      ..enableGutterDivider = enableGutterDivider
      ..gutterStyle = gutterStyle
      ..selectionStyle = selectionStyle
      ..ghostTextStyle = ghostTextStyle
      ..rulers = controller.rulers;
  }
}

class _CodeFieldRenderer extends RenderBox implements MouseTrackerAnnotation {
  final CodeForgeController controller;
  final String? languageId, filePath;
  final ScrollController vscrollController, hscrollController;
  final FocusNode focusNode;
  final AnimationController caretBlinkController;
  final AnimationController lineHighlightController;
  final bool isMobile;
  final ValueNotifier<bool> selectionActiveNotifier, isHoveringPopup;
  final ValueNotifier<Offset> contextMenuOffsetNotifier, offsetNotifier;
  final ValueNotifier<List<dynamic>?> hoverNotifier, suggestionNotifier;
  final ValueNotifier<List<dynamic>?> lspActionNotifier;
  final ValueNotifier<Offset?> aiOffsetNotifier, lspActionOffsetNotifier;
  final ValueNotifier<String?> aiNotifier;
  final ValueNotifier<LspSignatureHelps?> signatureNotifier;
  final BuildContext context;
  final LspConfig? lspConfig;
  final Map<int, double> lineWidthCache = {};
  final Map<int, String> lineTextCache = {};
  final Map<int, Rect> actionBulbRects = {};
  final Map<int, ui.Paragraph> paragraphCache = {};
  final Map<int, double> lineHeightCache = {};
  final List<FoldRange> foldRanges = [];
  final MatchHighlightStyle? matchHighlightStyle0;
  final MatchHighlightStyle? matchHighlightStyle;
  late double lineHeight0;
  final dtap = DoubleTapGestureRecognizer();
  final onetap = TapGestureRecognizer();
  late final double gutterPadding;
  late final Paint caretPainter;
  late final Paint bracketHighlightPainter;
  late final ui.ParagraphStyle paragraphStyle;
  late final ui.TextStyle uiTextStyle;
  late SyntaxHighlighter syntaxHighlighter;
  late double gutterWidth;
  TextStyle? ghostTextStyle;
  Map<String, TextStyle> editorTheme;
  Mode language;
  EdgeInsets? innerPadding;
  TextStyle? textStyle;
  GutterStyle gutterStyle;
  CodeSelectionStyle selectionStyle;
  List<LspErrors> diagnostics;
  int cachedCaretOffset = -1, cachedCaretLine = 0, cachedCaretLineStart = 0;
  int? dragStartOffset;
  Timer? selectionTimer, hoverTimer;
  Offset? pointerDownPosition;
  Offset currentPosition = Offset.zero;
  int? hoveredBreakpointLine;
  bool enableFolding, enableGuideLines, enableGutter, enableGutterDivider;
  bool isFoldToggleInProgress = false, lineWrap;
  bool foldRangesNeedsClear = false;
  bool selectionActive = false, isDragging = false;
  bool draggingStartHandle = false, draggingEndHandle = false;
  bool showBubble = false, draggingCHandle = false, readOnly;
  Rect? startHandleRect, endHandleRect, normalHandle;
  double longLineWidth = 0.0, wrapWidth = double.infinity;
  Timer? resizeTimer;
  double? cachedCharacterWidth;
  List<int>? rulers;
  int cachedLineCount = 0;
  Timer? layoutDebounceTimer;
  bool isDeferringLayout = false;
  int previousLineCount = 0;
  double cachedTotalHeight = 0.0;
  bool hasCachedHeight = false;
  String? aiResponse, lastProcessedText;
  TextSelection? lastSelectionForAi;
  ui.Paragraph? cachedMagnifiedParagraph;
  int? cachedMagnifiedLine, cachedMagnifiedOffset;
  int lastAppliedSemanticVersion = -1, lastDocumentVersion = -1;
  int? ghostTextAnchorLine;
  int ghostTextLineCount = 0;
  int? highlightedLine;
  Animation<double>? lineHighlightAnimation;

  void updateSemanticTokens(List<LspSemanticToken> tokens, int version) {
    if (version < lastAppliedSemanticVersion) return;
    lastAppliedSemanticVersion = version;
    syntaxHighlighter.updateSemanticTokens(tokens, controller.text);
    paragraphCache.clear();
  }

  void checkDocumentVersionAndClearCache() {
    final currentDocVersion = syntaxHighlighter.documentVersion;
    if (currentDocVersion != lastDocumentVersion) {
      lastDocumentVersion = currentDocVersion;
      paragraphCache.clear();
      lineTextCache.clear();
      lineWidthCache.clear();
      lineHeightCache.clear();
    }
  }

  void updateDiagnostics(List<LspErrors> diagnostics) {
    if (diagnostics != diagnostics) {
      diagnostics = diagnostics;
      markNeedsPaint();
    }
  }

  ui.Paragraph buildParagraph(String text, {double? width}) {
    final builder = ui.ParagraphBuilder(paragraphStyle)
      ..pushStyle(uiTextStyle)
      ..addText(text.isEmpty ? ' ' : text);
    final p = builder.build();
    p.layout(ui.ParagraphConstraints(width: width ?? double.infinity));
    return p;
  }

  ui.Paragraph buildHighlightedParagraph(
    int lineIndex,
    String text, {
    double? width,
  }) {
    final fontSize = textStyle.fontSize ?? 14.0;
    final fontFamily = textStyle.fontFamily;
    return syntaxHighlighter.buildHighlightedParagraph(
      lineIndex,
      text,
      paragraphStyle,
      fontSize,
      fontFamily,
      width: width,
    );
  }

  _CodeFieldRenderer({
    required this.controller,
    required this.vscrollController,
    required this.hscrollController,
    required this.focusNode,
    required this.caretBlinkController,
    required this.lineHighlightController,
    required this.isMobile,
    required this.selectionActiveNotifier,
    required this.contextMenuOffsetNotifier,
    required this.offsetNotifier,
    required this.hoverNotifier,
    required this.suggestionNotifier,
    required this.lspActionNotifier,
    required this.lspActionOffsetNotifier,
    required this.aiNotifier,
    required this.aiOffsetNotifier,
    required this.signatureNotifier,
    required this.isHoveringPopup,
    required this.context,
    required bool lineWrap,
    required Map<String, TextStyle> editorTheme,
    required Mode language,
    required bool readOnly,
    required bool enableFolding,
    required bool enableGuideLines,
    required bool enableGutter,
    required bool enableGutterDivider,
    required GutterStyle gutterStyle,
    required CodeSelectionStyle selectionStyle,
    required List<LspErrors> diagnostics,
    this.languageId,
    this.lspConfig,
    this.filePath,
    this.matchHighlightStyle,
    EdgeInsets? innerPadding,
    TextStyle? textStyle,
    TextStyle? ghostTextStyle,
  }) : editorTheme = editorTheme,
       ghostTextStyle = ghostTextStyle,
       language = language,
       readOnly = readOnly,
       enableFolding = enableFolding,
       enableGuideLines = enableGuideLines,
       enableGutter = enableGutter,
       enableGutterDivider = enableGutterDivider,
       gutterStyle = gutterStyle,
       selectionStyle = selectionStyle,
       lineWrap = lineWrap,
       innerPadding = innerPadding,
       textStyle = textStyle,
       diagnostics = diagnostics,
       matchHighlightStyle0 = matchHighlightStyle {
    final fontSize = textStyle?.fontSize ?? 14.0;
    final fontFamily = textStyle?.fontFamily;
    final color =
        textStyle?.color ?? editorTheme['root']?.color ?? Colors.black;
    final lineHeightMultiplier = textStyle?.height ?? 1.2;

    lineHeight0 = fontSize * lineHeightMultiplier;

    syntaxHighlighter = SyntaxHighlighter(
      language: language,
      editorTheme: editorTheme,
      baseTextStyle: textStyle,
      languageId: languageId,
    );

    gutterPadding = fontSize;
    if (enableGutter) {
      if (gutterStyle.gutterWidth != null) {
        gutterWidth = gutterStyle.gutterWidth!;
      } else {
        final digits = controller.lineCount.toString().length;
        final digitWidth = digits * gutterPadding * 0.6;
        final foldIconSpace = enableFolding ? fontSize + 4 : 0;
        final breakpointColumnWidth = (gutterStyle.showBreakpoints)
            ? fontSize * 1.5
            : 0;
        gutterWidth =
            breakpointColumnWidth +
            digitWidth +
            foldIconSpace +
            gutterPadding -
            15;
      }
    } else {
      gutterWidth = 0;
    }
    cachedLineCount = controller.lineCount;

    caretPainter = Paint()
      ..color = selectionStyle.cursorColor ?? color
      ..style = PaintingStyle.fill;

    bracketHighlightPainter = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    paragraphStyle = ui.ParagraphStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      height: lineHeightMultiplier,
    );
    uiTextStyle = ui.TextStyle(
      color: color,
      fontSize: fontSize,
      fontFamily: fontFamily,
    );

    vscrollController.addListener(() {
      if (suggestionNotifier.value != null && offsetNotifier.value.dy >= 0) {
        offsetNotifier.value = Offset(
          offsetNotifier.value.dx,
          getCaretInfo().offset.dy - vscrollController.offset,
        );
      }

      if (lspActionOffsetNotifier.value != null) {
        lspActionOffsetNotifier.value = Offset(
          lspActionOffsetNotifier.value!.dx,
          getCaretInfo().offset.dy - vscrollController.offset,
        );
      }

      markNeedsPaint();
    });

    hscrollController.addListener(() {
      if (suggestionNotifier.value != null && offsetNotifier.value.dx >= 0) {
        offsetNotifier.value = Offset(
          getCaretInfo().offset.dx - hscrollController.offset,
          offsetNotifier.value.dy,
        );
      }

      if (lspActionOffsetNotifier.value != null) {
        lspActionOffsetNotifier.value = Offset(
          getCaretInfo().offset.dx - hscrollController.offset,
          lspActionOffsetNotifier.value!.dy,
        );
      }

      markNeedsPaint();
    });

    caretBlinkController.addListener(markNeedsPaint);
    controller.addListener(onControllerChange);

    lineHighlightAnimation = Tween<double>(begin: 0.55, end: 0.0).animate(
      CurvedAnimation(parent: lineHighlightController, curve: Curves.easeOut),
    )..addListener(markNeedsPaint);

    if (enableFolding) {
      controller.setFoldCallbacks(
        toggleFold: toggleFoldAtLine,
        foldAll: foldAllRanges,
        unfoldAll: unfoldAllRanges,
      );
    }

    controller.setScrollCallback(scrollToLine);

    hoverNotifier.addListener(() {
      if (hoverNotifier.value == null) {
        hoverTimer?.cancel();
      }
    });

    aiNotifier.addListener(() {
      final previousAiResponse = aiResponse;
      aiResponse = aiNotifier.value;
      aiOffsetNotifier.value = getCaretInfo().offset;

      if (aiResponse != null && aiResponse!.isNotEmpty) {
        final aiLines = aiResponse!.split('\n');
        ghostTextAnchorLine = controller.getLineAtOffset(
          controller.selection.extentOffset.clamp(0, controller.length),
        );
        ghostTextLineCount = aiLines.length - 1; // Extra lines beyond first
      } else if (aiResponse == null && previousAiResponse != null) {
        ghostTextAnchorLine = null;
        ghostTextLineCount = 0;
      }

      markNeedsLayout();
      markNeedsPaint();
    });
  }

  Map<String, TextStyle> get editorTheme => _editorTheme;
  Mode get language => _language;
  TextStyle? get textStyle => _textStyle;
  EdgeInsets? get innerPadding => _innerPadding;
  bool get readOnly => _readOnly;
  bool get lineWrap => _lineWrap;
  bool get enableFolding => _enableFolding;
  bool get enableGuideLines => _enableGuideLines;
  bool get enableGutter => _enableGutter;
  bool get enableGutterDivider => _enableGutterDivider;
  GutterStyle get gutterStyle => _gutterStyle;
  TextStyle? get ghostTextStyle => _ghostTextStyle;
  set ghostTextStyle(TextStyle? value) {
    if (_ghostTextStyle == value) return;
    _ghostTextStyle = value;
    markNeedsPaint();
  }

  CodeSelectionStyle get selectionStyle => _selectionStyle;

  set editorTheme(Map<String, TextStyle> theme) {
    if (identical(theme, editorTheme)) return;
    editorTheme = theme;
    try {
      syntaxHighlighter.dispose();
    } catch (e) {
      //
    }
    syntaxHighlighter = SyntaxHighlighter(
      language: language,
      editorTheme: theme,
      baseTextStyle: textStyle,
    );
    paragraphCache.clear();
    markNeedsLayout();
    markNeedsPaint();
  }

  set language(Mode lang) {
    if (identical(lang, language)) return;
    language = lang;
    try {
      syntaxHighlighter.dispose();
    } catch (e) {
      //
    }
    syntaxHighlighter = SyntaxHighlighter(
      language: lang,
      editorTheme: editorTheme,
      baseTextStyle: textStyle,
    );
    paragraphCache.clear();
    markNeedsLayout();
    markNeedsPaint();
  }

  set textStyle(TextStyle? style) {
    if (identical(style, textStyle)) return;
    textStyle = style;

    final fontSize = style?.fontSize ?? 14.0;
    final lineHeightMultiplier = style?.height ?? 1.2;

    lineHeight0 = fontSize * lineHeightMultiplier;

    try {
      syntaxHighlighter.dispose();
    } catch (e) {
      //
    }
    syntaxHighlighter = SyntaxHighlighter(
      language: language,
      editorTheme: editorTheme,
      baseTextStyle: style,
    );

    paragraphCache.clear();
    lineWidthCache.clear();
    lineTextCache.clear();
    lineHeightCache.clear();
    cachedCharacterWidth = null; // Invalidate character width cache

    markNeedsLayout();
    markNeedsPaint();
  }

  set innerPadding(EdgeInsets? padding) {
    if (identical(padding, innerPadding)) return;
    innerPadding = padding;
    markNeedsLayout();
    markNeedsPaint();
  }

  set readOnly(bool value) {
    if (readOnly == value) return;
    readOnly = value;
    markNeedsPaint();
  }

  set lineWrap(bool value) {
    if (lineWrap == value) return;
    lineWrap = value;
    paragraphCache.clear();
    lineHeightCache.clear();
    markNeedsLayout();
    markNeedsPaint();
  }

  set enableFolding(bool value) {
    if (enableFolding == value) return;
    enableFolding = value;
    markNeedsLayout();
    markNeedsPaint();
  }

  set enableGuideLines(bool value) {
    if (enableGuideLines == value) return;
    enableGuideLines = value;
    markNeedsPaint();
  }

  set enableGutter(bool value) {
    if (enableGutter == value) return;
    enableGutter = value;
    markNeedsLayout();
    markNeedsPaint();
  }

  set enableGutterDivider(bool value) {
    if (enableGutterDivider == value) return;
    enableGutterDivider = value;
    markNeedsPaint();
  }

  set rulers(List<int>? value) {
    if (rulers == value) return;
    rulers = value;
    markNeedsPaint();
  }

  set gutterStyle(GutterStyle style) {
    if (identical(style, gutterStyle)) return;
    gutterStyle = style;
    markNeedsPaint();
  }

  set selectionStyle(CodeSelectionStyle style) {
    if (identical(style, selectionStyle)) return;
    selectionStyle = style;
    caretPainter.color = style.cursorColor ?? editorTheme['root']!.color!;
    markNeedsPaint();
  }

  void ensureCaretVisible() {
    if (!vscrollController.hasClients || !hscrollController.hasClients) return;

    final caretInfo = getCaretInfo();
    final caretX = caretInfo.offset.dx + gutterWidth + (innerPadding.left ?? 0);
    final caretY = caretInfo.offset.dy + (innerPadding.top ?? 0);
    final caretHeight = caretInfo.height;
    final vScrollOffset = vscrollController.offset;
    final hScrollOffset = hscrollController.offset;
    final viewportHeight = vscrollController.position.viewportDimension;
    final viewportWidth = hscrollController.position.viewportDimension;
    final relX = (caretX - hScrollOffset).clamp(0.0, viewportWidth);
    final relY = (caretY - vScrollOffset).clamp(0.0, viewportHeight);

    offsetNotifier.value = Offset(relX, relY);

    if (caretY > 0 && caretY <= vScrollOffset + (innerPadding.top ?? 0)) {
      final targetOffset = caretY - (innerPadding.top ?? 0);
      vscrollController.jumpTo(
        targetOffset.clamp(0, vscrollController.position.maxScrollExtent),
      );
    } else if (caretY + caretHeight >= vScrollOffset + viewportHeight) {
      final targetOffset =
          caretY + caretHeight - viewportHeight + (innerPadding.bottom ?? 0);
      vscrollController.jumpTo(
        targetOffset.clamp(0, vscrollController.position.maxScrollExtent),
      );
    }

    if (caretX < hScrollOffset + (innerPadding.left ?? 0) + gutterWidth) {
      final targetOffset = caretX - (innerPadding.left ?? 0) - gutterWidth;
      hscrollController.jumpTo(
        targetOffset.clamp(0, hscrollController.position.maxScrollExtent),
      );
    } else if (caretX + 1.5 > hScrollOffset + viewportWidth) {
      final targetOffset =
          caretX +
          1.5 -
          viewportWidth +
          (innerPadding.right ?? 0) +
          gutterWidth;
      hscrollController.jumpTo(
        targetOffset.clamp(0, hscrollController.position.maxScrollExtent),
      );
    }
  }

  void deferLayout() {
    layoutDebounceTimer?.cancel();
    isDeferringLayout = true;

    if (hasCachedHeight) {
      final lineDelta = cachedLineCount - previousLineCount;
      cachedTotalHeight += lineDelta * lineHeight0;
    }
    previousLineCount = cachedLineCount;

    if (!isFoldToggleInProgress) {
      ensureCaretVisible();
    }
    markNeedsPaint();

    layoutDebounceTimer = Timer(const Duration(milliseconds: 100), () {
      isDeferringLayout = false;
      markNeedsLayout();
    });
  }

  void onControllerChange() {
    if (controller.searchHighlightsChanged) {
      controller.searchHighlightsChanged = false;
      markNeedsPaint();
      return;
    }

    if (controller.decorationsChanged) {
      controller.decorationsChanged = false;
      final ghost = controller.ghostText;
      if (ghost != null && ghost.text.isNotEmpty) {
        ghostTextAnchorLine = ghost.line;
        final ghostLines = ghost.text.split('\n');
        ghostTextLineCount = ghostLines.length - 1;
      } else if (aiResponse == null) {
        ghostTextAnchorLine = null;
        ghostTextLineCount = 0;
      }
      markNeedsLayout();
      markNeedsPaint();
      return;
    }

    if (controller.selectionOnly) {
      controller.selectionOnly = false;
      if (!isFoldToggleInProgress) {
        ensureCaretVisible();
      }

      if (isMobile && controller.selection.isCollapsed) {
        showBubble = true;
      }
      markNeedsPaint();
      return;
    }

    if (controller.bufferNeedsRepaint) {
      controller.bufferNeedsRepaint = false;
      if (!isFoldToggleInProgress) {
        ensureCaretVisible();
      }
      markNeedsPaint();
      return;
    }

    if (showBubble && isMobile) {
      showBubble = false;
    }

    final newText = controller.text;
    final previousText = lastProcessedText ?? newText;

    final dirtyRange = controller.dirtyRegion;
    if (dirtyRange != null) {
      final safeEnd = dirtyRange.end.clamp(dirtyRange.start, newText.length);
      final insertedText = newText.substring(dirtyRange.start, safeEnd);
      final delta = newText.length - previousText.length;
      final removedLength = max(insertedText.length - delta, 0);
      final oldEnd = dirtyRange.start + removedLength;

      syntaxHighlighter.applyDocumentEdit(
        dirtyRange.start,
        oldEnd,
        insertedText,
        newText,
      );

      paragraphCache.clear();
      lineTextCache.clear();
    }

    final newLineCount = controller.lineCount;
    final lineCountChanged = newLineCount != cachedLineCount;

    final affectedLine = controller.dirtyLine;
    if (affectedLine != null) {
      lineWidthCache.remove(affectedLine);
      lineTextCache.remove(affectedLine);
      paragraphCache.remove(affectedLine);
      lineHeightCache.remove(affectedLine);
      syntaxHighlighter.invalidateLines({affectedLine});
    }
    controller.clearDirtyRegion();

    if (lineCountChanged) {
      final insertionLine =
          affectedLine ??
          controller.getLineAtOffset(
            controller.selection.extentOffset.clamp(0, controller.length),
          );

      cachedLineCount = newLineCount;

      final startInvalidation = insertionLine > 0 ? insertionLine - 1 : 0;
      lineTextCache.removeWhere((key, _) => key >= startInvalidation);
      lineWidthCache.removeWhere((key, _) => key >= startInvalidation);
      paragraphCache.removeWhere((key, _) => key >= startInvalidation);
      lineHeightCache.removeWhere((key, _) => key >= startInvalidation);
      syntaxHighlighter.invalidateLines(
        Set.from(
          List.generate(
            newLineCount - startInvalidation,
            (i) => startInvalidation + i,
          ),
        ),
      );

      if (enableGutter && gutterStyle.gutterWidth == null) {
        final fontSize = textStyle.fontSize ?? 14.0;
        final digits = newLineCount.toString().length;
        final digitWidth = digits * gutterPadding * 0.6;
        final foldIconSpace = enableFolding ? fontSize + 4 : 0;
        gutterWidth = digitWidth + foldIconSpace + gutterPadding;
      }

      if (enableFolding) {
        foldRangesNeedsClear = true;
      }

      deferLayout();
    } else if (affectedLine != null) {
      final newLineWidth = getLineWidth(affectedLine);
      final currentContentWidth =
          size.width - gutterWidth - (innerPadding.horizontal ?? 0);
      if (newLineWidth > currentContentWidth || newLineWidth > longLineWidth) {
        longLineWidth = newLineWidth;
        markNeedsLayout();
      } else {
        markNeedsPaint();
      }
    } else {
      markNeedsPaint();
    }

    final oldText = previousText;
    final cursorPosition = controller.selection.extentOffset.clamp(
      0,
      controller.length,
    );
    final textBeforeCursor = newText.substring(0, cursorPosition);

    if (lastProcessedText == newText &&
        aiResponse != null &&
        aiResponse!.isNotEmpty &&
        lastSelectionForAi != controller.selection) {
      aiNotifier.value = null;
      aiOffsetNotifier.value = null;
      ghostTextAnchorLine = null;
      ghostTextLineCount = 0;
    }

    final ghost = controller.ghostText;
    if (lastProcessedText == newText &&
        ghost != null &&
        !ghost.shouldPersist &&
        lastSelectionForAi != controller.selection) {
      controller.clearGhostText();
    }
    lastSelectionForAi = controller.selection;

    if (aiResponse != null && aiResponse!.isNotEmpty) {
      final textLengthDiff = newText.length - oldText.length;

      if (textLengthDiff > 0 && cursorPosition >= textLengthDiff) {
        final newlyTypedChars = textBeforeCursor.substring(
          cursorPosition - textLengthDiff,
          cursorPosition,
        );

        if (aiResponse!.startsWith(newlyTypedChars)) {
          aiResponse = aiResponse!.substring(newlyTypedChars.length);
          if (aiResponse!.isEmpty) {
            aiNotifier.value = null;
            aiOffsetNotifier.value = null;
            ghostTextAnchorLine = null;
            ghostTextLineCount = 0;
          } else {
            aiNotifier.value = aiResponse;
            final aiLines = aiResponse!.split('\n');
            ghostTextLineCount = aiLines.length - 1;
          }
        } else {
          aiResponse = null;
          aiNotifier.value = null;
          aiOffsetNotifier.value = null;
          ghostTextAnchorLine = null;
          ghostTextLineCount = 0;
        }
      } else if (textLengthDiff < 0) {
        aiResponse = null;
        aiNotifier.value = null;
        aiOffsetNotifier.value = null;
        ghostTextAnchorLine = null;
        ghostTextLineCount = 0;
      }
    }

    final ctrlGhost = controller.ghostText;
    if (ctrlGhost != null && !ctrlGhost.shouldPersist) {
      final textLengthDiff = newText.length - oldText.length;

      if (textLengthDiff > 0 && cursorPosition >= textLengthDiff) {
        final newlyTypedChars = textBeforeCursor.substring(
          cursorPosition - textLengthDiff,
          cursorPosition,
        );

        if (ctrlGhost.text.startsWith(newlyTypedChars)) {
          final remainingText = ctrlGhost.text.substring(
            newlyTypedChars.length,
          );
          if (remainingText.isEmpty) {
            controller.clearGhostText();
          } else {
            controller.setGhostText(
              GhostText(
                line: ctrlGhost.line,
                column: ctrlGhost.column + newlyTypedChars.length,
                text: remainingText,
                style: ctrlGhost.style,
                shouldPersist: false,
              ),
            );
          }
        } else {
          controller.clearGhostText();
        }
      } else if (textLengthDiff < 0) {
        controller.clearGhostText();
      }
    }

    if (focusNode.hasFocus &&
        !isFoldToggleInProgress &&
        lastProcessedText != newText) {
      ensureCaretVisible();
    }

    if (lastProcessedText == newText) return;
    lastProcessedText = newText;
  }

  FoldRange? computeFoldRangeForLine(int lineIndex) {
    if (!enableFolding) return null;

    final line = controller.getLineText(lineIndex);
    final trimmed = line.trim();

    // 1. Jinja template tag folding: {% if %}, {% for %}, {% block %}, etc.
    // Works in any language (not just when language is Jinja)
    final jinjaTagMatch = RegExp(r'\{%\s*(\w+)').firstMatch(trimmed);
    if (jinjaTagMatch != null) {
      final tagName = jinjaTagMatch.group(1);
      final foldableTags = {
        'if',
        'for',
        'block',
        'macro',
        'filter',
        'with',
        'set',
        'call',
        'raw',
      };

      if (tagName != null && foldableTags.contains(tagName.toLowerCase())) {
        final tagNameLower = tagName.toLowerCase();
        int depth = 1;

        for (int i = lineIndex + 1; i < controller.lineCount; i++) {
          final checkLine = controller.getLineText(i).trim().toLowerCase();

          // Check for matching end tag (case-insensitive)
          final endTagRegex = RegExp(r'\{%\s*end' + tagNameLower + r'\s*%\}');
          if (endTagRegex.hasMatch(checkLine)) {
            depth--;
            if (depth == 0) {
              return FoldRange(lineIndex, i);
            }
          }

          // Check for nested opening tags of the same type (case-insensitive)
          final nestedTagRegex = RegExp(r'\{%\s*' + tagNameLower + r'\s*');
          if (nestedTagRegex.hasMatch(checkLine)) {
            depth++;
          }
        }
      }
    }

    // 2. HTML/XML tag folding: <div>...</div>, <table>...</table>, etc.
    final htmlTagMatch = RegExp(
      r'<\s*([a-zA-Z][a-zA-Z0-9-]*)\s*[^>]*>',
    ).firstMatch(trimmed);
    if (htmlTagMatch != null) {
      final tagName = htmlTagMatch.group(1);
      // Skip self-closing tags and void elements
      final voidElements = {
        'area',
        'base',
        'br',
        'col',
        'embed',
        'hr',
        'img',
        'input',
        'link',
        'meta',
        'param',
        'source',
        'track',
        'wbr',
      };

      // Check if it's a self-closing tag (ends with /> or />)
      final isSelfClosing = RegExp(r'/\s*>').hasMatch(trimmed);

      if (tagName != null &&
          !voidElements.contains(tagName.toLowerCase()) &&
          !isSelfClosing) {
        final tagNameLower = tagName.toLowerCase();
        int depth = 1;

        for (int i = lineIndex + 1; i < controller.lineCount; i++) {
          final checkLine = controller.getLineText(i).trim();

          // Check for matching closing tag
          final closingTagRegex = RegExp(
            r'</\s*' + tagNameLower + r'\s*>',
            caseSensitive: false,
          );
          if (closingTagRegex.hasMatch(checkLine)) {
            depth--;
            if (depth == 0) {
              return FoldRange(lineIndex, i);
            }
          }

          // Check for nested opening tags of the same type
          final openingTagRegex = RegExp(
            r'<\s*' + tagNameLower + r'\s*[^>]*>',
            caseSensitive: false,
          );
          if (openingTagRegex.hasMatch(checkLine) &&
              !checkLine.contains('/>')) {
            depth++;
          }
        }
      }
    }

    // 3. Brace-based folding: { }, ( ), [ ]
    // Skip if line contains Jinja syntax to avoid conflicts
    if (line.contains('{') &&
        !trimmed.contains('{%') &&
        !trimmed.contains('{{') &&
        !trimmed.contains('{#')) {
      int braceCount = 0;
      bool foundOpen = false;

      for (int i = lineIndex; i < controller.lineCount; i++) {
        final checkLine = controller.getLineText(i);
        for (int c = 0; c < checkLine.length; c++) {
          // Skip Jinja syntax
          if (c < checkLine.length - 1) {
            final twoChar = checkLine.substring(c, c + 2);
            if (twoChar == '{%' || twoChar == '{{' || twoChar == '{#') {
              // Skip to after the Jinja tag
              while (c < checkLine.length && checkLine[c] != '}') c++;
              continue;
            }
          }

          if (checkLine[c] == '{') {
            if (!foundOpen && i == lineIndex) foundOpen = true;
            braceCount++;
          } else if (checkLine[c] == '}') {
            braceCount--;
            if (braceCount == 0 && foundOpen && i > lineIndex) {
              return FoldRange(lineIndex, i);
            }
          }
        }
      }
    }

    // 4. Indentation-based folding: lines ending with ':'
    if (trimmed.endsWith(':')) {
      final startIndent = line.length - line.trimLeft().length;
      int endLine = lineIndex;

      for (int j = lineIndex + 1; j < controller.lineCount; j++) {
        final next = controller.getLineText(j);
        if (next.trim().isEmpty) continue;
        final nextIndent = next.length - next.trimLeft().length;
        if (nextIndent <= startIndent) break;
        endLine = j;
      }

      if (endLine > lineIndex) {
        return FoldRange(lineIndex, endLine);
      }
    }

    return null;
  }

  FoldRange? getOrComputeFoldRange(int lineIndex) {
    if (foldRangesNeedsClear) {
      foldRanges.removeWhere((f) => !f.isFolded);
      foldRangesNeedsClear = false;
    }

    try {
      return foldRanges.firstWhere((f) => f.startIndex == lineIndex);
    } catch (_) {
      final fold = computeFoldRangeForLine(lineIndex);
      if (fold != null) {
        foldRanges.add(fold);
        foldRanges.sort((a, b) => a.startIndex.compareTo(b.startIndex));
      }
      return fold;
    }
  }

  void toggleFold(FoldRange fold) {
    isFoldToggleInProgress = true;
    if (fold.isFolded) {
      unfoldWithChildren(fold);
    } else {
      foldWithChildren(fold);
    }

    controller.foldings = List.from(foldRanges);
    markNeedsLayout();
    markNeedsPaint();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      isFoldToggleInProgress = false;
    });
  }

  void toggleFoldAtLine(int lineNumber) {
    if (!enableFolding) return;
    if (lineNumber < 0 || lineNumber >= controller.lineCount) return;

    final foldRange = getFoldRangeAtLine(lineNumber);
    if (foldRange != null) {
      toggleFold(foldRange);
    }
  }

  void foldAllRanges() {
    if (!enableFolding) return;
    isFoldToggleInProgress = true;

    for (int i = 0; i < controller.lineCount; i++) {
      getOrComputeFoldRange(i);
    }

    for (final fold in foldRanges) {
      if (!fold.isFolded) {
        final isNested = foldRanges.any(
          (other) =>
              other != fold &&
              other.startIndex < fold.startIndex &&
              other.endIndex >= fold.endIndex,
        );
        if (!isNested) {
          foldWithChildren(fold);
        }
      }
    }

    controller.foldings = List.from(foldRanges);
    markNeedsLayout();
    markNeedsPaint();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isFoldToggleInProgress = false;
    });
  }

  void unfoldAllRanges() {
    if (!enableFolding) return;
    isFoldToggleInProgress = true;

    for (final fold in foldRanges) {
      if (fold.isFolded) {
        fold.isFolded = false;
        fold.clearOriginallyFoldedChildren();
      }
    }

    controller.foldings = List.from(foldRanges);
    markNeedsLayout();
    markNeedsPaint();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isFoldToggleInProgress = false;
    });
  }

  /// Finds vertical indicator line block for a given fold range
  /// Returns the block that starts at the fold start line (the block being folded)
  ({int startLine, int endLine, int indentLevel})?
  getIndicatorBlockForFoldRange(int foldStartLine, int foldEndLine) {
    final tabSize = 4;
    final hasActiveFolds = _foldRanges.any((f) => f.isFolded);

    // Start from the fold start line to find the block that begins there
    int i = foldStartLine;
    if (i < 0 || i >= controller.lineCount) return null;

    // Skip if line is folded (but we want to process the fold range itself)
    if (hasActiveFolds &&
        _isLineFolded(i) &&
        (i < foldStartLine || i > foldEndLine)) {
      return null;
    }

    String lineText;
    if (_lineTextCache.containsKey(i)) {
      lineText = _lineTextCache[i]!;
    } else {
      lineText = controller.getLineText(i);
      _lineTextCache[i] = lineText;
    }

    final trimmed = lineText.trimRight();
    final endsWithBracket =
        trimmed.endsWith('{') ||
        trimmed.endsWith('(') ||
        trimmed.endsWith('[') ||
        trimmed.endsWith(':');

    if (!endsWithBracket) return null;

    final leadingSpaces = lineText.length - lineText.trimLeft().length;
    final indentLevel = leadingSpaces ~/ tabSize;
    final lastChar = trimmed[trimmed.length - 1];
    int endLine = i + 1;

    if (lastChar == '{' || lastChar == '(' || lastChar == '[') {
      final lineStartOffset = controller.getLineStartOffset(i);
      final bracketPos = lineStartOffset + trimmed.length - 1;
      final matchPos = _findMatchingBracket(controller.text, bracketPos);

      if (matchPos != null) {
        endLine = controller.getLineAtOffset(matchPos) + 1;
      } else {
        return null;
      }
    } else {
      return null; // Skip colon-based blocks for JSON
    }

    if (endLine <= i + 1) return null;

    // Return the block that starts at the fold start line
    return (startLine: i, endLine: endLine, indentLevel: indentLevel);
  }

  void scrollToLine(int line) {
    if (line < 0 || line >= controller.lineCount) return;

    for (final fold in foldRanges) {
      if (fold.isFolded && line > fold.startIndex && line <= fold.endIndex) {
        unfoldWithChildren(fold);
        controller.foldings = List.from(foldRanges);
        markNeedsLayout();
        break;
      }
    }

    final hasActiveFolds = foldRanges.any((f) => f.isFolded);
    final targetY = getLineYOffset(line, hasActiveFolds);
    final viewportHeight = vscrollController.position.viewportDimension;
    final maxScroll = vscrollController.position.maxScrollExtent;
    double scrollTarget = targetY - (viewportHeight / 2) + (lineHeight0 / 2);

    scrollTarget = scrollTarget.clamp(0.0, maxScroll);

    vscrollController
        .animateTo(
          scrollTarget,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        )
        .then((_) {
          highlightedLine = line;
          lineHighlightController.forward(from: 0.0);
        });
  }

  void scrollToLine(int line) {
    if (line < 0 || line >= controller.lineCount) return;

    for (final fold in foldRanges) {
      if (fold.isFolded && line > fold.startIndex && line <= fold.endIndex) {
        unfoldWithChildren(fold);
        controller.foldings = List.from(foldRanges);
        markNeedsLayout();
        break;
      }
    }

    final hasActiveFolds = foldRanges.any((f) => f.isFolded);
    final targetY = getLineYOffset(line, hasActiveFolds);
    final viewportHeight = vscrollController.position.viewportDimension;
    final maxScroll = vscrollController.position.maxScrollExtent;
    double scrollTarget = targetY - (viewportHeight / 2) + (lineHeight0 / 2);

    scrollTarget = scrollTarget.clamp(0.0, maxScroll);

    vscrollController
        .animateTo(
          scrollTarget,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        )
        .then((_) {
          highlightedLine = line;
          lineHighlightController.forward(from: 0.0);
        });
  }

  /// Finds vertical indicator line block for a given fold range
  /// Returns the block that starts at the fold start line (the block being folded)
  ({int startLine, int endLine, int indentLevel})?
  getIndicatorBlockForFoldRange(int foldStartLine, int foldEndLine) {
    final tabSize = 4;
    final hasActiveFolds = foldRanges.any((f) => f.isFolded);

    // Start from the fold start line to find the block that begins there
    int i = foldStartLine;
    if (i < 0 || i >= controller.lineCount) return null;

    // Skip if line is folded (but we want to process the fold range itself)
    if (hasActiveFolds &&
        isLineFolded(i) &&
        (i < foldStartLine || i > foldEndLine)) {
      return null;
    }

    String lineText;
    if (lineTextCache.containsKey(i)) {
      lineText = lineTextCache[i]!;
    } else {
      lineText = controller.getLineText(i);
      lineTextCache[i] = lineText;
    }

    final trimmed = lineText.trimRight();
    final endsWithBracket =
        trimmed.endsWith('{') ||
        trimmed.endsWith('(') ||
        trimmed.endsWith('[') ||
        trimmed.endsWith(':');

    if (!endsWithBracket) return null;

    final leadingSpaces = lineText.length - lineText.trimLeft().length;
    final indentLevel = leadingSpaces ~/ tabSize;
    final lastChar = trimmed[trimmed.length - 1];
    int endLine = i + 1;

    if (lastChar == '{' || lastChar == '(' || lastChar == '[') {
      final lineStartOffset = controller.getLineStartOffset(i);
      final bracketPos = lineStartOffset + trimmed.length - 1;
      final matchPos = findMatchingBracket(controller.text, bracketPos);

      if (matchPos != null) {
        endLine = controller.getLineAtOffset(matchPos) + 1;
      } else {
        return null;
      }
    } else {
      return null; // Skip colon-based blocks for JSON
    }

    if (endLine <= i + 1) return null;

    // Return the block that starts at the fold start line
    return (startLine: i, endLine: endLine, indentLevel: indentLevel);
  }

  void foldWithChildren(FoldRange parentFold) {
    // For JSON blocks, check if we need to update the fold range boundaries
    FoldRange actualFold = parentFold;
    if (language.name?.toLowerCase() == 'json') {
      final startLine = parentFold.startIndex;
      final endLine = parentFold.endIndex;
      final indicatorBlock = getIndicatorBlockForFoldRange(startLine, endLine);

      if (indicatorBlock != null) {
        final blockStartLine = indicatorBlock.startLine;
        final blockEndLine = indicatorBlock.endLine;

        // If block boundaries differ from fold range boundaries, replace the fold range
        if (blockStartLine != startLine || blockEndLine != endLine) {
          // Find and replace the fold range in the list
          final index = foldRanges.indexOf(parentFold);
          if (index != -1) {
            // Preserve originally folded children before clearing
            final preservedChildren = List<FoldRange>.from(
              parentFold.originallyFoldedChildren,
            );
            actualFold = FoldRange(blockStartLine, blockEndLine);
            // Copy preserved children to new fold
            for (final child in preservedChildren) {
              actualFold.addOriginallyFoldedChild(child);
            }
            foldRanges[index] = actualFold;
            // Update controller foldings to reflect the change
            controller.foldings = List.from(foldRanges);
          }
        }
      }
    }

    actualFold.clearOriginallyFoldedChildren();

    for (final childFold in foldRanges) {
      if (childFold.isFolded &&
          childFold != actualFold &&
          childFold.startIndex > actualFold.startIndex &&
          childFold.endIndex <= actualFold.endIndex) {
        actualFold.addOriginallyFoldedChild(childFold);
        childFold.isFolded = false;
      }
    }

    actualFold.isFolded = true;

    // Debug print for JSON language
    if (language.name?.toLowerCase() == 'json') {
      final startLine = actualFold.startIndex;
      final endLine = actualFold.endIndex;

      // Get vertical indicator line block for this fold range
      final indicatorBlock = getIndicatorBlockForFoldRange(startLine, endLine);
      final indicatorLineNumbers = <int>[];
      if (indicatorBlock != null) {
        // Vertical line is drawn from block.startLine to block.endLine - 1 (0-indexed)
        for (
          int line = indicatorBlock.startLine;
          line < indicatorBlock.endLine;
          line++
        ) {
          indicatorLineNumbers.add(line);
        }
      }

      // Use indicatorBlock boundaries if available, otherwise use fold range boundaries
      final blockStartLine = indicatorBlock?.startLine ?? startLine;
      final blockEndLine = indicatorBlock?.endLine ?? endLine;

      // Calculate folded lines to match vertical indicator lines
      // Vertical indicator spans from blockStartLine to blockEndLine - 1 (0-indexed)
      // So folded lines should be from blockStartLine to blockEndLine - 1 (inclusive)
      final foldedLines = <String>[];
      final foldStart = blockStartLine;
      final foldEnd =
          blockEndLine - 1; // blockEndLine is exclusive for vertical indicator
      for (int i = foldStart; i <= foldEnd; i++) {
        if (i < controller.lineCount) {
          foldedLines.add(controller.getLineText(i));
        }
      }
    }
  }

  void unfoldWithChildren(FoldRange parentFold) {
    // Debug print for JSON language (before unfolding)
    if (language.name?.toLowerCase() == 'json' && parentFold.isFolded) {
      final startLine = parentFold.startIndex;
      final endLine = parentFold.endIndex;

      // Get vertical indicator line block for this fold range
      final indicatorBlock = getIndicatorBlockForFoldRange(startLine, endLine);
      final indicatorLineNumbers = <int>[];
      if (indicatorBlock != null) {
        // Vertical line is drawn from block.startLine to block.endLine - 1 (0-indexed)
        for (
          int line = indicatorBlock.startLine;
          line < indicatorBlock.endLine;
          line++
        ) {
          indicatorLineNumbers.add(line);
        }
      }

      // Use indicatorBlock boundaries if available, otherwise use fold range boundaries
      final blockStartLine = indicatorBlock?.startLine ?? startLine;
      final blockEndLine = indicatorBlock?.endLine ?? endLine;

      // Calculate folded lines to match vertical indicator lines
      // Vertical indicator spans from blockStartLine to blockEndLine - 1 (0-indexed)
      // So folded lines should be from blockStartLine to blockEndLine - 1 (inclusive)
      final foldedLines = <String>[];
      final foldStart = blockStartLine;
      final foldEnd =
          blockEndLine - 1; // blockEndLine is exclusive for vertical indicator
      for (int i = foldStart; i <= foldEnd; i++) {
        if (i < controller.lineCount) {
          foldedLines.add(controller.getLineText(i));
        }
      }
    }

    parentFold.isFolded = false;
    for (final childFold in parentFold.originallyFoldedChildren) {
      if (childFold.startIndex > parentFold.startIndex &&
          childFold.endIndex <= parentFold.endIndex) {
        childFold.isFolded = true;
      }
    }
    parentFold.clearOriginallyFoldedChildren();
  }

  bool isLineFolded(int lineIndex) {
    return foldRanges.any(
      (fold) =>
          fold.isFolded &&
          lineIndex > fold.startIndex &&
          lineIndex <= fold.endIndex,
    );
  }

  int? findMatchingBracket(String text, int pos) {
    const Map<String, String> pairs = {
      '(': ')',
      '{': '}',
      '[': ']',
      ')': '(',
      '}': '{',
      ']': '[',
    };
    const String openers = '({[';

    if (pos < 0 || pos >= text.length) return null;

    final char = text[pos];
    if (!pairs.containsKey(char)) return null;

    final match = pairs[char]!;
    final isForward = openers.contains(char);

    int depth = 0;
    if (isForward) {
      for (int i = pos + 1; i < text.length; i++) {
        if (text[i] == char) depth++;
        if (text[i] == match) {
          if (depth == 0) return i;
          depth--;
        }
      }
    } else {
      for (int i = pos - 1; i >= 0; i--) {
        if (text[i] == char) depth++;
        if (text[i] == match) {
          if (depth == 0) return i;
          depth--;
        }
      }
    }
    return null;
  }

  /// Finds the matching Jinja end tag for a given opening tag
  /// Returns the line number of the matching end tag, or null if not found
  int? findMatchingJinjaEndTag(int startLine, String tagName) {
    final foldableTags = {
      'if',
      'for',
      'block',
      'macro',
      'filter',
      'with',
      'set',
      'call',
      'raw',
    };

    if (!foldableTags.contains(tagName.toLowerCase())) {
      return null;
    }

    final tagNameLower = tagName.toLowerCase();
    int depth = 1;

    for (int i = startLine + 1; i < controller.lineCount; i++) {
      if (isLineFolded(i)) continue;

      final checkLine = controller.getLineText(i).toLowerCase();

      // Check for matching end tag
      final endTagRegex = RegExp(r'\{%\s*end' + tagNameLower + r'\s*%\}');
      if (endTagRegex.hasMatch(checkLine)) {
        depth--;
        if (depth == 0) {
          return i;
        }
      }

      // Check for nested opening tags of the same type
      final nestedTagRegex = RegExp(r'\{%\s*' + tagNameLower + r'\s*');
      if (nestedTagRegex.hasMatch(checkLine)) {
        depth++;
      }
    }

    return null;
  }

  /// Finds the matching HTML/XML end tag for a given opening tag
  /// Returns the line number of the matching end tag, or null if not found
  int? findMatchingHtmlEndTag(int startLine, String tagName) {
    final voidElements = {
      'area',
      'base',
      'br',
      'col',
      'embed',
      'hr',
      'img',
      'input',
      'link',
      'meta',
      'param',
      'source',
      'track',
      'wbr',
    };

    final tagNameLower = tagName.toLowerCase();

    // Skip void elements
    if (voidElements.contains(tagNameLower)) {
      return null;
    }

    int depth = 1;

    for (int i = startLine + 1; i < controller.lineCount; i++) {
      if (isLineFolded(i)) continue;

      final checkLine = controller.getLineText(i).trim();

      // Check if it's a self-closing tag
      final isSelfClosing = RegExp(r'/\s*>').hasMatch(checkLine);

      // Check for matching closing tag
      final closingTagRegex = RegExp(
        r'</\s*' + tagNameLower + r'\s*>',
        caseSensitive: false,
      );
      if (closingTagRegex.hasMatch(checkLine)) {
        depth--;
        if (depth == 0) {
          return i;
        }
      }

      // Check for nested opening tags of the same type
      final openingTagRegex = RegExp(
        r'<\s*' + tagNameLower + r'\s*[^>]*>',
        caseSensitive: false,
      );
      if (openingTagRegex.hasMatch(checkLine) && !isSelfClosing) {
        depth++;
      }
    }

    return null;
  }

  (int?, int?) getBracketPairAtCursor() {
    final cursorOffset = controller.selection.extentOffset;
    final text = controller.text;
    final textLength = text.length;

    if (cursorOffset < 0 || text.isEmpty) return (null, null);

    if (cursorOffset > 0 && cursorOffset <= textLength) {
      final before = text[cursorOffset - 1];
      if ('{}[]()'.contains(before)) {
        final match = findMatchingBracket(text, cursorOffset - 1);
        if (match != null) {
          return (cursorOffset - 1, match);
        }
      }
    }

    if (cursorOffset >= 0 && cursorOffset < textLength) {
      final after = text[cursorOffset];
      if ('{}[]()'.contains(after)) {
        final match = findMatchingBracket(text, cursorOffset);
        if (match != null) {
          return (cursorOffset, match);
        }
      }
    }

    return (null, null);
  }

  FoldRange? getFoldRangeAtLine(int lineIndex) {
    if (!enableFolding) return null;
    return getOrComputeFoldRange(lineIndex);
  }

  int findVisibleLineByYPosition(double y) {
    final lineCount = controller.lineCount;
    if (lineCount == 0) return 0;

    final hasActiveFolds = foldRanges.any((f) => f.isFolded);

    if (!lineWrap && !hasActiveFolds) {
      return (y / lineHeight0).floor().clamp(0, lineCount - 1);
    }

    double currentY = 0;
    for (int i = 0; i < lineCount; i++) {
      if (hasActiveFolds && isLineFolded(i)) continue;
      final lineHeight = lineWrap ? getWrappedLineHeight(i) : lineHeight0;
      if (currentY + lineHeight > y) {
        return i;
      }
      currentY += lineHeight;
    }
    return lineCount - 1;
  }

  ({int lineIndex, int columnIndex, Offset offset, double height})
  getCaretInfo() {
    final lineCount = controller.lineCount;
    if (lineCount == 0) {
      return (
        lineIndex: 0,
        columnIndex: 0,
        offset: Offset.zero,
        height: lineHeight0,
      );
    }

    final hasActiveFolds = foldRanges.any((f) => f.isFolded);

    if (controller.isBufferActive) {
      final lineIndex = controller.bufferLineIndex!;
      final columnIndex = controller.bufferCursorColumn;
      final lineY = getLineYOffset(lineIndex, hasActiveFolds);
      final lineText = controller.bufferLineText ?? '';
      final para = buildHighlightedParagraph(
        lineIndex,
        lineText,
        width: lineWrap ? wrapWidth : null,
      );
      final clampedCol = columnIndex.clamp(0, lineText.length);

      double caretX = 0.0;
      double caretYInLine = 0.0;
      if (clampedCol > 0) {
        final boxes = para.getBoxesForRange(0, clampedCol);
        if (boxes.isNotEmpty) {
          caretX = boxes.last.right;
          caretYInLine = boxes.last.top;
        }
      }

      final ghostOffset = getGhostTextVisualOffset(lineIndex);

      return (
        lineIndex: lineIndex,
        columnIndex: columnIndex,
        offset: Offset(caretX, lineY + caretYInLine + ghostOffset),
        height: lineHeight0,
      );
    }

    final cursorOffset = controller.selection.extentOffset;

    int lineIndex;
    int lineStartOffset;
    if (cursorOffset == cachedCaretOffset) {
      lineIndex = cachedCaretLine;
      lineStartOffset = cachedCaretLineStart;
    } else {
      lineIndex = controller.getLineAtOffset(cursorOffset);
      lineStartOffset = controller.getLineStartOffset(lineIndex);
      cachedCaretOffset = cursorOffset;
      cachedCaretLine = lineIndex;
      cachedCaretLineStart = lineStartOffset;
    }

    final columnIndex = cursorOffset - lineStartOffset;
    final lineY = getLineYOffset(lineIndex, hasActiveFolds);

    final lineText = controller.getLineText(lineIndex);

    ui.Paragraph para;
    if (paragraphCache.containsKey(lineIndex) &&
        lineTextCache[lineIndex] == lineText) {
      para = paragraphCache[lineIndex]!;
    } else {
      para = buildParagraph(lineText, width: lineWrap ? wrapWidth : null);
    }

    final clampedCol = columnIndex.clamp(0, lineText.length);
    double caretX = 0.0;
    double caretYInLine = 0.0;
    if (clampedCol > 0) {
      final boxes = para.getBoxesForRange(0, clampedCol);
      if (boxes.isNotEmpty) {
        caretX = boxes.last.right;
        caretYInLine = boxes.last.top;
      }
    }

    final ghostOffset = getGhostTextVisualOffset(lineIndex);

    return (
      lineIndex: lineIndex,
      columnIndex: columnIndex,
      offset: Offset(caretX, lineY + caretYInLine + ghostOffset),
      height: lineHeight0,
    );
  }

  int getTextOffsetFromPosition(Offset position) {
    final lineCount = controller.lineCount;
    if (lineCount == 0) return 0;

    final tappedLineIndex = findVisibleLineByYPosition(position.dy);

    String lineText;
    if (lineTextCache.containsKey(tappedLineIndex)) {
      lineText = lineTextCache[tappedLineIndex]!;
    } else {
      lineText = controller.getLineText(tappedLineIndex);
      lineTextCache[tappedLineIndex] = lineText;
      paragraphCache.remove(tappedLineIndex);
    }

    ui.Paragraph para;
    if (paragraphCache.containsKey(tappedLineIndex)) {
      para = paragraphCache[tappedLineIndex]!;
    } else {
      para = buildHighlightedParagraph(
        tappedLineIndex,
        lineText,
        width: lineWrap ? wrapWidth : null,
      );
      paragraphCache[tappedLineIndex] = para;
    }

    final localX = position.dx;

    final hasActiveFolds = foldRanges.any((f) => f.isFolded);
    final lineStartY = getLineYOffset(tappedLineIndex, hasActiveFolds);
    final localY = position.dy - lineStartY;

    final textPosition = para.getPositionForOffset(
      Offset(localX, localY.clamp(0, para.height)),
    );
    final columnIndex = textPosition.offset.clamp(0, lineText.length);

    final lineStartOffset = controller.getLineStartOffset(tappedLineIndex);
    final absoluteOffset = lineStartOffset + columnIndex;

    return absoluteOffset.clamp(0, controller.length);
  }

  double getLineWidth(int lineIndex) {
    final lineText = controller.getLineText(lineIndex);
    final cachedText = lineTextCache[lineIndex];

    if (cachedText == lineText && lineWidthCache.containsKey(lineIndex)) {
      return lineWidthCache[lineIndex]!;
    }

    final para = buildParagraph(lineText);
    final width = para.maxIntrinsicWidth;
    lineTextCache[lineIndex] = lineText;
    lineWidthCache[lineIndex] = width;
    return width;
  }

  @override
  void detach() {
    resizeTimer?.cancel();
    layoutDebounceTimer?.cancel();
    super.detach();
  }

  double get ghostTextExtraHeight => ghostTextLineCount * lineHeight0;

  double getGhostTextVisualOffset(int lineIndex) {
    if (ghostTextAnchorLine == null || ghostTextLineCount <= 0) return 0;
    if (lineIndex <= ghostTextAnchorLine!) return 0;
    return ghostTextExtraHeight;
  }

  /// Calculates the width of a single character for ruler positioning.
  ///
  /// Uses TextPainter to measure a sample character (typically 'M' for monospace
  /// or 'W' for variable-width fonts) and caches the result.
  double getCharacterWidth() {
    if (cachedCharacterWidth != null) {
      return cachedCharacterWidth!;
    }

    final fontSize = textStyle.fontSize ?? 14.0;
    final fontFamily = textStyle.fontFamily;

    // Use TextPainter to measure character width accurately
    final textPainter = TextPainter(
      text: TextSpan(
        text: 'M', // 'M' is typically the widest character in monospace fonts
        style: TextStyle(fontSize: fontSize, fontFamily: fontFamily),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    cachedCharacterWidth = textPainter.width;
    return cachedCharacterWidth!;
  }

  @override
  void performLayout() {
    final lineCount = controller.lineCount;

    if (lineCount != cachedLineCount) {
      lineWidthCache.removeWhere((key, _) => key >= lineCount);
      lineTextCache.removeWhere((key, _) => key >= lineCount);
      lineHeightCache.removeWhere((key, _) => key >= lineCount);
    }

    if (isDeferringLayout && hasCachedHeight) {
      final contentHeight =
          cachedTotalHeight +
          (innerPadding.vertical ?? 0) +
          ghostTextExtraHeight;
      final computedWidth = lineWrap
          ? (constraints.maxWidth.isFinite
                ? constraints.maxWidth
                : MediaQuery.of(context).size.width)
          : longLineWidth + (innerPadding.horizontal ?? 0) + gutterWidth;
      final minWidth = lineWrap ? 0.0 : MediaQuery.of(context).size.width;
      final contentWidth = max(computedWidth, minWidth);
      size = constraints.constrain(Size(contentWidth, contentHeight));
      return;
    }

    final hasActiveFolds = foldRanges.any((f) => f.isFolded);
    double visibleHeight = 0;
    double maxLineWidth = longLineWidth;

    if (lineWrap) {
      final viewportWidth = constraints.maxWidth.isFinite
          ? constraints.maxWidth
          : MediaQuery.of(context).size.width;
      final newWrapWidth =
          viewportWidth - gutterWidth - (innerPadding.horizontal ?? 0);
      final clampedWrapWidth = newWrapWidth < 100 ? 100.0 : newWrapWidth;

      if ((wrapWidth - clampedWrapWidth).abs() > 1) {
        resizeTimer?.cancel();
        resizeTimer = Timer(const Duration(milliseconds: 150), () {
          wrapWidth = clampedWrapWidth;
          paragraphCache.clear();
          lineHeightCache.clear();
          markNeedsLayout();
        });
        if (wrapWidth == double.infinity) {
          wrapWidth = clampedWrapWidth;
        }
      }

      if (hasActiveFolds) {
        for (int i = 0; i < lineCount; i++) {
          if (isLineFolded(i)) continue;
          visibleHeight += getWrappedLineHeight(i);
        }
      } else {
        double cachedHeight = 0;
        int cachedCount = 0;
        for (final entry in lineHeightCache.entries) {
          if (entry.key < lineCount) {
            cachedHeight += entry.value;
            cachedCount++;
          }
        }
        final uncachedCount = lineCount - cachedCount;
        final avgHeight = cachedCount > 0
            ? cachedHeight / cachedCount
            : lineHeight0;
        visibleHeight = cachedHeight + (uncachedCount * avgHeight);
      }
    } else {
      wrapWidth = double.infinity;

      if (hasActiveFolds) {
        int visibleLines = 0;
        for (int i = 0; i < lineCount; i++) {
          if (!isLineFolded(i)) visibleLines++;
        }
        visibleHeight = visibleLines * lineHeight0;
      } else {
        visibleHeight = lineCount * lineHeight0;
      }

      if (longLineWidth == 0 && lineCount > 0) {
        final viewTop = vscrollController.hasClients
            ? vscrollController.offset
            : 0.0;
        final viewBottom =
            viewTop +
            (vscrollController.hasClients
                ? vscrollController.position.viewportDimension
                : MediaQuery.of(context).size.height);
        final firstVisible = (viewTop / lineHeight0).floor().clamp(
          0,
          lineCount - 1,
        );
        final lastVisible = (viewBottom / lineHeight0).ceil().clamp(
          0,
          lineCount - 1,
        );
        final buffer = 50;
        final start = (firstVisible - buffer).clamp(0, lineCount - 1);
        final end = (lastVisible + buffer).clamp(0, lineCount - 1);

        for (int i = start; i <= end; i++) {
          final width = getLineWidth(i);
          if (width > maxLineWidth) {
            maxLineWidth = width;
          }
        }
      }
    }

    longLineWidth = maxLineWidth;
    cachedTotalHeight = visibleHeight;
    hasCachedHeight = true;
    previousLineCount = lineCount;

    final contentHeight =
        visibleHeight + (innerPadding.vertical ?? 0) + ghostTextExtraHeight;
    final computedWidth = lineWrap
        ? (constraints.maxWidth.isFinite
              ? constraints.maxWidth
              : MediaQuery.of(context).size.width)
        : maxLineWidth + (innerPadding.horizontal ?? 0) + gutterWidth;

    final minWidth = lineWrap ? 0.0 : MediaQuery.of(context).size.width;
    final contentWidth = max(computedWidth, minWidth);

    size = constraints.constrain(Size(contentWidth, contentHeight));
  }

  double getWrappedLineHeight(int lineIndex) {
    if (lineHeightCache.containsKey(lineIndex)) {
      return lineHeightCache[lineIndex]!;
    }

    final lineText = controller.getLineText(lineIndex);

    final para = buildHighlightedParagraph(
      lineIndex,
      lineText,
      width: wrapWidth,
    );
    final height = para.height;

    lineHeightCache[lineIndex] = height;
    paragraphCache[lineIndex] = para;
    lineTextCache[lineIndex] = lineText;

    return height;
  }

  double getLineYOffset(int targetLine, bool hasActiveFolds) {
    if (!lineWrap && !hasActiveFolds) {
      return targetLine * lineHeight0;
    }

    double y = 0;
    for (int i = 0; i < targetLine; i++) {
      if (hasActiveFolds && isLineFolded(i)) continue;
      y += lineWrap ? getWrappedLineHeight(i) : lineHeight0;
    }
    return y;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    checkDocumentVersionAndClearCache();

    final canvas = context.canvas;
    final viewTop = vscrollController.offset;
    final viewBottom = viewTop + vscrollController.position.viewportDimension;
    final lineCount = controller.lineCount;
    final bufferActive = controller.isBufferActive;
    final bufferLineIndex = controller.bufferLineIndex;
    final bufferLineText = controller.bufferLineText;
    final bgColor = editorTheme['root']?.backgroundColor ?? Colors.white;
    final textColor = textStyle.backgroundColor ?? editorTheme['root']!.color!;

    canvas.save();

    canvas.drawPaint(
      Paint()
        ..color = bgColor
        ..style = PaintingStyle.fill,
    );

    final hasActiveFolds = foldRanges.any((f) => f.isFolded);

    int firstVisibleLine;
    int lastVisibleLine;
    double firstVisibleLineY;

    if (!lineWrap && !hasActiveFolds) {
      firstVisibleLine = (viewTop / lineHeight0).floor().clamp(
        0,
        lineCount - 1,
      );
      lastVisibleLine = (viewBottom / lineHeight0).ceil().clamp(
        0,
        lineCount - 1,
      );
      firstVisibleLineY = firstVisibleLine * lineHeight0;
    } else {
      double currentY = 0;
      firstVisibleLine = 0;
      lastVisibleLine = lineCount - 1;
      firstVisibleLineY = 0;

      for (int i = 0; i < lineCount; i++) {
        if (hasActiveFolds && isLineFolded(i)) continue;
        final lineHeight = lineWrap ? getWrappedLineHeight(i) : lineHeight0;
        if (currentY + lineHeight > viewTop) {
          firstVisibleLine = i;
          firstVisibleLineY = currentY;
          break;
        }
        currentY += lineHeight;
      }

      currentY = firstVisibleLineY;
      for (int i = firstVisibleLine; i < lineCount; i++) {
        if (hasActiveFolds && isLineFolded(i)) continue;
        final lineHeight = lineWrap ? getWrappedLineHeight(i) : lineHeight0;
        currentY += lineHeight;
        if (currentY >= viewBottom) {
          lastVisibleLine = i;
          break;
        }
      }
    }

    _drawSearchHighlights(
      canvas,
      offset,
      firstVisibleLine,
      lastVisibleLine,
      firstVisibleLineY,
      hasActiveFolds,
    );

    _drawLineDecorations(
      canvas,
      offset,
      firstVisibleLine,
      lastVisibleLine,
      firstVisibleLineY,
      hasActiveFolds,
    );

    _drawLineHighlight(
      canvas,
      offset,
      firstVisibleLine,
      lastVisibleLine,
      firstVisibleLineY,
      hasActiveFolds,
    );

    _drawFoldedLineHighlights(
      canvas,
      offset,
      firstVisibleLine,
      lastVisibleLine,
      firstVisibleLineY,
      hasActiveFolds,
    );

    _drawSelection(
      canvas,
      offset,
      firstVisibleLine,
      lastVisibleLine,
      firstVisibleLineY,
      hasActiveFolds,
    );

    if (enableGuideLines && (lastVisibleLine - firstVisibleLine) < 200) {
      _drawIndentGuides(
        canvas,
        offset,
        firstVisibleLine,
        lastVisibleLine,
        firstVisibleLineY,
        hasActiveFolds,
        textColor,
      );
    }

    // Draw rulers (vertical lines at specific column positions)
    if (rulers != null && rulers!.isNotEmpty) {
      _drawRulers(
        canvas,
        offset,
        firstVisibleLine,
        lastVisibleLine,
        firstVisibleLineY,
        hasActiveFolds,
        textColor,
      );
    }

    double currentY = firstVisibleLineY;
    for (int i = firstVisibleLine; i <= lastVisibleLine && i < lineCount; i++) {
      if (hasActiveFolds && isLineFolded(i)) continue;

      final contentTop = currentY;
      final lineHeight = lineWrap ? getWrappedLineHeight(i) : lineHeight0;
      final visualYOffset = getGhostTextVisualOffset(i);

      ui.Paragraph paragraph;
      String lineText;

      if (bufferActive && i == bufferLineIndex && bufferLineText != null) {
        lineText = bufferLineText;
        paragraph = buildHighlightedParagraph(
          i,
          bufferLineText,
          width: lineWrap ? wrapWidth : null,
        );
      } else {
        if (lineTextCache.containsKey(i)) {
          lineText = lineTextCache[i]!;
        } else {
          lineText = controller.getLineText(i);
          lineTextCache[i] = lineText;
        }

        if (paragraphCache.containsKey(i)) {
          paragraph = paragraphCache[i]!;
        } else {
          paragraph = buildHighlightedParagraph(
            i,
            lineText,
            width: lineWrap ? wrapWidth : null,
          );
          paragraphCache[i] = paragraph;

          if (lineWrap) {
            lineHeightCache[i] = paragraph.height;
          }
        }
      }

      final foldRange = getFoldRangeAtLine(i);
      final isFoldStart = foldRange != null;

      canvas.drawParagraph(
        paragraph,
        offset +
            Offset(
              gutterWidth +
                  (innerPadding?.left ?? 0) -
                  (lineWrap ? 0 : hscrollController.offset),
              (innerPadding?.top ?? 0) +
                  contentTop +
                  visualYOffset -
                  vscrollController.offset,
            ),
      );

      if (isFoldStart && foldRange.isFolded) {
        final foldIndicator = buildParagraph(' ...');
        final paraWidth = paragraph.longestLine;
        canvas.drawParagraph(
          foldIndicator,
          offset +
              Offset(
                gutterWidth +
                    (innerPadding?.left ?? 0) +
                    paraWidth -
                    (lineWrap ? 0 : hscrollController.offset),
                (innerPadding?.top ?? 0) +
                    contentTop +
                    visualYOffset -
                    vscrollController.offset,
              ),
        );
      }

      currentY += lineHeight;
    }

    _drawDiagnostics(
      canvas,
      offset,
      firstVisibleLine,
      lastVisibleLine,
      firstVisibleLineY,
      hasActiveFolds,
    );

    if (controller.ghostText != null) {
      _drawGhostText(
        canvas,
        offset,
        firstVisibleLine,
        lastVisibleLine,
        firstVisibleLineY,
        hasActiveFolds,
      );
    } else if (aiResponse != null && aiResponse!.isNotEmpty) {
      _drawAiGhostText(
        canvas,
        offset,
        firstVisibleLine,
        lastVisibleLine,
        firstVisibleLineY,
        hasActiveFolds,
      );
    }

    if (enableGutter) {
      _drawGutter(
        canvas,
        offset,
        viewTop,
        viewBottom,
        lineCount,
        bgColor,
        textStyle,
      );
    }

    if (focusNode.hasFocus) {
      _drawBracketHighlight(
        canvas,
        offset,
        viewTop,
        viewBottom,
        firstVisibleLine,
        lastVisibleLine,
        firstVisibleLineY,
        hasActiveFolds,
        textColor,
      );
    }

    if (focusNode.hasFocus && caretBlinkController.value > 0.5) {
      final caretInfo = getCaretInfo();

      final caretX =
          gutterWidth +
          (innerPadding?.left ?? 0) +
          caretInfo.offset.dx -
          (lineWrap ? 0 : hscrollController.offset);
      final caretScreenY =
          (innerPadding?.top ?? 0) +
          caretInfo.offset.dy -
          vscrollController.offset;

      canvas.drawRect(
        Rect.fromLTWH(caretX, caretScreenY, 1.5, caretInfo.height),
        caretPainter,
      );
    }

    if (isMobile) {
      final selection = controller.selection;
      final handleColor = selectionStyle.cursorBubbleColor;
      final handleRadius = (lineHeight0 / 2).clamp(6.0, 12.0);

      final handlePaint = Paint()
        ..color = handleColor
        ..style = PaintingStyle.fill;

      if (selection.isCollapsed) {
        if (showBubble || selectionActive) {
          final caretInfo = getCaretInfo();
          final handleSize = caretInfo.height;

          final handleX =
              offset.dx +
              gutterWidth +
              (innerPadding?.left ?? 0) +
              caretInfo.offset.dx -
              (lineWrap ? 0 : hscrollController.offset);
          final handleY =
              offset.dy +
              (innerPadding?.top ?? 0) +
              caretInfo.offset.dy +
              lineHeight0 -
              vscrollController.offset;

          canvas.save();
          canvas.translate(handleX, handleY);
          canvas.rotate(pi / 4);
          canvas.drawRRect(
            RRect.fromRectAndCorners(
              Rect.fromCenter(
                center: Offset((handleSize / 1.5), (handleSize / 1.5)),
                width: handleSize * 1.3,
                height: handleSize * 1.3,
              ),
              topRight: Radius.circular(25),
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
            handlePaint,
          );
          canvas.restore();

          normalHandle = Rect.fromCenter(
            center: Offset(handleX, handleY + handleRadius),
            width: handleRadius * 2,
            height: handleRadius * 2,
          );

          if (draggingCHandle) {
            selectionActive = selectionActiveNotifier.value = true;
            final caretLineIndex = controller.getLineAtOffset(
              controller.selection.baseOffset,
            );
            final lineText =
                lineTextCache[caretLineIndex] ??
                controller.getLineText(caretLineIndex);
            final lineStartOffset = controller.getLineStartOffset(
              caretLineIndex,
            );
            final caretInLine =
                controller.selection.baseOffset - lineStartOffset;

            final previewStart = caretInLine.clamp(0, lineText.length);
            final previewEnd = (caretInLine + 10).clamp(0, lineText.length);
            final previewText = lineText.substring(
              max(0, previewStart - 10),
              min(lineText.length, previewEnd),
            );

            ui.Paragraph zoomParagraph;
            if (cachedMagnifiedParagraph != null &&
                cachedMagnifiedLine == caretLineIndex &&
                cachedMagnifiedOffset == caretInLine) {
              zoomParagraph = cachedMagnifiedParagraph!;
            } else {
              final zoomFontSize = (textStyle?.fontSize ?? 14) * 1.5;
              final fontFamily = textStyle?.fontFamily;
              zoomParagraph = syntaxHighlighter.buildHighlightedParagraph(
                caretLineIndex,
                previewText,
                paragraphStyle,
                zoomFontSize,
                fontFamily,
              );
              cachedMagnifiedParagraph = zoomParagraph;
              cachedMagnifiedLine = caretLineIndex;
              cachedMagnifiedOffset = caretInLine;
            }

            final zoomBoxWidth = min(
              zoomParagraph.longestLine + 16,
              size.width * 0.6,
            );
            final zoomBoxHeight = zoomParagraph.height + 12;
            final zoomBoxX = (handleX - zoomBoxWidth / 2).clamp(
              0.0,
              size.width - zoomBoxWidth,
            );
            final zoomBoxY = handleY - zoomBoxHeight - 18;

            final rrect = RRect.fromRectAndRadius(
              Rect.fromLTWH(zoomBoxX, zoomBoxY, zoomBoxWidth, zoomBoxHeight),
              Radius.circular(12),
            );

            canvas.drawRRect(
              rrect,
              Paint()
                ..color = editorTheme['root']?.backgroundColor ?? Colors.black
                ..style = PaintingStyle.fill,
            );

            canvas.drawRRect(
              rrect,
              Paint()
                ..color = editorTheme['root']?.color ?? Colors.grey
                ..strokeWidth = 0.5
                ..style = PaintingStyle.stroke,
            );

            canvas.save();
            canvas.clipRect(rrect.outerRect);
            canvas.drawParagraph(
              zoomParagraph,
              Offset(zoomBoxX + 8, zoomBoxY + 6),
            );
            canvas.restore();
          }
        }
      } else {
        if (startHandleRect != null) {
          canvas.drawRRect(
            RRect.fromRectAndCorners(
              startHandleRect!,
              topLeft: Radius.circular(25),
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
            handlePaint,
          );
        }

        if (endHandleRect != null) {
          canvas.drawRRect(
            RRect.fromRectAndCorners(
              endHandleRect!,
              topRight: Radius.circular(25),
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
            handlePaint,
          );
        }
      }
    }

    canvas.restore();
  }

  void _drawGutter(
    Canvas canvas,
    Offset offset,
    double viewTop,
    double viewBottom,
    int lineCount,
    Color bgColor,
    TextStyle? gutterTextStyle,
  ) {
    final viewportHeight = vscrollController.position.viewportDimension;

    final gutterBgColor = gutterStyle.backgroundColor ?? bgColor;
    canvas.drawRect(
      Rect.fromLTWH(offset.dx, offset.dy, gutterWidth, viewportHeight),
      Paint()..color = gutterBgColor,
    );

    if (enableGutterDivider) {
      final dividerPaint = Paint()
        ..color = (editorTheme['root']?.color ?? Colors.grey).withAlpha(150)
        ..strokeWidth = 1;
      canvas.drawLine(
        Offset(offset.dx + gutterWidth - 1, offset.dy),
        Offset(offset.dx + gutterWidth - 1, offset.dy + viewportHeight),
        dividerPaint,
      );
    }

    final baseLineNumberStyle = (() {
      if (gutterStyle.lineNumberStyle != null) {
        if (gutterStyle.lineNumberStyle!.fontSize == null) {
          return gutterStyle.lineNumberStyle!.copyWith(
            fontSize: gutterTextStyle?.fontSize,
          );
        }
        return gutterStyle.lineNumberStyle;
      } else {
        if (gutterTextStyle == null) {
          return editorTheme['root'];
        } else if (gutterTextStyle.color == null) {
          return gutterTextStyle.copyWith(color: editorTheme['root']?.color);
        } else {
          return gutterTextStyle;
        }
      }
    })();

    final hasActiveFolds = foldRanges.any((f) => f.isFolded);
    final cursorOffset = controller.selection.extentOffset;
    final currentLine = controller.getLineAtOffset(cursorOffset);
    final selection = controller.selection;
    int? selectionStartLine;
    int? selectionEndLine;
    if (selection.start != selection.end) {
      selectionStartLine = controller.getLineAtOffset(selection.start);
      selectionEndLine = controller.getLineAtOffset(selection.end);

      if (selectionStartLine > selectionEndLine) {
        final temp = selectionStartLine;
        selectionStartLine = selectionEndLine;
        selectionEndLine = temp;
      }
    }

    final Map<int, int> lineSeverityMap = {};
    for (final diagnostic in diagnostics) {
      final startLine = diagnostic.range['start']?['line'] as int?;
      final endLine = diagnostic.range['end']?['line'] as int?;
      if (startLine != null) {
        final severity = diagnostic.severity;
        if (severity == 1 || severity == 2) {
          final rangeEnd = endLine ?? startLine;
          for (int line = startLine; line <= rangeEnd; line++) {
            final existing = lineSeverityMap[line];
            if (existing == null || severity < existing) {
              lineSeverityMap[line] = severity;
            }
          }
        }
      }
    }

    final activeLineColor =
        gutterStyle.activeLineNumberColor ??
        (baseLineNumberStyle?.color ?? Colors.white);
    final inactiveLineColor =
        gutterStyle.inactiveLineNumberColor ??
        (baseLineNumberStyle?.color?.withAlpha(120) ?? Colors.grey);
    final errorColor = gutterStyle.errorLineNumberColor;
    final warningColor = gutterStyle.warningLineNumberColor;

    int firstVisibleLine;
    double firstVisibleLineY;

    if (!lineWrap && !hasActiveFolds) {
      firstVisibleLine = (viewTop / lineHeight0).floor().clamp(
        0,
        lineCount - 1,
      );
      firstVisibleLineY = firstVisibleLine * lineHeight0;
    } else {
      double currentY = 0;
      firstVisibleLine = 0;
      firstVisibleLineY = 0;

      for (int i = 0; i < lineCount; i++) {
        if (hasActiveFolds && isLineFolded(i)) continue;
        final lineHeight = lineWrap ? getWrappedLineHeight(i) : lineHeight0;
        if (currentY + lineHeight > viewTop) {
          firstVisibleLine = i;
          firstVisibleLineY = currentY;
          break;
        }
        currentY += lineHeight;
      }
    }

    actionBulbRects.clear();

    double currentY = firstVisibleLineY;
    for (int i = firstVisibleLine; i < lineCount; i++) {
      if (hasActiveFolds && isLineFolded(i)) continue;

      final contentTop = currentY;
      final lineHeight = lineWrap ? getWrappedLineHeight(i) : lineHeight0;

      final visualYOffset = getGhostTextVisualOffset(i);

      if (contentTop + visualYOffset > viewBottom) break;

      if (contentTop + visualYOffset + lineHeight >= viewTop) {
        drawGutterDecorations(
          canvas,
          offset,
          i,
          contentTop + visualYOffset,
          lineHeight,
        );

        Color lineNumberColor;
        final severity = lineSeverityMap[i];
        if (severity == 1) {
          lineNumberColor = errorColor;
        } else if (severity == 2) {
          lineNumberColor = warningColor;
        } else if (i == currentLine) {
          lineNumberColor = activeLineColor;
        } else if (selectionStartLine != null &&
            selectionEndLine != null &&
            i >= selectionStartLine &&
            i <= selectionEndLine) {
          lineNumberColor = activeLineColor;
        } else {
          lineNumberColor = inactiveLineColor;
        }

        final lineNumberStyle = baseLineNumberStyle!.copyWith(
          color: lineNumberColor,
        );

        // Draw breakpoint indicator if enabled and breakpoint exists for this line
        final fontSize = textStyle?.fontSize ?? 14.0;
        final breakpointColumnWidth = (gutterStyle.showBreakpoints)
            ? fontSize * 1.5
            : 0;
        if (gutterStyle.showBreakpoints &&
            controller.breakpoints.contains(i + 1)) {
          final isHovered = hoveredBreakpointLine == i + 1;
          final breakpointPaint = Paint()
            ..color = gutterStyle.breakpointColor
            ..style = PaintingStyle.fill;
          final breakpointRadius = 4.0;
          final breakpointCenterX = offset.dx + breakpointColumnWidth / 2;
          final breakpointCenterY =
              offset.dy +
              (innerPadding.top ?? 0) +
              contentTop -
              vscrollController.offset +
              lineHeight / 2;

          // Draw hover highlight (semi-transparent circle) if hovering
          if (isHovered) {
            final hoverPaint = Paint()
              ..color = gutterStyle.breakpointColor.withValues(alpha: 0.3)
              ..style = PaintingStyle.fill;
            canvas.drawCircle(
              Offset(breakpointCenterX, breakpointCenterY),
              breakpointRadius + 2,
              hoverPaint,
            );
          }

          canvas.drawCircle(
            Offset(breakpointCenterX, breakpointCenterY),
            breakpointRadius,
            breakpointPaint,
          );
        } else if (gutterStyle.showBreakpoints &&
            hoveredBreakpointLine == i + 1) {
          // Show semi-transparent breakpoint on hover even if not set
          final breakpointRadius = 4.0;
          final breakpointCenterX = offset.dx + breakpointColumnWidth / 2;
          final breakpointCenterY =
              offset.dy +
              (innerPadding.top ?? 0) +
              contentTop -
              vscrollController.offset +
              lineHeight / 2;
          final hoverPaint = Paint()
            ..color = gutterStyle.breakpointColor.withOpacity(0.5)
            ..style = PaintingStyle.fill;
          canvas.drawCircle(
            Offset(breakpointCenterX, breakpointCenterY),
            breakpointRadius,
            hoverPaint,
          );
        }

        final lineNumPara = _buildLineNumberParagraph(
          (i + 1).toString(),
          lineNumberStyle,
        );
        final numWidth = lineNumPara.longestLine;

        // Adjust line number position to account for breakpoint column
        final lineNumberXOffset =
            breakpointColumnWidth +
            ((gutterWidth - breakpointColumnWidth - numWidth) / 2) -
            (enableFolding ? (lineNumberStyle.fontSize ?? 14) / 2 : 0);

        canvas.drawParagraph(
          lineNumPara,
          offset +
              Offset(
                lineNumberXOffset,
                (innerPadding.top ?? 0) +
                    contentTop +
                    visualYOffset -
                    vscrollController.offset,
              ),
        );

        if (lspActionNotifier.value != null && lspConfig != null) {
          final actions = lspActionNotifier.value!.cast<Map<String, dynamic>>();
          if (actions.any((item) {
            try {
              return (item['arguments'][0]['range']['start']['line'] as int) ==
                  i;
            } on NoSuchMethodError {
              try {
                final fileUri = Uri.file(filePath!).toString();
                return (item['edit']['changes'][fileUri][0]['range']['start']['line']
                        as int) ==
                    i;
              } catch (e) {
                return false;
              }
            } catch (e) {
              return false;
            }
          })) {
            final icon = Icons.lightbulb_outline;
            final actionBulbPainter = TextPainter(
              text: TextSpan(
                text: String.fromCharCode(icon.codePoint),
                style: TextStyle(
                  fontSize: textStyle.fontSize ?? 14,
                  color: Colors.yellowAccent,
                  fontFamily: icon.fontFamily,
                  package: icon.fontPackage,
                ),
              ),
              textDirection: TextDirection.ltr,
            );
            actionBulbPainter.layout();

            final bulbX = offset.dx + 4;
            final bulbY =
                offset.dy +
                (innerPadding.top ?? 0) +
                contentTop +
                visualYOffset -
                vscrollController.offset +
                (lineHeight0 - actionBulbPainter.height) / 2;

            actionBulbRects[i] = Rect.fromLTWH(
              bulbX,
              bulbY,
              actionBulbPainter.width,
              actionBulbPainter.height,
            );

            actionBulbPainter.paint(canvas, Offset(bulbX, bulbY));
          }
        }

        if (enableFolding) {
          final foldRange = getFoldRangeAtLine(i);
          if (foldRange != null) {
            final isInsideFoldedParent = foldRanges.any(
              (parent) =>
                  parent.isFolded &&
                  parent.startIndex < i &&
                  parent.endIndex >= i,
            );

            if (!isInsideFoldedParent) {
              final icon = foldRange.isFolded
                  ? gutterStyle.foldedIcon
                  : gutterStyle.unfoldedIcon;
              final iconColor = foldRange.isFolded
                  ? (gutterStyle.foldedIconColor ?? lineNumberStyle.color)
                  : (gutterStyle.unfoldedIconColor ?? lineNumberStyle.color);

              _drawFoldIcon(
                canvas,
                offset,
                icon,
                iconColor!,
                lineNumberStyle.fontSize ?? 14,
                contentTop + visualYOffset - vscrollController.offset,
              );
            }
          }
        }
      }

      currentY += lineHeight;
    }
  }

  ui.Paragraph _buildLineNumberParagraph(String text, TextStyle style) {
    final builder =
        ui.ParagraphBuilder(
            ui.ParagraphStyle(
              fontSize: style.fontSize,
              fontFamily: style.fontFamily,
            ),
          )
          ..pushStyle(
            ui.TextStyle(
              color: style.color,
              fontSize: style.fontSize,
              fontFamily: style.fontFamily,
            ),
          )
          ..addText(text);
    final p = builder.build();
    p.layout(const ui.ParagraphConstraints(width: double.infinity));
    return p;
  }

  void _drawFoldIcon(
    Canvas canvas,
    Offset offset,
    IconData icon,
    Color color,
    double fontSize,
    double y,
  ) {
    final iconPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontFamily: icon.fontFamily,
          package: icon.fontPackage,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    iconPainter.layout();
    iconPainter.paint(
      canvas,
      offset +
          Offset(
            gutterWidth - iconPainter.width - 2,
            (innerPadding.top ?? 0) +
                y +
                (lineHeight0 - iconPainter.height) / 2,
          ),
    );
  }

  int _findIndentBasedEndLine(
    int startLine,
    int leadingSpaces,
    bool hasActiveFolds,
  ) {
    int endLine = startLine + 1;
    while (endLine < controller.lineCount) {
      if (hasActiveFolds && isLineFolded(endLine)) {
        endLine++;
        continue;
      }

      String nextLine;
      if (lineTextCache.containsKey(endLine)) {
        nextLine = lineTextCache[endLine]!;
      } else {
        nextLine = controller.getLineText(endLine);
        lineTextCache[endLine] = nextLine;
      }

      if (nextLine.trim().isEmpty) {
        endLine++;
        continue;
      }

      final nextLeading = nextLine.length - nextLine.trimLeft().length;
      if (nextLeading <= leadingSpaces) break;
      endLine++;
    }
    return endLine;
  }

  void _drawIndentGuides(
    Canvas canvas,
    Offset offset,
    int firstVisibleLine,
    int lastVisibleLine,
    double firstVisibleLineY,
    bool hasActiveFolds,
    Color textColor,
  ) {
    final viewTop = vscrollController.offset;
    final viewBottom = viewTop + vscrollController.position.viewportDimension;
    final tabSize = 4;
    final cursorOffset = controller.selection.extentOffset;
    final currentLine = controller.getLineAtOffset(cursorOffset);
    List<({int startLine, int endLine, int indentLevel, double guideX})>
    blocks = [];

    void processLine(int i) {
      if (hasActiveFolds && isLineFolded(i)) return;

      String lineText;
      if (lineTextCache.containsKey(i)) {
        lineText = lineTextCache[i]!;
      } else {
        lineText = controller.getLineText(i);
        lineTextCache[i] = lineText;
      }

      final trimmed = lineText.trimRight();

      // Check for Jinja template tags
      final jinjaTagMatch = RegExp(r'\{%\s*(\w+)').firstMatch(trimmed);
      int? jinjaEndLine;
      if (jinjaTagMatch != null) {
        final tagName = jinjaTagMatch.group(1);
        if (tagName != null) {
          jinjaEndLine = findMatchingJinjaEndTag(i, tagName);
        }
      }

      // Check for HTML/XML tags
      final htmlTagMatch = RegExp(
        r'<\s*([a-zA-Z][a-zA-Z0-9-]*)\s*[^>]*>',
      ).firstMatch(trimmed);
      int? htmlEndLine;
      if (htmlTagMatch != null) {
        final tagName = htmlTagMatch.group(1);
        if (tagName != null) {
          final isSelfClosing = RegExp(r'/\s*>').hasMatch(trimmed);
          if (!isSelfClosing) {
            htmlEndLine = findMatchingHtmlEndTag(i, tagName);
          }
        }
      }

      final endsWithBracket =
          trimmed.endsWith('{') ||
          trimmed.endsWith('(') ||
          trimmed.endsWith('[') ||
          trimmed.endsWith(':');

      // Skip if neither Jinja tag, HTML tag, nor bracket/colon
      if (jinjaEndLine == null && htmlEndLine == null && !endsWithBracket) {
        return;
      }

      final leadingSpaces = lineText.length - lineText.trimLeft().length;
      final indentLevel = leadingSpaces ~/ tabSize;
      final lastChar = trimmed[trimmed.length - 1];
      int endLine = i + 1;

      // Prioritize Jinja tag matching, then HTML tag matching
      if (jinjaEndLine != null) {
        endLine = jinjaEndLine + 1;
      } else if (htmlEndLine != null) {
        endLine = htmlEndLine + 1;
      } else if (lastChar == '{' || lastChar == '(' || lastChar == '[') {
        final lineStartOffset = controller.getLineStartOffset(i);
        final bracketPos = lineStartOffset + trimmed.length - 1;
        final matchPos = findMatchingBracket(controller.text, bracketPos);

        if (matchPos != null) {
          endLine = controller.getLineAtOffset(matchPos) + 1;
        } else {
          endLine = _findIndentBasedEndLine(i, leadingSpaces, hasActiveFolds);
        }
      } else {
        endLine = _findIndentBasedEndLine(i, leadingSpaces, hasActiveFolds);
      }

      if (endLine <= i + 1) {
        return;
      }

      if (endLine < firstVisibleLine) return;

      double guideX = 0;
      if (leadingSpaces > 0) {
        ui.Paragraph para;
        if (paragraphCache.containsKey(i)) {
          para = paragraphCache[i]!;
        } else {
          para = buildHighlightedParagraph(i, lineText);
          paragraphCache[i] = para;
        }
        final boxes = para.getBoxesForRange(0, leadingSpaces);
        guideX = boxes.isNotEmpty ? boxes.last.right : 0;
      }

      bool wouldPassThroughText = false;
      for (
        int checkLine = i + 1;
        checkLine < endLine - 1 && checkLine < controller.lineCount;
        checkLine++
      ) {
        if (hasActiveFolds && isLineFolded(checkLine)) continue;

        String checkLineText;
        if (lineTextCache.containsKey(checkLine)) {
          checkLineText = lineTextCache[checkLine]!;
        } else {
          checkLineText = controller.getLineText(checkLine);
          lineTextCache[checkLine] = checkLineText;
        }

        if (checkLineText.trim().isEmpty) continue;

        final checkLeadingSpaces =
            checkLineText.length - checkLineText.trimLeft().length;

        if (checkLeadingSpaces <= leadingSpaces) {
          wouldPassThroughText = true;
          break;
        }
      }

      if (wouldPassThroughText) return;

      blocks.add((
        startLine: i,
        endLine: endLine,
        indentLevel: indentLevel,
        guideX: guideX,
      ));
    }

    final scanBackLimit = 500;
    final scanStart = (firstVisibleLine - scanBackLimit).clamp(
      0,
      firstVisibleLine,
    );
    for (int i = scanStart; i < firstVisibleLine; i++) {
      processLine(i);
    }

    for (
      int i = firstVisibleLine;
      i <= lastVisibleLine && i < controller.lineCount;
      i++
    ) {
      processLine(i);
    }

    int? selectedBlockIndex;
    int minBlockSize = 999999;

    for (int idx = 0; idx < blocks.length; idx++) {
      final block = blocks[idx];
      if (currentLine >= block.startLine && currentLine < block.endLine) {
        final blockSize = block.endLine - block.startLine;
        if (blockSize < minBlockSize) {
          minBlockSize = blockSize;
          selectedBlockIndex = idx;
        }
      }
    }

    for (int idx = 0; idx < blocks.length; idx++) {
      final block = blocks[idx];
      final isSelected = selectedBlockIndex == idx;

      final guidePaint = Paint()
        ..color = isSelected ? textColor : textColor.withAlpha(100)
        ..strokeWidth = isSelected ? 1.0 : 0.5
        ..style = PaintingStyle.stroke;

      double yTop;
      if (!lineWrap && !hasActiveFolds) {
        yTop = (block.startLine + 1) * lineHeight0;
      } else {
        yTop = getLineYOffset(block.startLine + 1, hasActiveFolds);
      }

      double yBottom;
      if (!lineWrap && !hasActiveFolds) {
        yBottom = (block.endLine - 1) * lineHeight0 + lineHeight0;
      } else {
        yBottom = getLineYOffset(block.endLine, hasActiveFolds);
      }

      final screenYTop =
          offset.dy + (innerPadding.top ?? 0) + yTop - vscrollController.offset;
      final screenYBottom =
          offset.dy +
          (innerPadding.top ?? 0) +
          yBottom -
          vscrollController.offset;

      if (screenYBottom < 0 || screenYTop > viewBottom - viewTop) continue;

      final screenGuideX =
          offset.dx +
          gutterWidth +
          (innerPadding.left ?? 0) +
          block.guideX -
          (lineWrap ? 0 : hscrollController.offset);

      if (screenGuideX < offset.dx + gutterWidth ||
          screenGuideX > offset.dx + size.width) {
        continue;
      }

      final clampedYTop = screenYTop.clamp(0.0, viewBottom - viewTop);
      final clampedYBottom = screenYBottom.clamp(0.0, viewBottom - viewTop);

      canvas.drawLine(
        Offset(screenGuideX, clampedYTop),
        Offset(screenGuideX, clampedYBottom),
        guidePaint,
      );
    }
  }

  void _drawRulers(
    Canvas canvas,
    Offset offset,
    int firstVisibleLine,
    int lastVisibleLine,
    double firstVisibleLineY,
    bool hasActiveFolds,
    Color textColor,
  ) {
    if (rulers == null || rulers!.isEmpty) {
      return; // Don't draw rulers if disabled
    }

    final characterWidth = getCharacterWidth();
    final horizontalScrollOffset = hscrollController.offset;

    // Create paint for rulers (same style as indentation guides)
    final rulerPaint = Paint()
      ..color = (editorTheme['root']?.color ?? textColor).withAlpha(100)
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    // Calculate viewport bounds
    final viewportTop = offset.dy + (innerPadding.top ?? 0);
    final viewportBottom =
        viewportTop + vscrollController.position.viewportDimension;
    final contentLeft = offset.dx + gutterWidth + (innerPadding.left ?? 0);
    final contentRight = offset.dx + size.width;

    // Draw each ruler - always show if rulers are set, regardless of line content length
    for (final column in rulers!) {
      // Calculate X position for this column
      final rulerX =
          contentLeft + (column * characterWidth) - horizontalScrollOffset;

      // Only draw if ruler is within visible horizontal range (accounting for scroll)
      // This ensures rulers are visible when scrolled into view, but not drawn when scrolled out
      // Draw vertical line spanning the full viewport height
      // This ensures rulers are always visible regardless of line content length
      canvas.drawLine(
        Offset(rulerX, viewportTop),
        Offset(rulerX, viewportBottom),
        rulerPaint,
      );
    }
  }

  void _drawBracketHighlight(
    Canvas canvas,
    Offset offset,
    double viewTop,
    double viewBottom,
    int firstVisibleLine,
    int lastVisibleLine,
    double firstVisibleLineY,
    bool hasActiveFolds,
    Color textColor,
  ) {
    final (bracket1, bracket2) = getBracketPairAtCursor();
    if (bracket1 == null || bracket2 == null) return;

    final line1 = controller.getLineAtOffset(bracket1);
    final line2 = controller.getLineAtOffset(bracket2);

    if (line1 >= firstVisibleLine &&
        line1 <= lastVisibleLine &&
        (!hasActiveFolds || !isLineFolded(line1))) {
      _drawBracketBox(
        canvas,
        offset,
        bracket1,
        line1,
        hasActiveFolds,
        textColor,
      );
    }

    if (line2 >= firstVisibleLine &&
        line2 <= lastVisibleLine &&
        (!hasActiveFolds || !isLineFolded(line2))) {
      _drawBracketBox(
        canvas,
        offset,
        bracket2,
        line2,
        hasActiveFolds,
        textColor,
      );
    }
  }

  void _drawBracketBox(
    Canvas canvas,
    Offset offset,
    int bracketOffset,
    int lineIndex,
    bool hasActiveFolds,
    Color textColor,
  ) {
    final lineStartOffset = controller.getLineStartOffset(lineIndex);
    final columnIndex = bracketOffset - lineStartOffset;

    String lineText;
    if (lineTextCache.containsKey(lineIndex)) {
      lineText = lineTextCache[lineIndex]!;
    } else {
      lineText = controller.getLineText(lineIndex);
      lineTextCache[lineIndex] = lineText;
    }

    if (columnIndex < 0 || columnIndex >= lineText.length) return;

    ui.Paragraph para;
    if (paragraphCache.containsKey(lineIndex)) {
      para = paragraphCache[lineIndex]!;
    } else {
      para = buildHighlightedParagraph(
        lineIndex,
        lineText,
        width: lineWrap ? wrapWidth : null,
      );
      paragraphCache[lineIndex] = para;
    }

    final boxes = para.getBoxesForRange(columnIndex, columnIndex + 1);
    if (boxes.isEmpty) return;

    final box = boxes.first;

    final lineY = getLineYOffset(lineIndex, hasActiveFolds);
    final boxY = lineY + box.top;

    final screenX =
        offset.dx +
        gutterWidth +
        (innerPadding.left ?? 0) +
        box.left -
        (lineWrap ? 0 : hscrollController.offset);
    final screenY =
        offset.dy + (innerPadding.top ?? 0) + boxY - vscrollController.offset;

    final bracketRect = Rect.fromLTWH(
      screenX - 1,
      screenY,
      box.right - box.left + 2,
      lineHeight0,
    );

    bracketHighlightPainter.color = textColor;
    canvas.drawRect(bracketRect, bracketHighlightPainter);
  }

  void _drawDiagnostics(
    Canvas canvas,
    Offset offset,
    int firstVisibleLine,
    int lastVisibleLine,
    double firstVisibleLineY,
    bool hasActiveFolds,
  ) {
    if (diagnostics.isEmpty) return;

    final sortedDiagnostics = List<LspErrors>.from(diagnostics)
      ..sort((a, b) => (b.severity).compareTo(a.severity));

    for (final diagnostic in sortedDiagnostics) {
      final range = diagnostic.range;
      final startPos = range['start'] as Map<String, dynamic>;
      final endPos = range['end'] as Map<String, dynamic>;
      final startLine = startPos['line'] as int;
      final startChar = startPos['character'] as int;
      final endLine = endPos['line'] as int;
      final endChar = endPos['character'] as int;

      if (endLine < firstVisibleLine || startLine > lastVisibleLine) continue;

      final Color underlineColor;
      switch (diagnostic.severity) {
        case 1:
          underlineColor = Colors.red;
          break;
        case 2:
          underlineColor = Colors.yellow.shade700;
          break;
        case 3:
          underlineColor = Colors.blue;
          break;
        case 4:
          underlineColor = Colors.grey;
          break;
        default:
          underlineColor = Colors.red;
      }

      final paint = Paint()
        ..color = underlineColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5;

      for (int lineIndex = startLine; lineIndex <= endLine; lineIndex++) {
        if (lineIndex < firstVisibleLine || lineIndex > lastVisibleLine) {
          continue;
        }
        if (hasActiveFolds && isLineFolded(lineIndex)) continue;

        String lineText;
        if (lineTextCache.containsKey(lineIndex)) {
          lineText = lineTextCache[lineIndex]!;
        } else {
          lineText = controller.getLineText(lineIndex);
          lineTextCache[lineIndex] = lineText;
        }

        if (lineText.isEmpty) continue;

        ui.Paragraph para;
        if (paragraphCache.containsKey(lineIndex)) {
          para = paragraphCache[lineIndex]!;
        } else {
          para = buildHighlightedParagraph(
            lineIndex,
            lineText,
            width: lineWrap ? wrapWidth : null,
          );
          paragraphCache[lineIndex] = para;
        }

        final lineStartChar = (lineIndex == startLine) ? startChar : 0;
        final lineEndChar = (lineIndex == endLine)
            ? endChar.clamp(0, lineText.length)
            : lineText.length;

        if (lineStartChar >= lineEndChar || lineStartChar >= lineText.length) {
          continue;
        }

        final boxes = para.getBoxesForRange(
          lineStartChar.clamp(0, lineText.length),
          lineEndChar.clamp(0, lineText.length),
        );

        if (boxes.isEmpty) continue;

        final lineY = getLineYOffset(lineIndex, hasActiveFolds);

        for (final box in boxes) {
          final screenX =
              offset.dx +
              gutterWidth +
              (innerPadding.left ?? 0) +
              box.left -
              (lineWrap ? 0 : hscrollController.offset);
          final screenY =
              offset.dy +
              (innerPadding.top ?? 0) +
              lineY +
              box.top +
              lineHeight0 -
              vscrollController.offset;

          final width = box.right - box.left;
          _drawSquigglyLine(canvas, screenX, screenY, width, paint);
        }
      }
    }
  }

  void _drawSquigglyLine(
    Canvas canvas,
    double x,
    double y,
    double width,
    Paint paint,
  ) {
    if (width <= 0) return;

    final path = Path();
    const waveHeight = 2.0;
    const waveWidth = 4.0;

    path.moveTo(x, y);

    double currentX = x;
    bool up = true;

    while (currentX < x + width) {
      final nextX = (currentX + waveWidth).clamp(x, x + width);
      final controlY = up ? y - waveHeight : y + waveHeight;

      path.quadraticBezierTo((currentX + nextX) / 2, controlY, nextX, y);

      currentX = nextX;
      up = !up;
    }

    canvas.drawPath(path, paint);
  }

  void _drawSearchHighlights(
    Canvas canvas,
    Offset offset,
    int firstVisibleLine,
    int lastVisibleLine,
    double firstVisibleLineY,
    bool hasActiveFolds,
  ) {
    final highlights = controller.searchHighlights;
    if (highlights.isEmpty) return;

    for (final highlight in highlights) {
      final start = highlight.start;
      final end = highlight.end;

      int startLine = controller.getLineAtOffset(start);
      int endLine = controller.getLineAtOffset(end);

      if (endLine < firstVisibleLine || startLine > lastVisibleLine) continue;

      final highlightStyle = highlight.isCurrentMatch
          ? (matchHighlightStyle0?.currentMatchStyle ??
                const TextStyle(backgroundColor: Color(0xFF01A2FF)))
          : (matchHighlightStyle0?.otherMatchStyle ??
                const TextStyle(
                  backgroundColor: Color.fromARGB(163, 72, 215, 255),
                ));

      final highlightPaint = Paint()
        ..color = highlightStyle.backgroundColor ?? Colors.amberAccent
        ..style = PaintingStyle.fill;

      for (int lineIndex = startLine; lineIndex <= endLine; lineIndex++) {
        if (lineIndex < firstVisibleLine || lineIndex > lastVisibleLine) {
          continue;
        }
        if (hasActiveFolds && isLineFolded(lineIndex)) continue;

        final lineStartOffset = controller.getLineStartOffset(lineIndex);
        final lineText =
            lineTextCache[lineIndex] ?? controller.getLineText(lineIndex);
        final lineLength = lineText.length;

        int lineSelStart = 0;
        int lineSelEnd = lineLength;

        if (lineIndex == startLine) {
          lineSelStart = start - lineStartOffset;
        }
        if (lineIndex == endLine) {
          lineSelEnd = end - lineStartOffset;
        }

        lineSelStart = lineSelStart.clamp(0, lineLength);
        lineSelEnd = lineSelEnd.clamp(0, lineLength);

        if (lineSelStart >= lineSelEnd) continue;

        ui.Paragraph para;
        if (paragraphCache.containsKey(lineIndex)) {
          para = paragraphCache[lineIndex]!;
        } else {
          para = buildHighlightedParagraph(
            lineIndex,
            lineText,
            width: lineWrap ? wrapWidth : null,
          );
          paragraphCache[lineIndex] = para;
        }

        final lineY = getLineYOffset(lineIndex, hasActiveFolds);

        if (lineText.isNotEmpty) {
          final boxes = para.getBoxesForRange(
            lineSelStart.clamp(0, lineText.length),
            lineSelEnd.clamp(0, lineText.length),
          );

          for (final box in boxes) {
            final screenX =
                offset.dx +
                gutterWidth +
                (innerPadding.left ?? 0) +
                box.left -
                (lineWrap ? 0 : hscrollController.offset);
            final screenY =
                offset.dy +
                (innerPadding.top ?? 0) +
                lineY +
                box.top -
                vscrollController.offset;

            canvas.drawRect(
              Rect.fromLTWH(
                screenX,
                screenY,
                box.right - box.left,
                lineHeight0,
              ),
              highlightPaint,
            );
          }
        }
      }
    }
  }

  void _drawFoldedLineHighlights(
    Canvas canvas,
    Offset offset,
    int firstVisibleLine,
    int lastVisibleLine,
    double firstVisibleLineY,
    bool hasActiveFolds,
  ) {
    if (!hasActiveFolds) return;

    final highlightColor =
        gutterStyle.foldedLineHighlightColor ??
        selectionStyle.selectionColor.withAlpha(60);

    final highlightPaint = Paint()
      ..color = highlightColor
      ..style = PaintingStyle.fill;

    for (final foldRange in foldRanges) {
      if (!foldRange.isFolded) continue;

      final foldStartLine = foldRange.startIndex;

      if (foldStartLine < firstVisibleLine || foldStartLine > lastVisibleLine) {
        continue;
      }

      final lineY = getLineYOffset(foldStartLine, hasActiveFolds);
      final lineHeight = lineWrap
          ? getWrappedLineHeight(foldStartLine)
          : lineHeight0;

      final screenY =
          offset.dy +
          (innerPadding.top ?? 0) +
          lineY -
          vscrollController.offset;

      canvas.drawRect(
        Rect.fromLTWH(
          offset.dx + gutterWidth,
          screenY,
          size.width - gutterWidth,
          lineHeight,
        ),
        highlightPaint,
      );
    }
  }

  void _drawSelection(
    Canvas canvas,
    Offset offset,
    int firstVisibleLine,
    int lastVisibleLine,
    double firstVisibleLineY,
    bool hasActiveFolds,
  ) {
    final selection = controller.selection;
    if (selection.isCollapsed) return;

    final start = selection.start;
    final end = selection.end;

    final selectionPaint = Paint()
      ..color = selectionStyle.selectionColor
      ..style = PaintingStyle.fill;

    int startLine = controller.getLineAtOffset(start);
    int endLine = controller.getLineAtOffset(end);

    if (endLine < firstVisibleLine || startLine > lastVisibleLine) return;

    for (int lineIndex = startLine; lineIndex <= endLine; lineIndex++) {
      if (lineIndex < firstVisibleLine || lineIndex > lastVisibleLine) continue;
      if (hasActiveFolds && isLineFolded(lineIndex)) continue;

      final lineStartOffset = controller.getLineStartOffset(lineIndex);
      final lineText =
          lineTextCache[lineIndex] ?? controller.getLineText(lineIndex);
      final lineLength = lineText.length;

      int lineSelStart = 0;
      int lineSelEnd = lineLength;

      if (lineIndex == startLine) {
        lineSelStart = start - lineStartOffset;
      }
      if (lineIndex == endLine) {
        lineSelEnd = end - lineStartOffset;
      }

      lineSelStart = lineSelStart.clamp(0, lineLength);
      lineSelEnd = lineSelEnd.clamp(0, lineLength);

      if (lineSelStart >= lineSelEnd && lineIndex != endLine) {
        lineSelEnd = lineLength;
      }

      ui.Paragraph para;
      if (paragraphCache.containsKey(lineIndex)) {
        para = paragraphCache[lineIndex]!;
      } else {
        para = buildHighlightedParagraph(
          lineIndex,
          lineText,
          width: lineWrap ? wrapWidth : null,
        );
        paragraphCache[lineIndex] = para;
      }

      final lineY = getLineYOffset(lineIndex, hasActiveFolds);

      if (lineSelStart < lineSelEnd && lineText.isNotEmpty) {
        final boxes = para.getBoxesForRange(
          lineSelStart.clamp(0, lineText.length),
          lineSelEnd.clamp(0, lineText.length),
        );

        for (final box in boxes) {
          final screenX =
              offset.dx +
              gutterWidth +
              (innerPadding.left ?? 0) +
              box.left -
              (lineWrap ? 0 : hscrollController.offset);
          final screenY =
              offset.dy +
              (innerPadding.top ?? 0) +
              lineY +
              box.top -
              vscrollController.offset;

          canvas.drawRect(
            Rect.fromLTWH(screenX, screenY, box.right - box.left, lineHeight0),
            selectionPaint,
          );
        }
      } else if (lineIndex < endLine) {
        final screenX =
            offset.dx +
            gutterWidth +
            (innerPadding.left ?? 0) -
            (lineWrap ? 0 : hscrollController.offset);
        final screenY =
            offset.dy +
            (innerPadding.top ?? 0) +
            lineY -
            vscrollController.offset;

        canvas.drawRect(
          Rect.fromLTWH(screenX, screenY, 8, lineHeight0),
          selectionPaint,
        );
      }
    }

    updateSelectionHandleRects(
      offset,
      start,
      end,
      startLine,
      endLine,
      hasActiveFolds,
    );
  }

  void _updateSelectionHandleRects(
    Offset offset,
    int start,
    int end,
    int startLine,
    int endLine,
    bool hasActiveFolds,
  ) {
    final handleRadius = (_lineHeight / 2).clamp(6.0, 12.0);

    final startLineOffset = controller.getLineStartOffset(startLine);
    final startLineText =
        _lineTextCache[startLine] ?? controller.getLineText(startLine);
    final startCol = start - startLineOffset;

    final startY = _getLineYOffset(startLine, hasActiveFolds);

    double startX;
    double startYInLine = 0;
    if (startLineText.isNotEmpty && startCol > 0) {
      final para =
          _paragraphCache[startLine] ??
          _buildHighlightedParagraph(
            startLine,
            startLineText,
            width: lineWrap ? _wrapWidth : null,
          );
      final boxes = para.getBoxesForRange(
        0,
        startCol.clamp(0, startLineText.length),
      );
      if (boxes.isNotEmpty) {
        startX = boxes.last.right;
        startYInLine = boxes.last.top;
      } else {
        startX = 0;
      }
    } else {
      startX = 0;
    }

    final startScreenX =
        offset.dx +
        _gutterWidth +
        (innerPadding?.left ?? 0) +
        startX -
        (lineWrap ? 0 : hscrollController.offset);
    final startScreenY =
        offset.dy +
        (innerPadding?.top ?? 0) +
        startY +
        startYInLine -
        vscrollController.offset;

    _startHandleRect = Rect.fromCenter(
      center: Offset(
        startScreenX - (textStyle?.fontSize ?? 14) / 2,
        startScreenY + _lineHeight + handleRadius,
      ),
      width: handleRadius * 2 * 1.2,
      height: handleRadius * 2 * 1.2,
    );

    final endLineOffset = controller.getLineStartOffset(endLine);
    final endLineText =
        _lineTextCache[endLine] ?? controller.getLineText(endLine);
    final endCol = end - endLineOffset;

    final endY = _getLineYOffset(endLine, hasActiveFolds);

    double endX;
    double endYInLine = 0;
    if (endLineText.isNotEmpty && endCol > 0) {
      final para =
          _paragraphCache[endLine] ??
          _buildHighlightedParagraph(
            endLine,
            endLineText,
            width: lineWrap ? _wrapWidth : null,
          );
      final boxes = para.getBoxesForRange(
        0,
        endCol.clamp(0, endLineText.length),
      );
      if (boxes.isNotEmpty) {
        endX = boxes.last.right;
        endYInLine = boxes.last.top;
      } else {
        endX = 0;
      }
    } else {
      endX = 0;
    }

    final endScreenX =
        offset.dx +
        _gutterWidth +
        (innerPadding?.left ?? 0) +
        endX -
        (lineWrap ? 0 : hscrollController.offset);
    final endScreenY =
        offset.dy +
        (innerPadding?.top ?? 0) +
        endY +
        endYInLine -
        vscrollController.offset;

    _endHandleRect = Rect.fromCenter(
      center: Offset(
        endScreenX + (textStyle?.fontSize ?? 14) / 2,
        endScreenY + _lineHeight + handleRadius,
      ),
      width: handleRadius * 2 * 1.2,
      height: handleRadius * 2 * 1.2,
    );
  }

  void _drawAiGhostText(
    Canvas canvas,
    Offset offset,
    int firstVisibleLine,
    int lastVisibleLine,
    double firstVisibleLineY,
    bool hasActiveFolds,
  ) {
    if (_aiResponse == null || _aiResponse!.isEmpty) return;
    if (_ghostTextAnchorLine == null) return;
    if (!controller.selection.isValid || !controller.selection.isCollapsed) {
      return;
    }

    final cursorOffset = controller.selection.extentOffset;
    final cursorLine = _ghostTextAnchorLine!;

    if (hasActiveFolds && _isLineFolded(cursorLine)) return;

    final lineStartOffset = controller.getLineStartOffset(cursorLine);
    final cursorCol = cursorOffset - lineStartOffset;

    final lineText =
        _lineTextCache[cursorLine] ?? controller.getLineText(cursorLine);

    double cursorX;
    double cursorYInLine = 0;
    if (lineText.isNotEmpty && cursorCol > 0) {
      final para =
          _paragraphCache[cursorLine] ??
          _buildHighlightedParagraph(
            cursorLine,
            lineText,
            width: lineWrap ? _wrapWidth : null,
          );
      final boxes = para.getBoxesForRange(
        0,
        cursorCol.clamp(0, lineText.length),
      );
      if (boxes.isNotEmpty) {
        cursorX = boxes.last.right;
        cursorYInLine = boxes.last.top;
      } else {
        cursorX = 0;
      }
    } else {
      cursorX = 0;
    }

    final cursorY = _getLineYOffset(cursorLine, hasActiveFolds) + cursorYInLine;

    final defaultGhostColor =
        (textStyle?.color ?? editorTheme['root']?.color ?? Colors.white)
            .withAlpha(100);
    final ghostStyle = ui.TextStyle(
      color: _ghostTextStyle?.color ?? defaultGhostColor,
      fontSize: _ghostTextStyle?.fontSize ?? textStyle?.fontSize ?? 14.0,
      fontFamily: _ghostTextStyle?.fontFamily ?? textStyle?.fontFamily,
      fontStyle: _ghostTextStyle?.fontStyle ?? FontStyle.italic,
      fontWeight: _ghostTextStyle?.fontWeight,
      letterSpacing: _ghostTextStyle?.letterSpacing,
      wordSpacing: _ghostTextStyle?.wordSpacing,
      decoration: _ghostTextStyle?.decoration,
      decorationColor: _ghostTextStyle?.decorationColor,
    );

    final aiLines = _aiResponse?.split('\n') ?? [];
    final isSingleLineGhost = aiLines.length == 1;
    final clampedCol = cursorCol.clamp(0, lineText.length);

    if (isSingleLineGhost && aiLines.isNotEmpty && aiLines[0].isNotEmpty) {
      final ghostBuilder =
          ui.ParagraphBuilder(
              ui.ParagraphStyle(
                fontFamily: textStyle?.fontFamily,
                fontSize: textStyle?.fontSize ?? 14.0,
                height: textStyle?.height ?? 1.2,
              ),
            )
            ..pushStyle(ghostStyle)
            ..addText(aiLines[0]);
      final ghostPara = ghostBuilder.build();
      ghostPara.layout(const ui.ParagraphConstraints(width: double.infinity));
      final firstLineGhostWidth = ghostPara.longestLine;

      final screenY =
          offset.dy +
          (innerPadding?.top ?? 0) +
          cursorY -
          vscrollController.offset;

      final screenX =
          offset.dx +
          _gutterWidth +
          (innerPadding?.left ?? 0) +
          cursorX -
          (lineWrap ? 0 : hscrollController.offset);

      final bgColor = editorTheme['root']?.backgroundColor ?? Colors.black;
      final originalPara = _paragraphCache[cursorLine];
      if (originalPara != null && clampedCol < lineText.length) {
        final remainingWidth = originalPara.longestLine - cursorX;
        if (remainingWidth > 0) {
          canvas.drawRect(
            Rect.fromLTWH(screenX, screenY, remainingWidth + 2, _lineHeight),
            Paint()..color = bgColor,
          );
        }
      }

      canvas.drawParagraph(ghostPara, Offset(screenX, screenY));

      if (clampedCol < lineText.length) {
        final remainingText = lineText.substring(clampedCol);

        final normalStyle = ui.TextStyle(
          color: textStyle?.color ?? editorTheme['root']?.color ?? Colors.white,
          fontSize: textStyle?.fontSize ?? 14.0,
          fontFamily: textStyle?.fontFamily,
          fontWeight: textStyle?.fontWeight,
        );

        final remainingBuilder =
            ui.ParagraphBuilder(
                ui.ParagraphStyle(
                  fontFamily: textStyle?.fontFamily,
                  fontSize: textStyle?.fontSize ?? 14.0,
                  height: textStyle?.height ?? 1.2,
                ),
              )
              ..pushStyle(normalStyle)
              ..addText(remainingText);

        final remainingPara = remainingBuilder.build();
        remainingPara.layout(
          const ui.ParagraphConstraints(width: double.infinity),
        );

        canvas.drawParagraph(
          remainingPara,
          Offset(screenX + firstLineGhostWidth, screenY),
        );
      }
      return;
    }

    if (aiLines.isNotEmpty && aiLines[0].isNotEmpty) {
      final ghostBuilder =
          ui.ParagraphBuilder(
              ui.ParagraphStyle(
                fontFamily: textStyle?.fontFamily,
                fontSize: textStyle?.fontSize ?? 14.0,
                height: textStyle?.height ?? 1.2,
              ),
            )
            ..pushStyle(ghostStyle)
            ..addText(aiLines[0]);
      final ghostPara = ghostBuilder.build();
      ghostPara.layout(const ui.ParagraphConstraints(width: double.infinity));

      final screenY =
          offset.dy +
          (innerPadding?.top ?? 0) +
          cursorY -
          vscrollController.offset;

      final screenX =
          offset.dx +
          _gutterWidth +
          (innerPadding?.left ?? 0) +
          cursorX -
          (lineWrap ? 0 : hscrollController.offset);

      final bgColor = editorTheme['root']?.backgroundColor ?? Colors.black;
      final originalPara = _paragraphCache[cursorLine];
      if (originalPara != null && clampedCol < lineText.length) {
        final remainingWidth = originalPara.longestLine - cursorX;
        if (remainingWidth > 0) {
          canvas.drawRect(
            Rect.fromLTWH(screenX, screenY, remainingWidth + 2, _lineHeight),
            Paint()..color = bgColor,
          );
        }
      }

      canvas.drawParagraph(ghostPara, Offset(screenX, screenY));
    }

    double lastGhostLineWidth = 0;
    double lastGhostLineScreenY = 0;
    double lastGhostLineScreenX = 0;

    for (int i = 1; i < aiLines.length; i++) {
      final aiLineText = aiLines[i];
      final isLastLine = i == aiLines.length - 1;

      final lineY = cursorY + (i * _lineHeight);

      final screenY =
          offset.dy +
          (innerPadding?.top ?? 0) +
          lineY -
          vscrollController.offset;

      final screenX =
          offset.dx +
          _gutterWidth +
          (innerPadding?.left ?? 0) -
          (lineWrap ? 0 : hscrollController.offset);

      if (screenY + _lineHeight < offset.dy ||
          screenY > offset.dy + vscrollController.position.viewportDimension) {
        if (isLastLine) {
          lastGhostLineScreenY = screenY;
          lastGhostLineScreenX = screenX;
        }
        continue;
      }

      if (aiLineText.isNotEmpty || isLastLine) {
        final builder =
            ui.ParagraphBuilder(
                ui.ParagraphStyle(
                  fontFamily: textStyle?.fontFamily,
                  fontSize: textStyle?.fontSize ?? 14.0,
                  height: textStyle?.height ?? 1.2,
                ),
              )
              ..pushStyle(ghostStyle)
              ..addText(aiLineText);

        final para = builder.build();
        para.layout(const ui.ParagraphConstraints(width: double.infinity));

        canvas.drawParagraph(para, Offset(screenX, screenY));

        if (isLastLine) {
          lastGhostLineWidth = para.longestLine;
          lastGhostLineScreenY = screenY;
          lastGhostLineScreenX = screenX;
        }
      }
    }

    if (clampedCol < lineText.length && aiLines.length > 1) {
      final remainingText = lineText.substring(clampedCol);

      final normalStyle = ui.TextStyle(
        color: textStyle?.color ?? editorTheme['root']?.color ?? Colors.white,
        fontSize: textStyle?.fontSize ?? 14.0,
        fontFamily: textStyle?.fontFamily,
        fontWeight: textStyle?.fontWeight,
      );

      final remainingBuilder =
          ui.ParagraphBuilder(
              ui.ParagraphStyle(
                fontFamily: textStyle?.fontFamily,
                fontSize: textStyle?.fontSize ?? 14.0,
                height: textStyle?.height ?? 1.2,
              ),
            )
            ..pushStyle(normalStyle)
            ..addText(remainingText);

      final remainingPara = remainingBuilder.build();
      remainingPara.layout(
        const ui.ParagraphConstraints(width: double.infinity),
      );

      canvas.drawParagraph(
        remainingPara,
        Offset(lastGhostLineScreenX + lastGhostLineWidth, lastGhostLineScreenY),
      );
    }
  }

  void _drawLineDecorations(
    Canvas canvas,
    Offset offset,
    int firstVisibleLine,
    int lastVisibleLine,
    double firstVisibleLineY,
    bool hasActiveFolds,
  ) {
    final decorations = controller.lineDecorations;
    if (decorations.isEmpty) return;

    for (final decoration in decorations) {
      if (decoration.endLine < firstVisibleLine ||
          decoration.startLine > lastVisibleLine) {
        continue;
      }

      final paint = Paint()
        ..color = decoration.color
        ..style = PaintingStyle.fill;

      double currentY = firstVisibleLineY;
      for (
        int i = firstVisibleLine;
        i <= lastVisibleLine && i < controller.lineCount;
        i++
      ) {
        if (hasActiveFolds && _isLineFolded(i)) continue;

        final lineHeight = lineWrap ? _getWrappedLineHeight(i) : _lineHeight;

        if (i >= decoration.startLine && i <= decoration.endLine) {
          final screenY =
              offset.dy +
              (innerPadding?.top ?? 0) +
              currentY -
              vscrollController.offset;
          final screenX =
              offset.dx +
              _gutterWidth +
              (innerPadding?.left ?? 0) -
              (lineWrap ? 0 : hscrollController.offset);

          switch (decoration.type) {
            case LineDecorationType.background:
              final width =
                  size.width - _gutterWidth - (innerPadding?.horizontal ?? 0);
              canvas.drawRect(
                Rect.fromLTWH(screenX, screenY, width, lineHeight),
                paint,
              );
              break;

            case LineDecorationType.leftBorder:
              paint.style = PaintingStyle.fill;
              canvas.drawRect(
                Rect.fromLTWH(
                  offset.dx + _gutterWidth,
                  screenY,
                  decoration.thickness,
                  lineHeight,
                ),
                paint,
              );
              break;

            case LineDecorationType.underline:
              paint.style = PaintingStyle.stroke;
              paint.strokeWidth = decoration.thickness;
              final width =
                  size.width - _gutterWidth - (innerPadding?.horizontal ?? 0);
              canvas.drawLine(
                Offset(screenX, screenY + lineHeight - decoration.thickness),
                Offset(
                  screenX + width,
                  screenY + lineHeight - decoration.thickness,
                ),
                paint,
              );
              break;

            case LineDecorationType.wavyUnderline:
              paint.style = PaintingStyle.stroke;
              paint.strokeWidth = decoration.thickness;
              final width =
                  size.width - _gutterWidth - (innerPadding?.horizontal ?? 0);
              final path = Path();
              final waveHeight = decoration.thickness * 2;
              final waveWidth = waveHeight * 2;
              double x = screenX;
              final y = screenY + lineHeight - decoration.thickness;
              path.moveTo(x, y);
              while (x < screenX + width) {
                path.quadraticBezierTo(
                  x + waveWidth / 4,
                  y - waveHeight,
                  x + waveWidth / 2,
                  y,
                );
                path.quadraticBezierTo(
                  x + waveWidth * 3 / 4,
                  y + waveHeight,
                  x + waveWidth,
                  y,
                );
                x += waveWidth;
              }
              canvas.drawPath(path, paint);
              break;
          }
        }

        currentY += lineHeight;
      }
    }
  }

  void _drawLineHighlight(
    Canvas canvas,
    Offset offset,
    int firstVisibleLine,
    int lastVisibleLine,
    double firstVisibleLineY,
    bool hasActiveFolds,
  ) {
    if (_highlightedLine == null || _lineHighlightAnimation == null) return;

    final highlightLine = _highlightedLine!;

    if (highlightLine < firstVisibleLine || highlightLine > lastVisibleLine) {
      return;
    }

    if (hasActiveFolds && _isLineFolded(highlightLine)) return;

    final opacity = _lineHighlightAnimation!.value;
    if (opacity <= 0.0) {
      _highlightedLine = null;
      return;
    }

    final lineY = _getLineYOffset(highlightLine, hasActiveFolds);
    final lineHeight = lineWrap
        ? _getWrappedLineHeight(highlightLine)
        : _lineHeight;

    final screenY =
        offset.dy + (innerPadding?.top ?? 0) + lineY - vscrollController.offset;
    final screenX =
        offset.dx +
        _gutterWidth +
        (innerPadding?.left ?? 0) -
        (lineWrap ? 0 : hscrollController.offset);

    final highlightColor =
        (textStyle?.color ?? editorTheme['root']?.color ?? Colors.yellow)
            .withValues(alpha: opacity);

    final paint = Paint()
      ..color = highlightColor
      ..style = PaintingStyle.fill;

    final width = size.width - _gutterWidth - (innerPadding?.horizontal ?? 0);
    canvas.drawRect(Rect.fromLTWH(screenX, screenY, width, lineHeight), paint);
  }

  void _drawGutterDecorations(
    Canvas canvas,
    Offset offset,
    int lineIndex,
    double contentTop,
    double lineHeight,
  ) {
    final decorations = controller.gutterDecorations;
    if (decorations.isEmpty) return;

    for (final decoration in decorations) {
      if (lineIndex < decoration.startLine || lineIndex > decoration.endLine) {
        continue;
      }

      final screenY =
          offset.dy +
          (innerPadding?.top ?? 0) +
          contentTop -
          vscrollController.offset;

      switch (decoration.type) {
        case GutterDecorationType.colorBar:
          final paint = Paint()
            ..color = decoration.color
            ..style = PaintingStyle.fill;
          canvas.drawRect(
            Rect.fromLTWH(offset.dx, screenY, decoration.width, lineHeight),
            paint,
          );
          break;

        case GutterDecorationType.icon:
          if (decoration.icon != null) {
            final iconPainter = TextPainter(
              text: TextSpan(
                text: String.fromCharCode(decoration.icon!.codePoint),
                style: TextStyle(
                  fontSize: textStyle?.fontSize ?? 14,
                  color: decoration.color,
                  fontFamily: decoration.icon!.fontFamily,
                  package: decoration.icon!.fontPackage,
                ),
              ),
              textDirection: TextDirection.ltr,
            );
            iconPainter.layout();
            iconPainter.paint(
              canvas,
              Offset(
                offset.dx + 2,
                screenY + (lineHeight - iconPainter.height) / 2,
              ),
            );
          }
          break;

        case GutterDecorationType.dot:
          final paint = Paint()
            ..color = decoration.color
            ..style = PaintingStyle.fill;
          final radius = (textStyle?.fontSize ?? 14) / 4;
          canvas.drawCircle(
            Offset(
              offset.dx + decoration.width / 2 + 2,
              screenY + lineHeight / 2,
            ),
            radius,
            paint,
          );
          break;
      }
    }
  }

  void _drawGhostText(
    Canvas canvas,
    Offset offset,
    int firstVisibleLine,
    int lastVisibleLine,
    double firstVisibleLineY,
    bool hasActiveFolds,
  ) {
    final ghost = controller.ghostText;
    if (ghost == null || ghost.text.isEmpty) return;

    final cursorLine = ghost.line;
    final cursorCol = ghost.column;

    if (hasActiveFolds && _isLineFolded(cursorLine)) return;

    final lineText =
        _lineTextCache[cursorLine] ?? controller.getLineText(cursorLine);

    double cursorX;
    double cursorYInLine = 0;
    if (lineText.isNotEmpty && cursorCol > 0) {
      final para =
          _paragraphCache[cursorLine] ??
          _buildHighlightedParagraph(
            cursorLine,
            lineText,
            width: lineWrap ? _wrapWidth : null,
          );
      final boxes = para.getBoxesForRange(
        0,
        cursorCol.clamp(0, lineText.length),
      );
      if (boxes.isNotEmpty) {
        cursorX = boxes.last.right;
        cursorYInLine = boxes.last.top;
      } else {
        cursorX = 0;
      }
    } else {
      cursorX = 0;
    }

    final cursorY = _getLineYOffset(cursorLine, hasActiveFolds) + cursorYInLine;

    final defaultGhostColor =
        (textStyle?.color ?? editorTheme['root']?.color ?? Colors.white)
            .withAlpha(100);
    final customStyle = ghost.style;
    final ghostStyle = ui.TextStyle(
      color: customStyle?.color ?? defaultGhostColor,
      fontSize: customStyle?.fontSize ?? textStyle?.fontSize ?? 14.0,
      fontFamily: customStyle?.fontFamily ?? textStyle?.fontFamily,
      fontStyle: customStyle?.fontStyle ?? FontStyle.italic,
      fontWeight: customStyle?.fontWeight,
      letterSpacing: customStyle?.letterSpacing,
      wordSpacing: customStyle?.wordSpacing,
      decoration: customStyle?.decoration,
      decorationColor: customStyle?.decorationColor,
    );

    final ghostLines = ghost.text.split('\n');
    final isSingleLineGhost = ghostLines.length == 1;

    double firstLineGhostWidth = 0;
    if (isSingleLineGhost && ghostLines[0].isNotEmpty) {
      final ghostBuilder =
          ui.ParagraphBuilder(
              ui.ParagraphStyle(
                fontFamily: textStyle?.fontFamily,
                fontSize: textStyle?.fontSize ?? 14.0,
                height: textStyle?.height ?? 1.2,
              ),
            )
            ..pushStyle(ghostStyle)
            ..addText(ghostLines[0]);
      final ghostPara = ghostBuilder.build();
      ghostPara.layout(const ui.ParagraphConstraints(width: double.infinity));
      firstLineGhostWidth = ghostPara.longestLine;

      final screenY =
          offset.dy +
          (innerPadding?.top ?? 0) +
          cursorY -
          vscrollController.offset;

      final screenX =
          offset.dx +
          _gutterWidth +
          (innerPadding?.left ?? 0) +
          cursorX -
          (lineWrap ? 0 : hscrollController.offset);

      final clampedCol = cursorCol.clamp(0, lineText.length);
      final bgColor = editorTheme['root']?.backgroundColor ?? Colors.black;
      final originalPara = _paragraphCache[cursorLine];
      if (originalPara != null && clampedCol < lineText.length) {
        final remainingWidth = originalPara.longestLine - cursorX;
        if (remainingWidth > 0) {
          canvas.drawRect(
            Rect.fromLTWH(screenX, screenY, remainingWidth + 2, _lineHeight),
            Paint()..color = bgColor,
          );
        }
      }

      canvas.drawParagraph(ghostPara, Offset(screenX, screenY));

      if (clampedCol < lineText.length) {
        final remainingText = lineText.substring(clampedCol);

        final normalStyle = ui.TextStyle(
          color: textStyle?.color ?? editorTheme['root']?.color ?? Colors.white,
          fontSize: textStyle?.fontSize ?? 14.0,
          fontFamily: textStyle?.fontFamily,
          fontWeight: textStyle?.fontWeight,
        );

        final remainingBuilder =
            ui.ParagraphBuilder(
                ui.ParagraphStyle(
                  fontFamily: textStyle?.fontFamily,
                  fontSize: textStyle?.fontSize ?? 14.0,
                  height: textStyle?.height ?? 1.2,
                ),
              )
              ..pushStyle(normalStyle)
              ..addText(remainingText);

        final remainingPara = remainingBuilder.build();
        remainingPara.layout(
          const ui.ParagraphConstraints(width: double.infinity),
        );

        canvas.drawParagraph(
          remainingPara,
          Offset(screenX + firstLineGhostWidth, screenY),
        );
      }
      return;
    }

    final multiClampedCol = cursorCol.clamp(0, lineText.length);

    if (ghostLines.isNotEmpty && ghostLines[0].isNotEmpty) {
      final ghostBuilder =
          ui.ParagraphBuilder(
              ui.ParagraphStyle(
                fontFamily: textStyle?.fontFamily,
                fontSize: textStyle?.fontSize ?? 14.0,
                height: textStyle?.height ?? 1.2,
              ),
            )
            ..pushStyle(ghostStyle)
            ..addText(ghostLines[0]);
      final ghostPara = ghostBuilder.build();
      ghostPara.layout(const ui.ParagraphConstraints(width: double.infinity));

      final screenY =
          offset.dy +
          (innerPadding?.top ?? 0) +
          cursorY -
          vscrollController.offset;

      final screenX =
          offset.dx +
          _gutterWidth +
          (innerPadding?.left ?? 0) +
          cursorX -
          (lineWrap ? 0 : hscrollController.offset);

      final bgColor = editorTheme['root']?.backgroundColor ?? Colors.black;
      final originalPara = _paragraphCache[cursorLine];
      if (originalPara != null && multiClampedCol < lineText.length) {
        final remainingWidth = originalPara.longestLine - cursorX;
        if (remainingWidth > 0) {
          canvas.drawRect(
            Rect.fromLTWH(screenX, screenY, remainingWidth + 2, _lineHeight),
            Paint()..color = bgColor,
          );
        }
      }

      canvas.drawParagraph(ghostPara, Offset(screenX, screenY));
    }

    double lastGhostLineWidth = 0;
    double lastGhostLineScreenY = 0;
    double lastGhostLineScreenX = 0;

    for (int i = 1; i < ghostLines.length; i++) {
      final ghostLineText = ghostLines[i];
      final isLastLine = i == ghostLines.length - 1;

      final lineY = cursorY + (i * _lineHeight);

      final screenY =
          offset.dy +
          (innerPadding?.top ?? 0) +
          lineY -
          vscrollController.offset;

      final screenX =
          offset.dx +
          _gutterWidth +
          (innerPadding?.left ?? 0) -
          (lineWrap ? 0 : hscrollController.offset);

      if (screenY + _lineHeight < offset.dy ||
          screenY > offset.dy + vscrollController.position.viewportDimension) {
        if (isLastLine) {
          lastGhostLineScreenY = screenY;
          lastGhostLineScreenX = screenX;
        }
        continue;
      }

      if (ghostLineText.isNotEmpty || isLastLine) {
        final builder =
            ui.ParagraphBuilder(
                ui.ParagraphStyle(
                  fontFamily: textStyle?.fontFamily,
                  fontSize: textStyle?.fontSize ?? 14.0,
                  height: textStyle?.height ?? 1.2,
                ),
              )
              ..pushStyle(ghostStyle)
              ..addText(ghostLineText);

        final para = builder.build();
        para.layout(const ui.ParagraphConstraints(width: double.infinity));

        canvas.drawParagraph(para, Offset(screenX, screenY));

        if (isLastLine) {
          lastGhostLineWidth = para.longestLine;
          lastGhostLineScreenY = screenY;
          lastGhostLineScreenX = screenX;
        }
      }
    }

    if (multiClampedCol < lineText.length && ghostLines.length > 1) {
      final remainingText = lineText.substring(multiClampedCol);

      final normalStyle = ui.TextStyle(
        color: textStyle?.color ?? editorTheme['root']?.color ?? Colors.white,
        fontSize: textStyle?.fontSize ?? 14.0,
        fontFamily: textStyle?.fontFamily,
        fontWeight: textStyle?.fontWeight,
      );

      final remainingBuilder =
          ui.ParagraphBuilder(
              ui.ParagraphStyle(
                fontFamily: textStyle?.fontFamily,
                fontSize: textStyle?.fontSize ?? 14.0,
                height: textStyle?.height ?? 1.2,
              ),
            )
            ..pushStyle(normalStyle)
            ..addText(remainingText);

      final remainingPara = remainingBuilder.build();
      remainingPara.layout(
        const ui.ParagraphConstraints(width: double.infinity),
      );

      canvas.drawParagraph(
        remainingPara,
        Offset(lastGhostLineScreenX + lastGhostLineWidth, lastGhostLineScreenY),
      );
    }
  }

  @override
  void dispose() {
    controller.removeListener(onControllerChange);
    controller.setScrollCallback(null);
    syntaxHighlighter.dispose();
    super.dispose();
  }

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {
    final localPosition = event.localPosition;
    final clickY =
        localPosition.dy + vscrollController.offset - (innerPadding?.top ?? 0);
    currentPosition = localPosition;

    final contentPosition = Offset(
      localPosition.dx -
          gutterWidth -
          (innerPadding?.horizontal ??
              innerPadding?.left ??
              innerPadding?.right ??
              0) +
          (lineWrap ? 0 : hscrollController.offset),
      localPosition.dy -
          (innerPadding?.vertical ??
              innerPadding?.top ??
              innerPadding?.bottom ??
              0) +
          vscrollController.offset,
    );
    final textOffset = getTextOffsetFromPosition(contentPosition);

    if (event is PointerHoverEvent) {
      // Check for breakpoint hover
      if (enableGutter &&
          localPosition.dx >= 0 &&
          localPosition.dx < gutterWidth) {
        final fontSize = textStyle?.fontSize ?? 14.0;
        final breakpointColumnWidth = (gutterStyle.showBreakpoints)
            ? fontSize * 1.5
            : 0;
        if (gutterStyle.showBreakpoints &&
            localPosition.dx < breakpointColumnWidth) {
          final clickY =
              localPosition.dy -
              (innerPadding?.top ?? 0) +
              vscrollController.offset;
          final hoveredLine = findVisibleLineByYPosition(clickY);
          if (hoveredBreakpointLine != hoveredLine + 1) {
            hoveredBreakpointLine = hoveredLine + 1;
            markNeedsPaint();
          }
        } else {
          if (hoveredBreakpointLine != null) {
            hoveredBreakpointLine = null;
            markNeedsPaint();
          }
        }
      } else {
        // Pointer is outside gutter, clear hover state
        if (hoveredBreakpointLine != null) {
          hoveredBreakpointLine = null;
          markNeedsPaint();
        }
      }

      if (hoverNotifier.value == null) {
        hoverTimer?.cancel();
      }
      if (!(hoverNotifier.value != null && isHoveringPopup.value)) {
        hoverNotifier.value = null;
      }

      if ((hoverNotifier.value == null || !isHoveringPopup.value) &&
          isOffsetOverWord(textOffset)) {
        hoverTimer?.cancel();
        hoverTimer = Timer(Duration(milliseconds: 1500), () {
          final lineChar = offsetToLineChar(textOffset);
          hoverNotifier.value = [event.localPosition, lineChar];
        });
      } else {
        hoverTimer?.cancel();
        hoverNotifier.value = null;
      }
    }

    if ((event is PointerDownEvent && event.buttons == kSecondaryButton) ||
        (event is PointerUpEvent &&
            isMobile &&
            selectionActive &&
            controller.selection.start != controller.selection.end)) {
      contextMenuOffsetNotifier.value = localPosition;
      return;
    }

    if (event is PointerDownEvent && event.buttons == kPrimaryButton) {
      try {
        focusNode.requestFocus();
        suggestionNotifier.value = null;
        signatureNotifier.value = null;
      } catch (e) {
        debugPrint(e.toString());
      }
      if (contextMenuOffsetNotifier.value.dx >= 0) {
        contextMenuOffsetNotifier.value = const Offset(-1, -1);
      }

      if (lspActionNotifier.value != null && actionBulbRects.isNotEmpty) {
        for (final entry in actionBulbRects.entries) {
          if (entry.value.contains(localPosition)) {
            suggestionNotifier.value = null;
            lspActionOffsetNotifier.value = event.localPosition;
            return;
          }
        }
      }

      if (enableFolding && enableGutter && localPosition.dx < gutterWidth) {
        if (clickY < 0) return;
        final clickedLine = findVisibleLineByYPosition(clickY);

        final foldRange = getFoldRangeAtLine(clickedLine);
        if (foldRange != null) {
          toggleFold(foldRange);
          return;
        }
        return;
      }

      onetap.addPointer(event);
      if (isMobile) {
        dtap.addPointer(event);
        draggingCHandle = false;
        draggingStartHandle = false;
        draggingEndHandle = false;

        dtap.onDoubleTap = () {
          selectWordAtOffset(textOffset);
          contextMenuOffsetNotifier.value = localPosition;
        };

        onetap.onTap = () {
          if (hoverNotifier.value != null) {
            hoverNotifier.value = null;
          } else if (isOffsetOverWord(textOffset)) {
            final lineChar = offsetToLineChar(textOffset);
            hoverNotifier.value = [localPosition, lineChar];
          }
        };

        if (controller.selection.start != controller.selection.end) {
          if (startHandleRect?.contains(localPosition) ?? false) {
            draggingStartHandle = true;
            selectionActive = selectionActiveNotifier.value = true;
            pointerDownPosition = localPosition;
            return;
          }
          if (endHandleRect?.contains(localPosition) ?? false) {
            draggingEndHandle = true;
            selectionActive = selectionActiveNotifier.value = true;
            pointerDownPosition = localPosition;
            return;
          }
        } else if (controller.selection.isCollapsed && normalHandle != null) {
          final handleRadius = (lineHeight0 / 2).clamp(6.0, 12.0);
          final expandedHandle = normalHandle!.inflate(handleRadius * 1.5);
          if (expandedHandle.contains(localPosition)) {
            draggingCHandle = true;
            selectionActive = selectionActiveNotifier.value = true;
            dragStartOffset = textOffset;
            controller.selection = TextSelection.collapsed(offset: textOffset);
            pointerDownPosition = localPosition;
            return;
          }
        }

        dragStartOffset = textOffset;
        isDragging = false;
        pointerDownPosition = localPosition;
        selectionActive = false;
        selectionActiveNotifier.value = false;

        selectionTimer?.cancel();
        selectionTimer = Timer(const Duration(milliseconds: 500), () {
          selectWordAtOffset(textOffset);
        });
      } else {
        dtap.addPointer(event);
        dtap.onDoubleTap = () {
          selectWordAtOffset(textOffset);
          // contextMenuOffsetNotifier.value = localPosition;
        };

        dragStartOffset = textOffset;
        onetap.onTap = () {
          if (suggestionNotifier.value != null) {
            suggestionNotifier.value = null;
          }
          if (signatureNotifier.value != null) {
            signatureNotifier.value = null;
          }
          if (lspActionNotifier.value != null) {
            lspActionNotifier.value = null;
            lspActionOffsetNotifier.value = null;
          }
        };
        controller.selection = TextSelection.collapsed(offset: textOffset);
      }
    }

    if (event is PointerMoveEvent && dragStartOffset != null) {
      if (isMobile) {
        if (draggingCHandle) {
          controller.selection = TextSelection.collapsed(offset: textOffset);
          showBubble = true;
          markNeedsLayout();
          markNeedsPaint();
          return;
        }

        if (draggingStartHandle || draggingEndHandle) {
          final base = controller.selection.start;
          final extent = controller.selection.end;

          if (draggingStartHandle) {
            controller.selection = TextSelection(
              baseOffset: textOffset,
              extentOffset: extent,
            );
            if (textOffset > extent) {
              draggingStartHandle = false;
              draggingEndHandle = true;
            }
          } else {
            controller.selection = TextSelection(
              baseOffset: base,
              extentOffset: textOffset,
            );
            if (textOffset < base) {
              draggingEndHandle = false;
              draggingStartHandle = true;
            }
          }
          markNeedsLayout();
          markNeedsPaint();
          return;
        }

        if ((localPosition - (pointerDownPosition ?? localPosition)).distance >
            10) {
          isDragging = true;
          suggestionNotifier.value = null;

          selectionTimer?.cancel();
        }

        if (isDragging && !selectionActive) {
          return;
        }

        if (selectionActive) {
          controller.selection = TextSelection(
            baseOffset: dragStartOffset!,
            extentOffset: textOffset,
          );
        }
      } else {
        controller.selection = TextSelection(
          baseOffset: dragStartOffset!,
          extentOffset: textOffset,
        );
      }
    }

    if (event is PointerUpEvent || event is PointerCancelEvent) {
      if (!isDragging && isMobile && !selectionActive) {
        controller.selection = TextSelection.collapsed(offset: textOffset);
        controller.connection?.show();
      }

      draggingStartHandle = false;
      draggingEndHandle = false;
      draggingCHandle = false;
      pointerDownPosition = null;
      dragStartOffset = null;
      selectionTimer?.cancel();

      cachedMagnifiedParagraph = null;
      cachedMagnifiedLine = null;
      cachedMagnifiedOffset = null;
      selectionActive = selectionActiveNotifier.value = false;
      if (readOnly) return;
      if (!isDragging) {
        controller.notifyListeners();
      }

      isDragging = false;

      if (isMobile && controller.selection.isCollapsed) {
        showBubble = true;
        markNeedsPaint();
      }
    }
  }

  void selectWordAtOffset(int offset) {
    if (isMobile) {
      selectionActive = selectionActiveNotifier.value = true;
    }

    final text = controller.text;
    int start = offset, end = offset;

    while (start > 0 && !isWordBoundary(text[start - 1])) {
      start--;
    }
    while (end < text.length && !isWordBoundary(text[end])) {
      end++;
    }

    controller.selection = TextSelection(baseOffset: start, extentOffset: end);
    markNeedsPaint();
  }

  bool isWordBoundary(String char) {
    return char.trim().isEmpty || !RegExp(r'\w').hasMatch(char);
  }

  bool isOffsetOverWord(int offset) {
    final text = controller.text;
    if (offset < 0 || offset >= text.length) return false;
    return RegExp(r'\w').hasMatch(text[offset]);
  }

  Map<String, int> offsetToLineChar(int offset) {
    int accum = 0;
    for (int i = 0; i < controller.lineCount; i++) {
      final lineLen = controller.getLineText(i).length;
      if (offset >= accum && offset <= accum + lineLen) {
        return {'line': i, 'character': offset - accum};
      }
      accum += lineLen + 1;
    }
    final last = controller.lineCount - 1;
    return {'line': last, 'character': controller.getLineText(last).length};
  }

  @override
  MouseCursor get cursor {
    if (currentPosition.dx >= 0 && currentPosition.dx < gutterWidth) {
      final fontSize = textStyle?.fontSize ?? 14.0;
      final breakpointColumnWidth = (gutterStyle.showBreakpoints)
          ? fontSize * 1.5
          : 0;

      // Check if hovering over breakpoint column
      if (gutterStyle.showBreakpoints &&
          currentPosition.dx < breakpointColumnWidth) {
        return SystemMouseCursors.click;
      }

      if (foldRanges.isEmpty && !enableFolding) {
        return MouseCursor.defer;
      }

      final clickY =
          currentPosition.dy +
          vscrollController.offset -
          (innerPadding.top ?? 0);
      final hasActiveFolds = foldRanges.any((f) => f.isFolded);

      int hoveredLine;
      if (!hasActiveFolds && !lineWrap) {
        hoveredLine = (clickY / lineHeight0).floor().clamp(
          0,
          controller.lineCount - 1,
        );
      } else {
        hoveredLine = findVisibleLineByYPosition(clickY);
      }

      final foldRange = getFoldRangeAtLine(hoveredLine);
      if (foldRange != null) {
        return SystemMouseCursors.click;
      }

      if (actionBulbRects.isNotEmpty) {
        for (final rect in actionBulbRects.values) {
          if (rect.contains(currentPosition)) {
            return SystemMouseCursors.click;
          }
        }
      }

      return MouseCursor.defer;
    }
    return SystemMouseCursors.text;
  }

  @override
  PointerEnterEventListener? get onEnter => null;

  @override
  PointerExitEventListener? get onExit => (event) {
    hoverTimer?.cancel();
  };

  @override
  bool get validForMouseTracker => true;
}

/// Represents a foldable code region in the editor.
///
/// A fold range defines a region of code that can be collapsed (folded) to hide
/// its contents. This is typically used for code blocks like functions, classes,
/// or control structures.
///
/// Fold ranges are automatically detected based on code structure (braces,
/// indentation) when folding is enabled in the editor.
///
/// Example:
/// ```dart
/// // A fold range from line 5 to line 10
/// final foldRange = FoldRange(5, 10);
/// foldRange.isFolded = true; // Collapse the region
/// ```
class FoldRange {
  /// The starting line index (zero-based) of the fold range.
  ///
  /// This is the line where the fold indicator appears in the gutter.
  final int startIndex;

  /// The ending line index (zero-based) of the fold range.
  ///
  /// When folded, all lines from `startIndex + 1` to `endIndex` are hidden.
  final int endIndex;

  /// Whether this fold range is currently collapsed.
  ///
  /// When true, the contents of this range are hidden in the editor.
  bool isFolded = false;

  /// Child fold ranges that were originally folded when this range was unfolded.
  ///
  /// Used to restore the fold state of nested ranges when toggling folds.
  List<FoldRange> originallyFoldedChildren = [];

  /// Creates a [FoldRange] with the specified start and end line indices.
  FoldRange(this.startIndex, this.endIndex);

  /// Adds a child fold range that was originally folded.
  ///
  /// Used internally to track nested fold states.
  void addOriginallyFoldedChild(FoldRange child) {
    if (!originallyFoldedChildren.contains(child)) {
      originallyFoldedChildren.add(child);
    }
  }

  /// Clears the list of originally folded children.
  void clearOriginallyFoldedChildren() {
    originallyFoldedChildren.clear();
  }

  /// Checks if a line is contained within this fold range.
  ///
  /// Returns true if [line] is strictly greater than [startIndex] and
  /// less than or equal to [endIndex].
  bool containsLine(int line) {
    return line > startIndex && line <= endIndex;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FoldRange &&
        other.startIndex == startIndex &&
        other.endIndex == endIndex;
  }

  @override
  int get hashCode => startIndex.hashCode ^ endIndex.hashCode;
}
