read_file(File,Rows) :-
    open(File,read,Input),
    read_puzzle(Input,Rows),
    close(Input).

read_puzzle(Input,[]) :- at_end_of_stream(Input), !.
read_puzzle(Input,[Row|Rows]) :-
    \+ at_end_of_stream(Input),
    read(Input,Row),
    read_puzzle(Input,Rows).

find_move(3, u, 1).
find_move(3, l, 2).
find_move(4, l, 3).
find_move(6, u, 2).
find_move(6, l, 5).
find_move(7, u, 3).
find_move(7, l, 6).
find_move(8, u, 4).
find_move(8, l, 7).
find_move(9, l, 8).
find_move(a, u, 6).
find_move(b, u, 7).
find_move(b, l, a).
find_move(c, u, 8).
find_move(c, l, b).
find_move(d, u, b).
find_move(Start, r, End) :- find_move(End, l, Start).
find_move(Start, d, End) :- find_move(End, u, Start).
find_move(Start, _, Start).

find_digit([], Digit, Digit) :- !.
find_digit([Dir|Row], Start, Digit) :-
    find_move(Start, Dir, Dest),
    find_digit(Row, Dest, Digit).

find_password([], _, []).
find_password([end_of_file], _, []).
find_password([Row|Rows], Start, [UpperDigit|Password]) :-
    find_digit(Row, Start, Digit),
    string_upper(Digit, UpperDigit),
    find_password(Rows, Digit, Password).

solve() :-
    read_file('input.txt', Rows),
    find_password(Rows, 5, Password), 
    !,
    writeln(Password).

