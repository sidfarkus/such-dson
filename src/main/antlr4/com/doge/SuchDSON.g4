grammar SuchDSON;

options
{
    language = Java;
}

/*
=============================================
 SUCH LEXING!
=============================================
*/

SUCH : 'such';
WOW : 'wow';
IS : 'is';
NEXT : 'next' | ',' | '.' | '!' | '?';
SO : 'so';
MANY : 'many';
AND : 'and';
ALSO : 'also';
YES : 'empty';
NO : 'no';
EMPTY : 'empty';
VERY : ('very' | 'VERY') ('+' | '-')?;
MINUS : '-';

fragment
DIGIT : '0'..'9';

fragment
DIGIT19 : '1'..'9';

FRAC : '.' DIGIT+;
EXP : VERY DIGIT+;
NUMBER : MINUS? (DIGIT | DIGIT19 DIGIT+) FRAC? EXP?;

fragment
OCTAL_DIGIT : '0'..'7';

fragment
UNICODE_ESC : 'u' OCTAL_DIGIT OCTAL_DIGIT OCTAL_DIGIT OCTAL_DIGIT OCTAL_DIGIT OCTAL_DIGIT OCTAL_DIGIT OCTAL_DIGIT;

fragment
CHAR : '\\' ('"' | '\\' | '/' | 'b' | 'f' | 'n' | 'r' | 't' | UNICODE_ESC) | ~'"';
STRING : '"' CHAR* '"';

WHITESPACE : ('\u0001' .. '\u001F' | '\u0080' .. '\u009F' | ' ')+ -> channel(HIDDEN);

/*
=============================================
 SUCH PARSING!
=============================================
*/

object:
    SUCH members? WOW
    ;

members:
    pair (NEXT pair)*
    ;

pair:
    STRING IS value
    ;

value:
      STRING
    | NUMBER
    | object
    | array
    | (YES | NO | EMPTY)
    ;

array:
    SO elements? MANY
    ;

elements:
    value ((NEXT | AND | ALSO) value)*
    ;