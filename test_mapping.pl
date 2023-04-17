% This is a prolog implementation of a simple Psychiatrist chatbot using mapping
%
% @since April 2023
% @version 1.0

% predicate to alter the input and return the new sentence
alter([], []).
alter([Word|Words], [NewWord|NewWords]) :-
    (   Word = "Are"
    ->  NewWord = "No"
    ;   Word = "you"
    ->  NewWord = "[I,am]"
    ;   NewWord = Word
    ),
    alter_list(Words, NewWords).


% predicate to collect user input
process_response(Strings) :-
    % read the user input
    read(Input),
    % break input into list of strings
    atom_string(Input, InputString),
    split_string(InputString, " ", "", Strings),
    alter(Strings, Result).


% main predicate
start_conversation :-
    write("Hey! I'm Prolog Psychiatrist. How can i help today?"),nl,
    process_response(Strings).

    


