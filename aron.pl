keywords([[hello,hi,hey]:"How are you",
         [mother]: "hi mom",
         [father]: "hi dad"]).

process(Input,Response):-
    keywords(Keywords),
    downcase_atom(Input, L_input),
    member(KeywordList-Response, Keywords),
    member(Keyword, KeywordList),
    sub_atom(L_input, _, _, _, Keyword).

process_response :-
    % prompt
    write('> '),
    % get the user input as list of strings
    readln(Input),
    % join the list of strings together as a single string
    atomic_list_concat(Input," ", N_Input),
    % call the keyword match predicate to determine if the input contains a keyword
    (keyword_match(N_Input,Response)
        % print out the response to the user and then move to a new line
        -> write(Response), nl,
           % call the process response predicate recursively to get continue conversation
           process_response
        ; (% If no keyword was found, check for "goodbye" to end conversation or else ask for more input
            downcase_atom(N_Input, Lower_N_Input),
            sub_atom(Lower_N_Input, _, _, _, "goodbye")
                % end conversation if goodbye is found
                -> write("See you later :)"), nl
                % ask user to continue conversation
                ; (no_key_response,nl, process_response)
        )
    ).


init_conversation :-
    write("Hey there! I am the Prolog Psychiatrist. What's going on with you?"),nl,
    process_response.

:- initialization(init_conversation).