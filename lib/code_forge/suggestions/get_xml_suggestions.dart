import 'package:code_forge/code_forge/suggestion_model.dart';

/// Returns XML-specific suggestions.
List<SuggestionModel> getXmlSuggestions() {
  return [
    SuggestionModel(
      label: 'Element',
      description: 'Insert an XML element',
      replacedOnClick: '<element>\n  \n</element>',
      openingTag: '<',
      closingTag: '>',
    ),
    SuggestionModel(
      label: 'Self-closing Element',
      description: 'Insert a self-closing XML element',
      replacedOnClick: '<element />',
      openingTag: '<',
      closingTag: '>',
    ),
    SuggestionModel(
      label: 'Element with Attribute',
      description: 'Insert an XML element with attribute',
      replacedOnClick: '<element attribute="value">\n  \n</element>',
      openingTag: '<',
      closingTag: '>',
    ),
    SuggestionModel(
      label: 'Multiple Attributes',
      description: 'Insert an XML element with multiple attributes',
      replacedOnClick:
          '<element attr1="value1" attr2="value2">\n  \n</element>',
      openingTag: '<',
      closingTag: '>',
    ),
    SuggestionModel(
      label: 'CDATA Section',
      description: 'Insert a CDATA section',
      replacedOnClick: '<![CDATA[\n  content here\n]]>',
      openingTag: '<!',
      closingTag: '>',
    ),
    SuggestionModel(
      label: 'XML Declaration',
      description: 'Insert an XML declaration',
      replacedOnClick: '<?xml version="1.0" encoding="UTF-8"?>',
      openingTag: '<?xml',
      closingTag: '>',
    ),
    SuggestionModel(
      label: 'Processing Instruction',
      description: 'Insert a processing instruction',
      replacedOnClick: '<?target data?>',
      openingTag: '<?',
      closingTag: '>',
    ),
    SuggestionModel(
      label: 'Comment',
      description: 'Insert an XML comment',
      replacedOnClick: '<!-- Comment -->',
      openingTag: '<!--',
      closingTag: '>',
    ),
    SuggestionModel(
      label: 'Namespace',
      description: 'Insert an XML element with namespace',
      replacedOnClick:
          '<prefix:element xmlns:prefix="namespace">\n  \n</prefix:element>',
      openingTag: '<',
      closingTag: '>',
    ),
    SuggestionModel(
      label: 'Entity Reference',
      description: 'Insert an XML entity reference',
      replacedOnClick: '&entity;',
      openingTag: '&',
      closingTag: '>',
    ),
    SuggestionModel(
      label: 'Character Reference',
      description: 'Insert an XML character reference',
      replacedOnClick: '&#123;',
      openingTag: '&#',
      closingTag: '>',
    ),
    SuggestionModel(
      label: 'DTD Declaration',
      description: 'Insert a DTD declaration',
      replacedOnClick: '<!DOCTYPE root SYSTEM "file.dtd">',
      openingTag: '<!DOCTYPE',
      closingTag: '>',
    ),
    SuggestionModel(
      label: 'Element Declaration',
      description: 'Insert a DTD element declaration',
      replacedOnClick: '<!ELEMENT element (#PCDATA)>',
      openingTag: '<!ELEMENT',
      closingTag: '>',
    ),
    SuggestionModel(
      label: 'Attribute Declaration',
      description: 'Insert a DTD attribute declaration',
      replacedOnClick: '<!ATTLIST element attribute CDATA #REQUIRED>',
      openingTag: '<!ATTLIST',
      closingTag: '>',
    ),
  ];
}
