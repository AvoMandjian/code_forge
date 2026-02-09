import 'package:code_forge/code_forge/suggestion_model.dart';

/// Returns CSS-specific suggestions.
List<SuggestionModel> getCssSuggestions() {
  return [
    SuggestionModel(
      label: 'Class Selector',
      description: 'Insert a CSS class selector',
      replacedOnClick: '.class-name {\n  \n}',
      triggeredAt: '.',
    ),
    SuggestionModel(
      label: 'ID Selector',
      description: 'Insert a CSS ID selector',
      replacedOnClick: '#id-name {\n  \n}',
      triggeredAt: '#',
    ),
    SuggestionModel(
      label: 'Element Selector',
      description: 'Insert an element selector',
      replacedOnClick: 'element {\n  \n}',
      triggeredAt: 'element',
    ),
    SuggestionModel(
      label: 'Attribute Selector',
      description: 'Insert an attribute selector',
      replacedOnClick: '[attribute="value"] {\n  \n}',
      triggeredAt: '[',
    ),
    SuggestionModel(
      label: 'Pseudo-class',
      description: 'Insert a pseudo-class selector',
      replacedOnClick: ':hover {\n  \n}',
      triggeredAt: ':',
    ),
    SuggestionModel(
      label: 'Pseudo-element',
      description: 'Insert a pseudo-element',
      replacedOnClick: '::before {\n  content: "";\n}',
      triggeredAt: '::',
    ),
    SuggestionModel(
      label: 'Media Query',
      description: 'Insert a CSS media query',
      replacedOnClick: '@media (max-width: 768px) {\n  \n}',
      triggeredAt: '@media',
    ),
    SuggestionModel(
      label: 'Keyframes',
      description: 'Insert CSS keyframes animation',
      replacedOnClick: '@keyframes animationName {\n  0% { }\n  100% { }\n}',
      triggeredAt: '@keyframes',
    ),
    SuggestionModel(
      label: 'Import',
      description: 'Insert a CSS import statement',
      replacedOnClick: '@import url("style.css");',
      triggeredAt: '@import',
    ),
    SuggestionModel(
      label: 'Flexbox',
      description: 'Insert flexbox display property',
      replacedOnClick:
          'display: flex;\nflex-direction: row;\njustify-content: center;\nalign-items: center;',
      triggeredAt: 'display',
    ),
    SuggestionModel(
      label: 'Grid',
      description: 'Insert CSS Grid layout',
      replacedOnClick: 'display: grid;\ngrid-template-columns: repeat(3, 1fr);',
      triggeredAt: 'display',
    ),
    SuggestionModel(
      label: 'Position Absolute',
      description: 'Insert absolute positioning',
      replacedOnClick: 'position: absolute;\ntop: 0;\nleft: 0;',
      triggeredAt: 'position',
    ),
    SuggestionModel(
      label: 'Position Relative',
      description: 'Insert relative positioning',
      replacedOnClick: 'position: relative;',
      triggeredAt: 'position',
    ),
    SuggestionModel(
      label: 'Position Fixed',
      description: 'Insert fixed positioning',
      replacedOnClick: 'position: fixed;\ntop: 0;\nleft: 0;',
      triggeredAt: 'position',
    ),
    SuggestionModel(
      label: 'Transform',
      description: 'Insert CSS transform',
      replacedOnClick: 'transform: translateX(0);',
      triggeredAt: 'transform',
    ),
    SuggestionModel(
      label: 'Transition',
      description: 'Insert CSS transition',
      replacedOnClick: 'transition: property 0.3s ease;',
      triggeredAt: 'transition',
    ),
    SuggestionModel(
      label: 'Animation',
      description: 'Insert CSS animation',
      replacedOnClick: 'animation: animationName 1s ease infinite;',
      triggeredAt: 'animation',
    ),
    SuggestionModel(
      label: 'Box Shadow',
      description: 'Insert box shadow',
      replacedOnClick: 'box-shadow: 0 2px 4px rgba(0,0,0,0.1);',
      triggeredAt: 'box-shadow',
    ),
    SuggestionModel(
      label: 'Border Radius',
      description: 'Insert border radius',
      replacedOnClick: 'border-radius: 4px;',
      triggeredAt: 'border-radius',
    ),
    SuggestionModel(
      label: 'Gradient',
      description: 'Insert linear gradient',
      replacedOnClick: 'background: linear-gradient(to right, #000, #fff);',
      triggeredAt: 'background',
    ),
    SuggestionModel(
      label: 'Variable',
      description: 'Insert CSS custom property',
      replacedOnClick: '--variable-name: value;',
      triggeredAt: '--',
    ),
    SuggestionModel(
      label: 'Calc',
      description: 'Insert CSS calc function',
      replacedOnClick: 'width: calc(100% - 20px);',
      triggeredAt: 'calc',
    ),
  ];
}
