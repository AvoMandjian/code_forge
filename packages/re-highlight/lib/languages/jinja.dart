// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:re_highlight/re_highlight.dart';

final langJinja = Mode(
    refs: {
      '~contains~1~contains~0~contains~0': Mode(
          scope: 'string',
          variants: <Mode>[
            Mode(begin: "'", end: "'"),
            Mode(begin: "\"", end: "\"")
          ]),
      '~contains~1~contains~0~contains~1':
          Mode(scope: 'number', match: "\\d+"),
      '~contains~1~contains~0': Mode(
          match: "\\|(?=[A-Za-z_]+:?)",
          beginScope: 'punctuation',
          relevance: 0,
          contains: <Mode>[
            Mode(match: "[A-Za-z_]+:?", keywords: [
              "abs",
              "attr",
              "batch",
              "capitalize",
              "center",
              "count",
              "d",
              "default",
              "dictsort",
              "escape",
              "filesizeformat",
              "first",
              "float",
              "forceescape",
              "format",
              "groupby",
              "indent",
              "int",
              "join",
              "last",
              "length",
              "list",
              "lower",
              "map",
              "pprint",
              "random",
              "reject",
              "rejectattr",
              "replace",
              "reverse",
              "round",
              "safe",
              "select",
              "selectattr",
              "slice",
              "sort",
              "string",
              "striptags",
              "sum",
              "title",
              "trim",
              "truncate",
              "unique",
              "upper",
              "urlencode",
              "urlize",
              "wordcount",
              "wordwrap",
              "xmlattr"
            ])
          ]),
      '~contains~1': Mode(
          beginKeywords:
              "and as call endcall endfilter endfor endif endmacro endraw endset endwith filter for from if import include macro raw set with",
          keywords: {
            "name": [
              "and",
              "as",
              "call",
              "endcall",
              "endfilter",
              "endfor",
              "endif",
              "endmacro",
              "endraw",
              "endset",
              "endwith",
              "filter",
              "for",
              "from",
              "if",
              "import",
              "include",
              "macro",
              "raw",
              "set",
              "with"
            ]
          },
          relevance: 0,
          contains: <Mode>[
            Mode(
                begin: "\\(",
                end: "\\)",
                excludeBegin: true,
                excludeEnd: true,
                contains: <Mode>[
                  Mode(scope: 'string', variants: <Mode>[
                    Mode(begin: "'", end: "'"),
                    Mode(begin: "\"", end: "\"")
                  ]),
                  Mode(scope: 'number', match: "\\d+")
                ])
          ])
    },
    name: "Jinja",
    aliases: ["jinja2", "j2"],
    caseInsensitive: true,
    subLanguage: "xml",
    contains: <Mode>[
      Mode(scope: 'comment', begin: "\\{#", end: "#\\}", contains: <Mode>[
        Mode(
            scope: 'doctag',
            begin: "[ ]*(?=(TODO|FIXME|NOTE|BUG|OPTIMIZE|HACK|XXX):)",
            end: "(TODO|FIXME|NOTE|BUG|OPTIMIZE|HACK|XXX):",
            excludeBegin: true,
            relevance: 0),
        Mode(
            begin:
                "[ ]+((?:I|a|is|so|us|to|at|if|in|it|on|[A-Za-z]+['](d|ve|re|ll|t|s|n)|[A-Za-z]+[-][a-z]+|[A-Za-z][a-z]{2,})[.]?[:]?([.][ ]|[ ])){3}")
      ]),
      Mode(
          beginScope: <int, String>{
            1: 'template-tag',
            3: 'name',
          },
          relevance: 2,
          endScope: 'template-tag',
          begin: [
            "\\{%",
            "\\s*",
            "(?:and|as|call|endcall|endfilter|endfor|endif|endmacro|endraw|endset|endwith|filter|for|from|if|import|include|macro|raw|set|with)"
          ],
          end: "%\\}",
          keywords: "in",
          contains: <Mode>[
            Mode(ref: '~contains~1~contains~0'),
            Mode(ref: '~contains~1'),
            Mode(ref: '~contains~1~contains~0~contains~0'),
            Mode(ref: '~contains~1~contains~0~contains~1')
          ]),
      Mode(
          beginScope: <int, String>{
            1: 'template-tag',
            3: 'name',
          },
          relevance: 1,
          endScope: 'template-tag',
          begin: ["\\{%", "\\s*", "(?:[a-z_]+)"],
          end: "%\\}",
          keywords: "in",
          contains: <Mode>[
            Mode(ref: '~contains~1~contains~0'),
            Mode(ref: '~contains~1'),
            Mode(ref: '~contains~1~contains~0~contains~0'),
            Mode(ref: '~contains~1~contains~0~contains~1')
          ]),
      Mode(
          className: 'template-variable',
          begin: "\\{\\{",
          end: "\\}\\}",
          contains: <Mode>[
            Mode(self: true),
            Mode(ref: '~contains~1~contains~0'),
            Mode(ref: '~contains~1'),
            Mode(ref: '~contains~1~contains~0~contains~0'),
            Mode(ref: '~contains~1~contains~0~contains~1')
          ])
    ]);

