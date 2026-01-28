# Examples

## 1. Read-Only Sections
Ideal for tutorials where students fill in the blanks.

```dart
final code = '''
void main() {
  // [START locked_setup]
  setupEnvironment();
  initDatabase();
  // [END locked_setup]
  
  // Student writes code here:
  print("Hello");
  
  // [START locked_teardown]
  closeAll();
  // [END locked_teardown]
}
''';

final controller = CodeController(
  text: code,
  language: dart,
  namedSectionParser: const BracketsStartEndNamedSectionParser(),
);

// Lock the setup and teardown
controller.readOnlySectionNames = {'locked_setup', 'locked_teardown'};
```

## 2. Custom Analyzer
A simple analyzer that forbids the word "TODO".

```dart
class TodoForbiddenAnalyzer extends AbstractAnalyzer {
  @override
  Future<AnalysisResult> analyze(Code code) async {
    final issues = <Issue>[];
    final lines = code.lines.lines;
    
    for (int i = 0; i < lines.length; i++) {
      if (lines[i].text.contains('TODO')) {
        issues.add(
          Issue(
            line: i,
            message: 'TODOs are not allowed in production!',
            type: IssueType.error,
          ),
        );
      }
    }
    
    return AnalysisResult(issues: issues);
  }
}

// Usage
final controller = CodeController(
  text: '...',
  analyzer: TodoForbiddenAnalyzer(),
);
```

