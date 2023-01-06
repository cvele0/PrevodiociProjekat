// import section
import java_cup.runtime.*;

%%
// declaration section
%class MPLexer
%cup
%line
%column
%eofval{
return new Symbol( sym.EOF, yyline, new MyVal(null,null,yyline));
%eofval}

// states
%state COMMENT
// macros
slovo = [a-zA-Z]
cifra = [0-9]
oc16 = [0-9A-F]
%%
// rules section
\(\* { yybegin( COMMENT ); }
<COMMENT>\*\) { yybegin( YYINITIAL ); }

[\t\n\r ] { ; }
\( { return new Symbol( sym.OPENP, yyline, new MyVal(yytext(),yytext(),yyline) ); }
\) { return new Symbol( sym.CLOSEP, yyline, new MyVal(yytext(),yytext(),yyline) ); }
\{ { return new Symbol( sym.OPENB, yyline, new MyVal(yytext(),yytext(),yyline) ); }
\} { return new Symbol( sym.CLOSEB, yyline, new MyVal(yytext(),yytext(),yyline) ); }

// operators
&& { return new Symbol( sym.AND, yyline, new MyVal(yytext(),yytext(),yyline) ); }
\|\| { return new Symbol( sym.OR,yyline, new MyVal(yytext(),yytext(),yyline) ); }
\+ { return new Symbol( sym.PLUS, yyline, new MyVal(yytext(),yytext(),yyline) ); }
\* { return new Symbol( sym.MULT, yyline, new MyVal(yytext(),yytext(),yyline) ); }
\- { return new Symbol( sym.MINUS, yyline, new MyVal(yytext(),yytext(),yyline) ); }
\/  { return new Symbol( sym.DIV, yyline, new MyVal(yytext(),yytext(),yyline) ); }
\< { return new Symbol( sym.LESS, yyline, new MyVal(yytext(),yytext(),yyline) ); }
\<= { return new Symbol( sym.LESSEQ, yyline, new MyVal(yytext(),yytext(),yyline) ); }
\> { return new Symbol( sym.GRET, yyline, new MyVal(yytext(),yytext(),yyline) ); }
\>= { return new Symbol( sym.GRETEQ, yyline, new MyVal(yytext(),yytext(),yyline) ); }
== { return new Symbol( sym.ISEQ, yyline, new MyVal(yytext(),yytext(),yyline) ); }
\!= { return new Symbol( sym.DIFF, yyline, new MyVal(yytext(),yytext(),yyline) ); }
// separators
; { return new Symbol( sym.SEMICOL, yyline, new MyVal(yytext(),yytext(),yyline) ); }
, { return new Symbol( sym.COMMA, yyline, new MyVal(yytext(),yytext(),yyline) ); }
= { return new Symbol( sym.ASGN, yyline, new MyVal(yytext(),yytext(),yyline) ); }
: { return new Symbol( sym.COL, yyline, new MyVal(yytext(),yytext(),yyline) ); }

// keywords
"main"  {return new Symbol(sym.MAIN, yyline, new MyVal(yytext(),yytext(),yyline) );}
"int"  {return new Symbol(sym.INT, yyline, new MyVal(yytext(),yytext(),yyline) );}
"char"  {return new Symbol(sym.CHAR, yyline, new MyVal(yytext(),yytext(),yyline) );}
"real"  {return new Symbol(sym.REAL, yyline, new MyVal(yytext(),yytext(),yyline) );}
"bool"  {return new Symbol(sym.BOOL, yyline, new MyVal(yytext(),yytext(),yyline) );}
"repeat"  {return new Symbol(sym.REPEAT, yyline, new MyVal(yytext(),yytext(),yyline) );}
"until"  {return new Symbol(sym.UNTIL, yyline, new MyVal(yytext(),yytext(),yyline) );}
"read"  {return new Symbol(sym.READ, yyline, new MyVal(yytext(),yytext(),yyline) );}
"write"  {return new Symbol(sym.WRITE, yyline, new MyVal(yytext(),yytext(),yyline) );}

"true"  { return new Symbol( sym.BOOLCONST, yyline, new MyVal(yytext(),yytext(),yyline) ); }
"false" { return new Symbol( sym.BOOLCONST, yyline, new MyVal(yytext(),yytext(),yyline) ); }
//id-s
({slovo} | _)({slovo}|{cifra}| _ )* { return new Symbol(sym.ID,yyline, new MyVal(yytext(),yytext(),yyline) ); }
// constants
{cifra}+ { return new Symbol( sym.INTCONST,  yyline, new MyVal(yytext(),yytext(),yyline) ); }
\${oc16}+ { return new Symbol( sym.INTCONST,  yyline, new MyVal(yytext(),yytext(),yyline) ); }
{cifra}+\.{cifra}+(E[+\-]{cifra}+)? { return new Symbol( sym.REALCONST, yyline, new MyVal(yytext(),yytext(),yyline) );}
'[^]' { return new Symbol( sym.CHARCONST, yyline, new MyVal(yytext(),yytext(),yyline) ); }
// error symbol
. { if (yytext() != null && yytext().length() > 0) System.out.println( "ERROR: " + yytext() ); }