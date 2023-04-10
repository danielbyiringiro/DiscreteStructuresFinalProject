% Define a list of keywords with corresponding responses
keywords([mother-'Tell me more about your family', 
          school-'Tell me about school', 
          depressed-'What is making you depressed', 
          work-'What feels like too much work?', 
          elderberry-'There is an elderberry',
          'good job' - 'Thank You! Lets Continue:',
          relationship - 'What`s going on in your relationship?'
        ]).

% Predicate to check if a keyword is in the user input
contains_keyword(Input, Response) :-
    % Get the list of keywords
    keywords(Keywords),
    % Convert the input to lowercase
    downcase_atom(Input, LowercaseInput),
    % Check if any keyword is a substring of the lowercase input
    member(Keyword-Response, Keywords),
    sub_atom(LowercaseInput, _, _, _, Keyword).

% Predicate to start a conversation with the user
conversation :-
    % Prompt the user for input
    write('Hello, how can I assist you today? '),nl,
    % Call the helper predicate to handle the user input
    get_user_input.

% Predicate to handle the user input
get_user_input :-
    % Read the user input
    readln(Input),
    % Join the list of atoms into a single atom
    atomic_list_concat(Input, ' ', AtomInput),
    % Check if the input contains a keyword
    (contains_keyword(AtomInput, Response)
        -> write(Response), nl, % Add a newline character after the response
           % Call get_user_input again to continue the conversation
           get_user_input
        ; ( % If no keyword was found, check for the "goodbye" keyword
            sub_atom(AtomInput, _, _, _, 'goodbye')
              % If the "goodbye" keyword is found, end the conversation
              -> write('Goodbye!'), nl
              % If not, ask the user for more input
              ; (write('I see, please continue..'),nl, get_user_input)
           )
      ).

% Start the program by calling the conversation predicate
:- initialization(conversation).
