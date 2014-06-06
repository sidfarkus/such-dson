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
NEXT : 'next';
SO : 'so';
MANY : 'many';
NOTFALSE : 'notfalse';
NOTTRUE : 'nottrue';
NULLISH : 'nullish';
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
HEX_DIGIT : ('0'..'9'|'a'..'f'|'A'..'F') ;

fragment
CHAR : '\\' ('"' | '\\' | '/' | 'b' | 'f' | 'n' | 'r' | 't' | 'u' HEX_DIGIT HEX_DIGIT HEX_DIGIT HEX_DIGIT) | ~'"';
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
    | (NOTFALSE | NOTTRUE | NULLISH)
    ;

array:
    SO elements? MANY
    ;

elements:
    value (NEXT value)*
    ;