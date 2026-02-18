import 'package:code_forge/code_forge.dart';
import 'package:code_forge/code_forge/suggestion_model.dart';
import 'package:example/finder.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:re_highlight/languages/dart.dart';
import 'package:re_highlight/styles/atom-one-dark-reasonable.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final undoController = UndoRedoController();
  // final absFilePath = p.join(Directory.current.path, "lib/example_code.dart");
  CodeForgeController? codeController;

  // Future<LspConfig> getLsp() async {
  //   final absWorkspacePath = p.join(Directory.current.path, "lib");
  //   final data = await LspStdioConfig.start(
  //     executable: "dart",
  //     args: ["language-server", "--protocol=lsp"],
  //     workspacePath: absWorkspacePath,
  //     languageId: "dart",
  //   );
  //   return data;
  // }

  @override
  void initState() {
    super.initState();
    codeController = CodeForgeController();
    codeController!.onCodeChanged = (String newText) {
      debugPrint('Code changed: $newText');
    };
    codeController!.onBreakpointsChanged((Set<int> breakpoints) {
      debugPrint('Breakpoints changed: $breakpoints');
    });
    codeController?.addCustomSuggestions([
      SuggestionModel(
        isCustom: true,
        label: "THIS IS A TEST",
        replacedOnClick: "print('Hello, world!');",
        openingTag: "{{",
        closingTag: "}}",
      ),
    ]);

    Future.delayed(const Duration(seconds: 2), () {
      codeController?.addCustomSuggestions([
        SuggestionModel(
          isCustom: true,
          label: "THIS IS ADDED AFTER 2 SECONDS",
          replacedOnClick: "print('Hello, world!');",
          openingTag: "{{",
          closingTag: "}}",
        ),
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Demonstrate breakpoint API
            if (codeController!.breakpoints.isEmpty) {
              // Add some breakpoints
              codeController?.setBreakpoints({3, 7, 12});
            } else {
              // Clear breakpoints
              codeController?.clearBreakpoints();
            }
          },
          child: const Icon(Icons.bug_report),
        ),
        body: SafeArea(
          child: CodeForge(
            undoController: undoController,
            language: langDart,
            editorTheme: atomOneDarkReasonableTheme,
            controller: codeController,
            textStyle: GoogleFonts.jetBrainsMono(),
            matchHighlightStyle: const MatchHighlightStyle(
              currentMatchStyle: TextStyle(backgroundColor: Color(0xFFFFA726)),
              otherMatchStyle: TextStyle(backgroundColor: Color(0x55FFFF00)),
            ),
            finderBuilder: (c, controller) =>
                FindPanelView(controller: controller),
            onBreakpointsChanged: (Set<int> breakpoints) {
              debugPrint('Breakpoints from widget callback: $breakpoints');
            },
          ),
        ),
      ),
    );
  }
}
