import 'package:code_forge/code_forge.dart';
import 'package:code_forge/code_forge/controller.dart';
import 'package:code_forge/code_forge/suggestion_model.dart';

/// Returns Shell/Bash-specific suggestions.
List<SuggestionModel> getShellSuggestions() {
  return [
    SuggestionModel(
      label: 'If Statement',
      description: 'Insert a bash if statement',
      replacedOnClick: 'if [ condition ]; then\n  \nfi',
      triggeredAt: 'if',
    ),
    SuggestionModel(
      label: 'If-Else',
      description: 'Insert a bash if-else statement',
      replacedOnClick: 'if [ condition ]; then\n  \nelse\n  \nfi',
      triggeredAt: 'if',
    ),
    SuggestionModel(
      label: 'If-Elif-Else',
      description: 'Insert a bash if-elif-else statement',
      replacedOnClick:
          'if [ condition ]; then\n  \nelif [ condition ]; then\n  \nelse\n  \nfi',
      triggeredAt: 'if',
    ),
    SuggestionModel(
      label: 'For Loop',
      description: 'Insert a bash for loop',
      replacedOnClick: 'for item in list; do\n  \ndone',
      triggeredAt: 'for',
    ),
    SuggestionModel(
      label: 'C-Style For Loop',
      description: 'Insert a C-style bash for loop',
      replacedOnClick: 'for ((i=0; i<10; i++)); do\n  \ndone',
      triggeredAt: 'for',
    ),
    SuggestionModel(
      label: 'While Loop',
      description: 'Insert a bash while loop',
      replacedOnClick: 'while [ condition ]; do\n  \ndone',
      triggeredAt: 'while',
    ),
    SuggestionModel(
      label: 'Until Loop',
      description: 'Insert a bash until loop',
      replacedOnClick: 'until [ condition ]; do\n  \ndone',
      triggeredAt: 'until',
    ),
    SuggestionModel(
      label: 'Function',
      description: 'Insert a bash function',
      replacedOnClick: 'function_name() {\n  \n}',
      triggeredAt: 'function',
    ),
    SuggestionModel(
      label: 'Case Statement',
      description: 'Insert a bash case statement',
      replacedOnClick: 'case \$variable in\n  pattern)\n    \n    ;;\nesac',
      triggeredAt: 'case',
    ),
    SuggestionModel(
      label: 'Select Statement',
      description: 'Insert a bash select statement',
      replacedOnClick: 'select option in list; do\n  \ndone',
      triggeredAt: 'select',
    ),
    SuggestionModel(
      label: 'Test Command',
      description: 'Insert a bash test command',
      replacedOnClick: 'test condition',
      triggeredAt: 'test',
    ),
    SuggestionModel(
      label: 'Echo',
      description: 'Insert a bash echo command',
      replacedOnClick: 'echo "text"',
      triggeredAt: 'echo',
    ),
    SuggestionModel(
      label: 'Read Input',
      description: 'Insert a bash read command',
      replacedOnClick: 'read -p "Prompt: " variable',
      triggeredAt: 'read',
    ),
    SuggestionModel(
      label: 'Variable Assignment',
      description: 'Insert a bash variable assignment',
      replacedOnClick: 'VARIABLE="value"',
      triggeredAt: 'VARIABLE',
    ),
    SuggestionModel(
      label: 'Array',
      description: 'Insert a bash array',
      replacedOnClick: 'array=("item1" "item2" "item3")',
      triggeredAt: 'array',
    ),
    SuggestionModel(
      label: 'Array Access',
      description: 'Insert bash array access',
      replacedOnClick: '\${array[0]}',
      triggeredAt: '\${',
    ),
    SuggestionModel(
      label: 'Command Substitution',
      description: 'Insert bash command substitution',
      replacedOnClick: '\$(command)',
      triggeredAt: '\$(',
    ),
    SuggestionModel(
      label: 'Arithmetic Expansion',
      description: 'Insert bash arithmetic expansion',
      replacedOnClick: '\$((expression))',
      triggeredAt: '\$((',
    ),
    SuggestionModel(
      label: 'Here Document',
      description: 'Insert a bash here document',
      replacedOnClick: 'command << EOF\n  text\nEOF',
      triggeredAt: '<<',
    ),
    SuggestionModel(
      label: 'Trap',
      description: 'Insert a bash trap command',
      replacedOnClick: 'trap "command" SIGNAL',
      triggeredAt: 'trap',
    ),
    SuggestionModel(
      label: 'Function with Parameters',
      description: 'Insert a bash function with parameters',
      replacedOnClick:
          'function_name() {\n  local param1=\$1\n  local param2=\$2\n}',
      triggeredAt: 'function',
    ),
  ];
}
