import 'package:code_forge/code_forge.dart';
import 'package:code_forge/code_forge/controller.dart';
import 'package:code_forge/code_forge/suggestion_model.dart';
import 'package:code_forge/code_forge/suggestions/get_sql_suggestions.dart';
import 'package:code_forge/code_forge/suggestions/get_cpp_suggestions.dart';
import 'package:code_forge/code_forge/suggestions/get_csharp_suggestions.dart';
import 'package:code_forge/code_forge/suggestions/get_css_suggestions.dart';
import 'package:code_forge/code_forge/suggestions/get_dart_suggestions.dart';
import 'package:code_forge/code_forge/suggestions/get_go_suggestions.dart';
import 'package:code_forge/code_forge/suggestions/get_html_suggestions.dart';
import 'package:code_forge/code_forge/suggestions/get_java_script_suggestions.dart';
import 'package:code_forge/code_forge/suggestions/get_java_suggestions.dart';
import 'package:code_forge/code_forge/suggestions/get_jinja_suggestions.dart';
import 'package:code_forge/code_forge/suggestions/get_json_suggestions.dart';
import 'package:code_forge/code_forge/suggestions/get_kotlin_suggestions.dart';
import 'package:code_forge/code_forge/suggestions/get_markdown_suggestions.dart';
import 'package:code_forge/code_forge/suggestions/get_php_suggestions.dart';
import 'package:code_forge/code_forge/suggestions/get_python_suggestions.dart';
import 'package:code_forge/code_forge/suggestions/get_ruby_suggestions.dart';
import 'package:code_forge/code_forge/suggestions/get_rust_suggestions.dart';
import 'package:code_forge/code_forge/suggestions/get_shell_suggestions.dart';
import 'package:code_forge/code_forge/suggestions/get_swift_suggestions.dart';
import 'package:code_forge/code_forge/suggestions/get_xml_suggestions.dart';
import 'package:code_forge/code_forge/suggestions/get_yaml_suggestions.dart';
import 'package:re_highlight/re_highlight.dart';

void initializeLanguageSpecificSuggestions({
  required Mode currentLanguage,
  required void Function(List<SuggestionModel> suggestions)
  registerCustomSuggestions,
}) {
  final suggestions = <SuggestionModel>[];

  // Always register JINJA suggestions regardless of language
  suggestions.addAll(getJinjaSuggestions());

  // Add language-specific suggestions
  final langName = currentLanguage.name?.toLowerCase();
  if (langName != null) {
    switch (langName) {
      case 'html':
        suggestions.addAll(getHtmlSuggestions());
        break;
      case 'json':
        suggestions.addAll(getJsonSuggestions());
        break;
      case 'sql':
        suggestions.addAll(getSqlSuggestions());
        break;
      case 'dart':
        suggestions.addAll(getDartSuggestions());
        break;
      case 'python':
        suggestions.addAll(getPythonSuggestions());
        break;
      case 'javascript':
      case 'typescript':
        suggestions.addAll(getJavaScriptSuggestions());
        break;
      case 'css':
        suggestions.addAll(getCssSuggestions());
        break;
      case 'markdown':
        suggestions.addAll(getMarkdownSuggestions());
        break;
      case 'yaml':
        suggestions.addAll(getYamlSuggestions());
        break;
      case 'xml':
        suggestions.addAll(getXmlSuggestions());
        break;
      case 'bash':
      case 'shell':
        suggestions.addAll(getShellSuggestions());
        break;
      case 'c':
      case 'cpp':
        suggestions.addAll(getCppSuggestions());
        break;
      case 'java':
        suggestions.addAll(getJavaSuggestions());
        break;
      case 'go':
        suggestions.addAll(getGoSuggestions());
        break;
      case 'rust':
        suggestions.addAll(getRustSuggestions());
        break;
      case 'php':
        suggestions.addAll(getPhpSuggestions());
        break;
      case 'ruby':
        suggestions.addAll(getRubySuggestions());
        break;
      case 'swift':
        suggestions.addAll(getSwiftSuggestions());
        break;
      case 'kotlin':
        suggestions.addAll(getKotlinSuggestions());
        break;
      case 'csharp':
        suggestions.addAll(getCsharpSuggestions());
        break;
      default:
        // For other languages, only include JINJA suggestions
        break;
    }
  }

  registerCustomSuggestions(suggestions);
}
