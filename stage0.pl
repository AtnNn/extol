% Generated by extoltoprolog
:-set_prolog_flag(singleton_warning,off).
:-op(999,fx,tc).
:-op(1200,fy,test).
:-discontiguous((test)/1).
:-discontiguous(type/1).
:-discontiguous(typed/1).
t(A):-write('trace: '),ti,writeq(A),nl.
t(A,B,B):-write('trace: '),ti,writeq(A),write(', at: '),pretty_init(B,C),write(C),nl,!.
pretty_init(A,B):-copy_term(A,C),(length(D,32),append(D,E,C);D=C),!,prep_chars(D,F,[]),length(F,G),(G<10->append(F,[60,101,111,102,62],H);H=F),atom_codes(B,H).
prep_chars([],A,B):-A=B.
prep_chars([A|B],C,D):-prep_char(A,C,E),prep_chars(B,E,D).
prep_char(A,B,C):-(var(A),B=D),(!,D=E),append([60,63,62],C,E).
prep_char(10,A,B):-(!,A=C),append([60,110,108,62],B,C).
prep_char(13,A,B):-(!,A=C),append([60,99,114,62],B,C).
prep_char(9,A,B):-(!,A=C),append([60,116,97,98,62],B,C).
prep_char(60,A,B):-(!,A=C),append([60,108,116,62],B,C).
prep_char(A,B,C):-(((\+integer(A);A<32;A>126),!,open_output_codes_stream(D),write(D,A),close_output_codes_stream(D,E)),B=F),append([60],G,F),dcg_call(E,G,H),append([62],I,H),!,I=C.
prep_char(A,B,C):-append([A],C,B).
tf(A):-t(A),fail.
tf(A,B,C):-tf(A,B,C),fail.
tc A:-undo(t(failed(A))),t(enter(A)),ticall(A),undo(t(redo(A))),t(exit(A)).
tc(A,B,C):-undo(t(failed(A)),B,D),t(enter(A),D,E),ticall(A,E,F),undo(t(redo(A)),F,G),t(exit(A),G,C).
tc(A,B,C,D):-undo(t(failed(A)),C,E),t(enter(A),E,F),ticall(A,B,F,G),undo(t(redo(A)),G,H),t(exit(A),H,D).
ti:-A=[124,32,46,32,46,32|A],g_read(tindent,B),C is B*2,length(D,C),append(D,E,A),atom_codes(F,D),write(F).
ticall(A):-g_read(tindent,B),C is B+1,g_assignb(tindent,C),call(A),g_assignb(tindent,B).
ticall(A,B,C):-g_read(tindent,D),E is D+1,g_assignb(tindent,E),dcg_call(A,B,C),g_assignb(tindent,D).
ticall(A,B,C,D):-g_read(tindent,E),F is E+1,g_assignb(tindent,F),A=..G,append(G,[B],H),I=..H,dcg_call(I,C,D),g_assignb(tindent,E).
undo(A).
undo(A):-call(A),fail.
undo(A,B,B).
undo(A,B,C):-call(A,B,C),fail.
type(callable(A)):-opaque.
type(stream(A)):-opaque.
type(byte(A)):-number(A).
type(list(A,B)):-maplist(A,B).
type(bytes(A)):-list(byte,A).
typed(read_bytes(+stream,-bytes)).
read_bytes(A,[]):-at_end_of_stream(A),!.
read_bytes(A,[B|C]):-get_byte(A,B),read_bytes(A,C).
typed(write_bytes(+stream,+bytes)).
write_bytes(A,[]).
write_bytes(A,[B|C]):-put_byte(A,B),write_bytes(A,C).
typed(read_file(+atom,-bytes)).
read_file(A,B):-open(A,read,C,[type(binary),buffering(block)]),read_bytes(C,B),close(C).
typed(write_file(+atom,+bytes)).
write_file(A,B):-open(A,write,C,[type(binary),buffering(block)]),write_bytes(C,B),close(C).
:-initialization(main).
main:-current_prolog_flag(argv,[A,B|C]),command(B,C).
typed(command(atom,list(atom))).
command(test,A):-undo(halt),write('Running tests'),nl,(test B:-C),([B]=A;A=[]),write(B),write(...),once(run_test(C)),fail.
command(extoltoprolog,[A,B]):-read_file(A,C),!,xtl_top_level(D,C,[]),!,xtl_to_pl_toplevel(D,E),pl_write_top_level(E,F,[]),!,append([37,32,71,101,110,101,114,97,116,101,100,32,98,121,32,101,120,116,111,108,116,111,112,114,111,108,111,103,10],F,G),write_file(B,G).
run_test(done):-!,write(success),nl.
run_test((A,B)):-!,call(A)->run_test(B);nl,write('  failed: '),write(A),nl.
run_test(A):-run_test((A,done)).
:-discontiguous((test)/1).
test test_c:-read_file('test.c',A),!,c_pp([],B,A,[]),!,c_top_level(C,B,[]).
typed(many(+predicate(A),-list(A),+bytes,-bytes)).
many(A,[B|C],D,E):-call(A,B,D,F),many(A,C,F,G),!,G=E.
many(A,[],B,C):-B=C.
typed(many1(+predicate(A),-list(A),+bytes,-bytes)).
many1(A,[B|C],D,E):-call(A,B,D,F),(!,F=G),many(A,C,G,E).
typed(eof(+bytes,-bytes)).
eof([],[]).
typed(peek(-bytes,+bytes,-bytes)).
peek(A,A,A).
typed(alpha(-byte,+bytes,-bytes)).
alpha(A,B,C):-append([A],D,B),member(A,[97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90]),D=C.
typed(digit(-byte,+bytes,-bytes)).
digit(A,B,C):-append([D],E,B),member(D-A,[48-0,49-1,50-2,51-3,52-4,53-5,54-6,55-7,56-8,57-9]),E=C.
typed(dcg_call(+sentence,+bytes,-bytes)).
dcg_call(A,B,C):-(var(A),!,fail),B=C.
dcg_call([],A,B):-(!,A=C),C=B.
dcg_call([A|B],C,D):-(!,C=E),append([A],F,E),dcg_call(B,F,D).
dcg_call((A,B),C,D):-(!,C=E),dcg_call(A,E,F),dcg_call(B,F,D).
dcg_call((A;B),C,D):-dcg_call(A,C,D).
dcg_call((A;B),C,D):-(!,C=E),dcg_call(B,E,D).
dcg_call({A},B,C):-(!,B=D),call(A),D=C.
dcg_call(A,B,C):-!,call(A,B,C).
typed(require(+sentence,+bytes,-bytes)).
require(A,B,C):-dcg_call(A,B,C),!;pretty_init(B,D),throw(parse_failed(A,D)).
typed(try(+sentence,+bytes,-bytes)).
try(A,B,C):-catch(dcg_call(A,B,C),parse_failed(D,E),F=true),!,F=false.
typed(foldl(+predicate(A,B,C),?(A),+list(B),?(C))).
foldl(A,B,[],B).
foldl(A,B,[C|D],E):-call(A,B,C,F),foldl(A,F,D,E).
c_pp(A,B,C,D):-c_pp_lines(E,C,F),eof(F,G),(!,G=H),c_pp_eval(A,E,B,[]),H=D.
c_pp_lines([],A,B):-eof(A,C),!,C=B.
c_pp_lines([A|B],C,D):-c_pp_line(A,C,E),(!,E=F),c_pp_lines(B,F,D).
c_pp_line([],A,B):-c_pp_skipwhite(A,C),(append([10],D,C),!,D=E;eof(C,E)),!,E=B.
c_pp_line([A|B],C,D):-c_pp_skipwhite(C,E),(!,E=F),c_pp_token(A,F,G),(!,G=H),c_pp_line(B,H,D).
c_pp_skipwhite(A,B):-c_pp_white(A,C),!,C=B.
c_pp_skipwhite(A,B):-A=B.
c_pp_white(A,B):-append([47,47],C,A),(!,C=D),c_pp_line_comment_(D,B).
c_pp_white(A,B):-append([47,42],C,A),(!,C=D),c_pp_block_comment_(D,E),c_pp_skipwhite(E,B).
c_pp_white(A,B):-(append([32],C,A);append([9],C,A);append([13],C,A);append([92,13,10],C,A);append([92,10],C,A)),(!,C=D),c_pp_skipwhite(D,B).
c_pp_line_comment_(A,B):-(peek([10|C],A,D);eof(A,D)),!,D=B.
c_pp_line_comment_(A,B):-c_pp_white(A,C),(!,C=D),c_pp_line_comment_(D,B).
c_pp_line_comment_(A,B):-append([C],D,A),(!,D=E),c_pp_line_comment_(E,B).
c_pp_block_comment_(A,B):-append([42,47],C,A),!,C=B.
c_pp_block_comment_(A,B):-append([C],D,A),c_pp_block_comment_(D,B).
c_pp_token(A,B,C):-(c_pp_operator(A,B,D);c_pp_symbol(A,B,D);c_pp_integer(A,B,D)),!,D=C.
c_pp_operator(operator(A),B,C):-member(D,[[61],[35],[59]]),append(D,C,B),atom_codes(A,D).
c_pp_symbol(symbol(A),B,C):-c_pp_symbol_chars(D,B,E),atom_codes(A,D),E=C.
c_pp_symbol_chars([A|B],C,D):-c_pp_symbol_first(A,C,E),(!,E=F),many(c_pp_symbol_char,B,F,D).
c_pp_symbol_first(A,B,C):-alpha(A,B,D),!,D=C.
c_pp_symbol_first(95,A,B):-append([95],B,A).
c_pp_symbol_char(A,B,C):-c_pp_symbol_first(A,B,C);append([A],D,B),member(A,[48,49,50,51,52,53,54,55,56,57]),D=C.
add_digit(A,B,C):-member(B,[0,1,2,3,4,5,6,7,8,9]),(var(A),A is C div B;true),C is A*10+B.
c_pp_integer(integer(A),B,C):-many1(digit,D,B,E),(!,E=F),foldl(add_digit,0,D,A),F=C.
c_pp_eval(A,[],B,C):-eof(B,D),!,D=C.
c_pp_eval(A,[B|C],D,E):-c_pp_eval_line(A,F,B,D,G),(!,G=H),c_pp_eval(F,C,H,E).
c_pp_eval_line(A,[B=C|A],[operator(#),symbol(define),symbol(B)|C],D,E):-!,D=E.
c_pp_eval_line(A,A,[],B,C):-!,B=C.
c_pp_eval_line(A,A,[symbol(B)|C],D,E):-((member(B=F,A),!,append(F,C,G)),D=H),c_pp_eval_line(A,A,G,H,E).
c_pp_eval_line(A,A,[B|C],D,E):-append([B],F,D),c_pp_eval_line(A,A,C,F,E).
c_top_level(A,B,C):-many(c_declaration,A,B,D),eof(D,C).
c_declaration(declare(A,B,C),D,E):-c_type(B,D,F),append([symbol(A)],G,F),(append([operator(=)],H,G),c_value(I,H,J),(!,J=K),C=value(I),K=L;C=none,G=L),append([operator(;)],E,L).
c_type(A,B,C):-append([symbol(A)],C,B).
c_value(variable(A),B,C):-append([symbol(A)],C,B).
c_value(integer(A),B,C):-append([integer(A)],C,B).
pl_token(A,B,C):-dcg_call(A,B,D),pl_skipwhite(D,E),!,E=C.
test pl_token:-pl_token([120],[120,32,32],[]),pl_token([120],[120,32,37,32,99,111,109,109,101,110,116],[]),pl_token([120],[120,32,37,32,99,111,109,109,101,110,116,10,32,32,9],[]).
pl_skipwhite(A,B):-pl_white(A,C),!,C=B.
pl_skipwhite(A,B):-A=B.
test pl_skipwhite:-pl_skipwhite([],[]).
pl_white(A,B):-append([37],C,A),(!,C=D),pl_line_comment_(D,E),pl_skipwhite(E,B).
pl_white(A,B):-(append([32],C,A);append([9],C,A);append([13],C,A);append([10],C,A)),(!,C=D),pl_skipwhite(D,B).
test pl_white:-pl_white([32],[]),pl_white([37],[]),pl_white([37,32,99,111,109,109,101,110,116,32,10,9,32,32],[]).
pl_line_comment_(A,B):-(append([10],C,A);eof(A,C)),!,C=B.
pl_line_comment_(A,B):-append([C],D,A),pl_line_comment_(D,B).
pl_top_level(A,B,C):-(append([35,33],D,B),(!,D=E),pl_line_comment_(E,F);true,B=F),pl_skipwhite(F,G),many(pl_declaration,A,G,H),require(eof,H,C).
pl_write_top_level([],A,B):-A=B.
pl_write_top_level([A|B],C,D):-pl_write_term(A,C,E),append([46,10],F,E),pl_write_top_level(B,F,D).
pl_write_term(A,B,C):-((open_output_codes_stream(D),write_term(D,A,[quoted(true),namevars(true),numbervars(true)]),close_output_codes_stream(D,E)),B=F),dcg_call(E,F,C).
pl_declaration(A,B,C):-eof(B,D),(!,D=E),fail,E=C.
pl_declaration(A,B,C):-pl_expression(A,B,D),require(pl_token([46]),D,C).
pl_atom_char(A,B,C):-append([A],D,B),(!,D=E),member(A,[97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,95,48,49,50,51,52,53,54,55,56,57]),E=C.
pl_atom(A,B,C):-append([39],D,B),pl_quoted_atom_chars_(E,D,F),atom_codes(A,E),F=C.
pl_atom(A,B,C):-many1(pl_atom_char,D,B,E),(!,E=F),(atom_codes(G,D),(D=[H|I],member(H,[95,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90]),!,A=..['$VARNAME',G];A=G)),F=C.
test pl_atom:-pl_atom(a,[39,97,39],[]),pl_atom(+,[39,43,39],[]),pl_atom('9',[39,92,57,39],[]),pl_atom(ab,[97,98],[]),pl_atom(ab,[97,98],[]).
pl_quoted_char(A,B,C):-append([92],D,B),(!,D=E),require([F],E,G),(member(F:A,[110:10,114:13,116:9,101:127,H:H]),G=I),!,I=C.
pl_quoted_atom_chars_([],A,B):-append([39],C,A),!,C=B.
pl_quoted_atom_chars_([A|B],C,D):-pl_quoted_char(A,C,E),(!,E=F),pl_quoted_atom_chars_(B,F,D).
pl_quoted_atom_chars_([A|B],C,D):-append([A],E,C),pl_quoted_atom_chars_(B,E,D).
pl_expression(A,B,C):-pl_expression(1201,A,B,C).
pl_expression(A,B,C,D):-pl_expression(none,A,B,C,D).
test pl_expression:-pl_expression(1,[49],[]),pl_expression(a,[97],[]),pl_expression(a+b,[97,32,43,32,98],[]),pl_expression(a+b*c,[97,32,43,32,98,32,42,32,99],[]),pl_expression(a*b+c,[97,32,42,32,98,32,43,32,99],[]),pl_expression(-a*b,[45,97,32,42,32,98],[]),pl_expression((:-a*b),[58,45,32,97,32,42,32,98],[]).
test pl_comma_expr:-pl_expression((p:-a,b),[112,32,58,45,32,97,44,32,98],[]).
pl_regular_term(A,B,C):-append([48,39],D,B),(!,D=E),require(pl_string_char(A),E,F),pl_skipwhite(F,C).
pl_regular_term(A,B,C):-many1(digit,D,B,E),(!,E=F),(foldl(add_digit,0,D,A),F=G),pl_skipwhite(G,C).
pl_regular_term(A,B,C):-append([34],D,B),(!,D=E),require(many(pl_string_char,A),E,F),require([34],F,G),pl_skipwhite(G,C).
pl_regular_term(A,B,C):-pl_atom(D,B,E),(!,E=F),(pl_token([40],F,G),(!,G=H),pl_comma_separated(I,[],pl_token([41]),H,J),A=..[D|I],J=C;pl_skipwhite(F,K),A=D,K=C).
pl_regular_term(A,B,C):-pl_token([40],B,D),pl_expression(A,D,E),require(pl_token([41]),E,C).
pl_regular_term({A},B,C):-pl_token([123],B,D),pl_expression(A,D,E),require(pl_token([125]),E,C).
pl_regular_term(A,B,C):-pl_token([91],B,D),pl_comma_separated(A,E,(pl_token([93]),{E=[]};pl_token([124]),pl_expression(E),pl_token([93])),D,F),!,F=C.
pl_string_char(A,B,C):-append([34],D,B),(!,D=E),false,E=C.
pl_string_char(A,B,C):-pl_quoted_char(A,B,D),!,D=C.
pl_string_char(A,B,C):-append([A],C,B).
test pl_regular_term:-pl_regular_term(123,[49,50,51],[]),pl_regular_term(hi,[104,105],[]),pl_regular_term(hi(1),[104,105,40,49,41],[]),pl_regular_term(hi(b,4),[104,105,40,98,44,32,52,41],[]),pl_regular_term(6,[40,54,41],[]),pl_regular_term({x},[123,120,125],[]),pl_regular_term([],[91,93],[]),pl_regular_term([1,2,3],[91,49,44,50,44,51,93],[]).
pl_comma_separated(A,B,C,D,E):-pl_comma_seperated_first(A,B,C,D,E).
pl_comma_seperated_first(A,A,B,C,D):-dcg_call(B,C,E),!,E=D.
pl_comma_seperated_first([A|B],C,D,E,F):-pl_expression(1000,A,E,G),(!,G=H),pl_comma_separated_next(B,C,D,H,F).
pl_comma_separated_next(A,A,B,C,D):-dcg_call(B,C,E),!,E=D.
pl_comma_separated_next([A|B],C,D,E,F):-require(pl_token([44]),E,G),(!,G=H),pl_expression(1000,A,H,I),(!,I=J),pl_comma_separated_next(B,C,D,J,F).
pl_op_or_term(!,term,A,B):-append([33],C,A),pl_skipwhite(C,B).
pl_op_or_term(A,B,C,D):-pl_regular_term(A,C,E),(!,E=F),((pl_op(G,H,A),B=op(G,H)),F=D;B=term,F=D).
pl_op_or_term(A,B,C,D):-many1(pl_op_char,E,C,F),(pl_known_op(E,A,G,H,F,I),B=op(G,H),I=J),pl_skipwhite(J,D).
pl_known_op(A,B,C,D,E,F):-(atom_codes(B,A),pl_op(G,H,B),!,pl_op(C,D,B)),E=F.
pl_known_op(A,B,C,D,E,F):-(append(G,[H],A),E=I),append([H],I,J),pl_known_op(G,B,C,D,J,F).
pl_op_char(A,B,C):-append([A],D,B),(member(A,[96,126,33,64,35,36,37,94,38,42,60,62,63,47,59,58,45,95,61,43,44,124,92,46]),D=E),!,E=C.
pl_expression(none,A,B,C,D):-pl_op_or_term(E,op(F,G),C,H),((member(G-I,[fx-0,fy-1]),J is F+I),H=K),try(pl_expression(none,J,L),K,M),(N=..[E,L],M=O),pl_expression(just(N),A,B,O,D).
pl_expression(none,A,B,C,D):-(!,C=E),require(pl_op_or_term(F,term),E,G),pl_expression(just(F),A,B,G,D).
pl_expression(just(A),B,C,D,E):-pl_op_or_term(F,op(G,H),D,I),((member(H-J,[xf-0,yf-1]),K is G+J,K<B,!,L=..[F,A]),I=M),pl_expression(just(L),B,C,M,E).
pl_expression(just(A),B,C,D,E):-pl_op_or_term(F,op(G,H),D,I),((member(H-J-K,[xfx-0-0,xfy-0-1,yfx-1-0]),L is G+J,L<B,!,M is G+K),I=N),require(pl_expression(none,M,O),N,P),(Q=..[F,A,O],P=R),pl_expression(just(Q),B,C,R,E).
pl_expression(just(A),B,A,C,D):-!,C=D.
pl_op(1200,xfx,:-).
pl_op(1200,xfx,-->).
pl_op(1200,fx,:-).
pl_op(1105,xfy,'|').
pl_op(1100,xfy,;).
pl_op(1050,xfy,->).
pl_op(1000,xfy,',').
pl_op(900,fy,\+).
pl_op(700,xfx,=).
pl_op(700,xfx,\=).
pl_op(700,xfx,=..).
pl_op(700,xfx,==).
pl_op(700,xfx,\==).
pl_op(700,xfx,is).
pl_op(700,xfx,<).
pl_op(700,xfx,>).
pl_op(700,xfx,=<).
pl_op(700,xfx,>=).
pl_op(700,xfx,=\=).
pl_op(600,xfy,:).
pl_op(500,yfx,+).
pl_op(500,yfx,-).
pl_op(400,yfx,*).
pl_op(400,yfx,/).
pl_op(400,yfx,rem).
pl_op(400,yfx,mod).
pl_op(400,yfx,div).
pl_op(400,yfx,<<).
pl_op(400,yfx,>>).
pl_op(200,xfx,**).
pl_op(200,xfx,^).
pl_op(200,fy,+).
pl_op(200,fy,-).
typed(xtl_token(+sentence),+bytes,-bytes).
xtl_token(A,B,C):-dcg_call(A,B,D),xtl_skipwhite(D,E),!,E=C.
test xtl_token:-xtl_token([120],[120,32,32],[]),xtl_token([120],[120,32,37,32,99,111,109,109,101,110,116],[]),xtl_token([120],[120,32,37,32,99,111,109,109,101,110,116,10,32,32,9],[]).
typed(xtl_skipwhite(+bytes,-bytes)).
xtl_skipwhite(A,B):-xtl_white(A,C),!,C=B.
xtl_skipwhite(A,B):-A=B.
test xtl_skipwhite:-xtl_skipwhite([],[]).
typed(xtl_white(+bytes,-bytes)).
xtl_white(A,B):-append([37],C,A),(!,C=D),xtl_line_comment_(D,E),xtl_skipwhite(E,B).
xtl_white(A,B):-(append([32],C,A);append([9],C,A);append([13],C,A);append([10],C,A)),(!,C=D),xtl_skipwhite(D,B).
test xtl_white:-xtl_white([32],[]),xtl_white([37],[]),xtl_white([37,32,99,111,109,109,101,110,116,32,10,9,32,32],[]).
xtl_line_comment_(A,B):-(append([10],C,A);eof(A,C)),!,C=B.
xtl_line_comment_(A,B):-append([C],D,A),xtl_line_comment_(D,B).
typed(xtl_top_level(-list(declaration),+bytes,-bytes)).
xtl_top_level(A,B,C):-(append([35,33],D,B),(!,D=E),xtl_line_comment_(E,F);true,B=F),xtl_skipwhite(F,G),many(xtl_declaration,A,G,H),require(eof,H,C).
typed(xtl_declaration(-declaration,+bytes,-bytes)).
xtl_declaration(A,B,C):-eof(B,D),(!,D=E),fail,E=C.
xtl_declaration(A,B,C):-xtl_expression(D,B,E),(xtl_makevars(D,A,F),E=G),require(xtl_token([46]),G,C).
xtl_makevars(A,B,C):-A=..['XTL$VARNAME','_'],!.
xtl_makevars(A,B,C):-A=..['XTL$VARNAME',D],!,member(D-B,C),!.
xtl_makevars(A,A,B):-atomic(A),!.
xtl_makevars([A|B],[C|D],E):-!,xtl_makevars(A,C,E),xtl_makevars(B,D,E).
xtl_makevars(A,B,C):-A=..D,!,xtl_makevars(D,E,C),B=..E.
test xtl_makevars:-A=..['XTL$VARNAME','A'],xtl_makevars(foo(A,A),foo(1,B),C),atomic(B),B=1.
typed(xtl_atom_char(-byte,+bytes,-bytes)).
xtl_atom_char(A,B,C):-append([A],D,B),(!,D=E),member(A,[97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,95,48,49,50,51,52,53,54,55,56,57,63]),E=C.
typed(xtl_atom(-atom,+bytes,-bytes)).
xtl_atom(A,B,C):-append([39],D,B),xtl_quoted_atom_chars_(E,D,F),atom_codes(A,E),F=C.
xtl_atom(A,B,C):-many1(xtl_atom_char,D,B,E),(!,E=F),(atom_codes(G,D),D=[H|I],(H=95,!,A=..['XTL$VARNAME','_'];member(H,[65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90]),!,A=..['XTL$VARNAME',G];A=G)),F=C.
test xtl_atom:-xtl_atom(a,[39,97,39],[]),xtl_atom(+,[39,43,39],[]),xtl_atom('9',[39,92,57,39],[]),xtl_atom(ab,[97,98],[]),xtl_atom('ab?',[97,98,63],[]).
typed(xtl_quoted_char(-byte,+bytes,-bytes)).
xtl_quoted_char(A,B,C):-append([92],D,B),(!,D=E),require([F],E,G),(member(F:A,[110:10,114:13,116:9,101:127,H:H]),G=I),!,I=C.
typed(xtl_quoted_atom_chars_(-list(bytes),+bytes,-bytes)).
xtl_quoted_atom_chars_([],A,B):-append([39],C,A),!,C=B.
xtl_quoted_atom_chars_([A|B],C,D):-xtl_quoted_char(A,C,E),(!,E=F),xtl_quoted_atom_chars_(B,F,D).
xtl_quoted_atom_chars_([A|B],C,D):-append([A],E,C),xtl_quoted_atom_chars_(B,E,D).
typed(xtl_expression(-term,+bytes,-bytes)).
xtl_expression(A,B,C):-xtl_expression(1201,A,B,C).
typed(xtl_expression(+precedence,-term,+bytes,-bytes)).
xtl_expression(A,B,C,D):-xtl_expression(none,A,B,C,D).
test xtl_expression:-xtl_expression(1,[49],[]),xtl_expression(a,[97],[]),xtl_expression(a+b,[97,32,43,32,98],[]),xtl_expression(a+b*c,[97,32,43,32,98,32,42,32,99],[]),xtl_expression(a*b+c,[97,32,42,32,98,32,43,32,99],[]),xtl_expression(-a*b,[45,97,32,42,32,98],[]),xtl_expression((:-a*b),[58,45,32,97,32,42,32,98],[]).
test comma_expr:-xtl_expression((p:-a,b),[112,32,58,45,32,97,44,32,98],[]).
typed(xtl_regular_term(-term,+bytes,-bytes)).
xtl_regular_term(A,B,C):-append([48,39],D,B),(!,D=E),require(xtl_string_char(A),E,F),xtl_skipwhite(F,C).
xtl_regular_term(A,B,C):-many1(digit,D,B,E),(!,E=F),(foldl(add_digit,0,D,A),F=G),xtl_skipwhite(G,C).
xtl_regular_term(A,B,C):-append([34],D,B),(!,D=E),require(many(xtl_string_char,A),E,F),require([34],F,G),xtl_skipwhite(G,C).
xtl_regular_term(A,B,C):-xtl_atom(D,B,E),(!,E=F),(xtl_token([40],F,G),(!,G=H),xtl_comma_separated(I,[],xtl_token([41]),H,J),A=..[D|I],J=C;xtl_skipwhite(F,K),A=D,K=C).
xtl_regular_term(A,B,C):-xtl_token([40],B,D),xtl_expression(A,D,E),require(xtl_token([41]),E,C).
xtl_regular_term({A},B,C):-xtl_token([123],B,D),xtl_expression(A,D,E),require(xtl_token([125]),E,C).
xtl_regular_term(A,B,C):-xtl_token([91],B,D),xtl_comma_separated(A,E,(xtl_token([93]),{E=[]};xtl_token([124]),xtl_expression(E),xtl_token([93])),D,F),!,F=C.
typed(xtl_string_char(-byte,+bytes,-bytes)).
xtl_string_char(A,B,C):-append([34],D,B),(!,D=E),false,E=C.
xtl_string_char(A,B,C):-xtl_quoted_char(A,B,D),!,D=C.
xtl_string_char(A,B,C):-append([A],C,B).
test xtl_regular_term:-xtl_regular_term(123,[49,50,51],[]),xtl_regular_term(hi,[104,105],[]),xtl_regular_term(hi(1),[104,105,40,49,41],[]),xtl_regular_term(hi(b,4),[104,105,40,98,44,32,52,41],[]),xtl_regular_term(6,[40,54,41],[]),xtl_regular_term({x},[123,120,125],[]),xtl_regular_term([],[91,93],[]),xtl_regular_term([1,2,3],[91,49,44,50,44,51,93],[]).
typed(xtl_comma_separated(-list(term),+list(term),+sentence,+bytes,-bytes)).
xtl_comma_separated(A,B,C,D,E):-xtl_comma_seperated_first(A,B,C,D,E).
xtl_comma_seperated_first(A,A,B,C,D):-dcg_call(B,C,E),!,E=D.
xtl_comma_seperated_first([A|B],C,D,E,F):-xtl_expression(1000,A,E,G),(!,G=H),xtl_comma_separated_next(B,C,D,H,F).
xtl_comma_separated_next(A,A,B,C,D):-dcg_call(B,C,E),!,E=D.
xtl_comma_separated_next([A|B],C,D,E,F):-require(xtl_token([44]),E,G),(!,G=H),xtl_expression(1000,A,H,I),(!,I=J),xtl_comma_separated_next(B,C,D,J,F).
typed(xtl_op_or_term(-term,-op_info,+bytes,-bytes)).
xtl_op_or_term(!,term,A,B):-append([33],C,A),xtl_skipwhite(C,B).
xtl_op_or_term(A,B,C,D):-xtl_regular_term(A,C,E),(!,E=F),((xtl_op(G,H,A),B=op(G,H)),F=D;B=term,F=D).
xtl_op_or_term(A,B,C,D):-many1(xtl_op_char,E,C,F),(xtl_known_op(E,A,G,H,F,I),B=op(G,H),I=J),xtl_skipwhite(J,D).
xtl_known_op(A,B,C,D,E,F):-(atom_codes(B,A),xtl_op(G,H,B),!,xtl_op(C,D,B)),E=F.
xtl_known_op(A,B,C,D,E,F):-(append(G,[H],A),E=I),append([H],I,J),xtl_known_op(G,B,C,D,J,F).
xtl_op_char(A,B,C):-append([A],D,B),(member(A,[96,126,33,64,35,36,37,94,38,42,60,62,47,59,58,45,95,61,43,44,124,92,46]),D=E),!,E=C.
typed(xtl_expression(+maybe(term),+precedence,-term,+bytes,-bytes)).
xtl_expression(none,A,B,C,D):-xtl_op_or_term(E,op(F,G),C,H),((member(G-I,[fx-0,fy-1]),J is F+I),H=K),try(xtl_expression(none,J,L),K,M),(N=..[E,L],M=O),xtl_expression(just(N),A,B,O,D).
xtl_expression(none,A,B,C,D):-(!,C=E),require(xtl_op_or_term(F,term),E,G),xtl_expression(just(F),A,B,G,D).
xtl_expression(just(A),B,C,D,E):-xtl_op_or_term(F,op(G,H),D,I),((member(H-J,[xf-0,yf-1]),K is G+J,K<B,!,L=..[F,A]),I=M),xtl_expression(just(L),B,C,M,E).
xtl_expression(just(A),B,C,D,E):-xtl_op_or_term(F,op(G,H),D,I),((member(H-J-K,[xfx-0-0,xfy-0-1,yfx-1-0]),L is G+J,L<B,!,M is G+K),I=N),require(xtl_expression(none,M,O),N,P),(Q=..[F,A,O],P=R),xtl_expression(just(Q),B,C,R,E).
xtl_expression(just(A),B,A,C,D):-!,C=D.
typed(xtl_op(-precedence,-associativity,-atom)).
xtl_op(1200,xfx,:-).
xtl_op(1200,xfx,-->).
xtl_op(1200,fx,:-).
xtl_op(1105,xfy,'|').
xtl_op(1100,xfy,;).
xtl_op(1050,xfy,->).
xtl_op(1000,xfy,',').
xtl_op(900,fy,\+).
xtl_op(700,xfx,=).
xtl_op(700,xfx,\=).
xtl_op(700,xfx,=..).
xtl_op(700,xfx,==).
xtl_op(700,xfx,\==).
xtl_op(700,xfx,is).
xtl_op(700,xfx,<).
xtl_op(700,xfx,>).
xtl_op(700,xfx,=<).
xtl_op(700,xfx,>=).
xtl_op(700,xfx,=\=).
xtl_op(600,xfy,:).
xtl_op(500,yfx,+).
xtl_op(500,yfx,-).
xtl_op(400,yfx,*).
xtl_op(400,yfx,/).
xtl_op(400,yfx,rem).
xtl_op(400,yfx,mod).
xtl_op(400,yfx,div).
xtl_op(400,yfx,<<).
xtl_op(400,yfx,>>).
xtl_op(200,xfx,**).
xtl_op(200,xfx,^).
xtl_op(200,fy,+).
xtl_op(200,fy,-).
xtl_op(1200,fy,test).
xtl_op(999,fx,tc).
test parse_self:-read_file('main.xtl',A),!,xtl_top_level(B,A,[]).
test regression:-xtl_declaration(A,[58,45,32,100,105,115,99,111,110,116,105,103,117,111,117,115,40,39,47,39,40,116,101,115,116,44,32,49,41,41,46],[]).
xtl_to_pl_toplevel(A,B):-maplist(xtl_to_pl_declaration,A,C),append([(:-set_prolog_flag(singleton_warning,off))],C,B).
xtl_to_pl_declaration((A:-B),(C:-D)):-!,copy_term(A-B,C-E),xtl_to_pl_goal(E,D),numbervars(C-D).
xtl_to_pl_declaration((:-A),(:-A)):-!,numbervars(A).
xtl_to_pl_declaration((test A),(test A)):-!,numbervars(A).
xtl_to_pl_declaration((A-->B),(C:-D)):-!,A=..[E|F],append(F,[G,H],I),C=..[E|I],xtl_to_pl_dcg(B,D,G,H),numbervars(C-D).
xtl_to_pl_declaration(A,A):-!,numbervars(A).
xtl_to_pl_goal((A,B),(C,D)):-!,xtl_to_pl_goal(A,C),xtl_to_pl_goal(B,D).
xtl_to_pl_goal((A;B),(C;D)):-!,xtl_to_pl_goal(A,C),xtl_to_pl_goal(B,D).
xtl_to_pl_goal(!,!):-!.
xtl_to_pl_goal(A,B):-A=B.
xtl_to_pl_dcg((A,B),(C,D),E,F):-!,xtl_to_pl_dcg(A,C,E,G),xtl_to_pl_dcg(B,D,G,F).
xtl_to_pl_dcg((A;B),(C;D),E,F):-!,xtl_to_pl_dcg(A,C,E,F),xtl_to_pl_dcg(B,D,E,F).
xtl_to_pl_dcg(!,(!,A=B),A,B):-!.
xtl_to_pl_dcg([],A=B,A,B):-!.
xtl_to_pl_dcg([A|B],append([A|B],C,D),D,C):-!.
xtl_to_pl_dcg({A},(A,B=C),B,C):-!.
xtl_to_pl_dcg(A,B,C,D):-!,A=..E,append(E,[C,D],F),B=..F.
xtl_to_pl_dcg(A,B,C,D):-throw(error(xtl_to_pl_dcg,A)).
test xtl_to_pl_dcg:-xtl_to_pl_dcg(((f;g),h),((f(a,b);g(a,b)),h(b,c)),a,c),xtl_to_pl_dcg((e,(f,i;g),h),(e(a,b),(f(b,c),i(c,d);g(b,d)),h(d,e)),a,e).
test xtl_to_pl_dcg_regression:-A=(c_declaration(declare(B,C,D))-->c_type(C),[symbol(B)],([operator(=)],c_value(E),!,{D=value(E)};{D=none}),[operator(;)]),xtl_to_pl_declaration(A,F),F=(c_declaration(declare(G,H,I),J,K):-c_type(H,J,L),append([symbol(G)],M,L),(append([operator(=)],N,M),c_value(O,N,P),(!,P=Q),I=value(O),Q=R;I=none,M=R),append([operator(;)],S,R)).
xtl_check_types(A):-copy_term(A,B),C=tenv(D,E),maplist(xtl_gather_types(C),A),length(D,F),length(E,G),!,maplist(xtl_check_types(C),A).
xtl_gather_types(tenv(A,B),typed(C)):-!,C=..[D|E],length(E,F),member(D/F:G,B),error_unless(var(G),already_typed(C,G)),G=C.
xtl_gather_types(A,type(B)):-!,xtl_type_decl(A,(type(B):-true)).
xtl_gather_types(tenv(A,B),(type(C):-D)):-!,member((C:-D),A).
xtl_gather_types(A,B).
xtl_check_types(A,(:-B)):-!.
xtl_check_types(A,type(B)):-!.
xtl_check_types(A,typed(B)):-!.
xtl_check_types(A,(test B:-C)):-!,xtl_check_type_goal(D,E,C).
xtl_check_types(A,(B:-C)):-!,xtl_check_type_head(A,D,B),xtl_check_type_goal(A,D,C),xtl_check_type_vars(A,D).
xtl_check_types(A,B):-xtl_check_type_head(A,C,B),xtl_check_type_vars(A,C).
xtl_check_type_head(A,B,C):-C=..[D|E],length(E,F),tenv_lookup_predicate(A,D/F:G),maplist(xtl_check_type_assign(A,B),E,G).
xtl_check_type_goal(A,B,C=D):-!,xtl_type_check_assign(A,B,C,D).
xtl_check_type_goal(A,B,C):-xtl_type_check_call(A,B,C).
xtl_type_check_call(A,B,C):-C=..[D|E],length(E,F),tenv_lookup_predicate(A,D/F:G),maplist(xtl_check_type_expr(A,B),E,G).
xtl_check_type_expr(A,B,C,$(D)):-maplist(xtl_check_constraint(A,B,C),E).
xtl_check_type_expr(A,B,C,D):-throw(error(invalid_type_for(D,C))).
xtl_check_constraint(A,B,C,goal):-xtl_check_type_goal(A,B,C).
xtl_check_constraint(A,B,C,D):-D=..[E,F],xtl_refine_type(A,B,C,D).
tenv_lookup_predicate(tenv(A,B),C):-member(C,B).
