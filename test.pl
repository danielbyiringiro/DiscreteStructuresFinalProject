keywords([    [mother, father, family, siblings, brother, sister, aunty, uncle]-'Tell me more about your family', 
    [stress, anxious, anxiety, worry, worried]- 'I am sorry to hear that. can you share what makes you feel this way?', 
    [depressed, sad, unhappy]-'What do you think is causing your sadness?', 
    [work, assignment, homework, career]-'Have you noticed any changes to your mood when working on assignments?',  
    [elderberry, fruit]-'There is an elderberry',
    ['good job', 'well done']-'Thank you! Let\'s continue:',
    [relationship, partner, spouse]-'What\'s going on in your relationship?'
]).

%predicate to check if the keyword is in the response
contains_keyword(Input, Response) :-
    % Get the list of keywords
    keywords(Keywords),
    % Convert the input to lowercase
    downcase_atom(Input, LowercaseInput),
    % Check if any keyword list contains a substring of the lowercase input
    member(KeywordList-Response, Keywords),
    member(Keyword, KeywordList),
    sub_atom(LowercaseInput, _, _, _, Keyword).


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


% Predicate to start a conversation with the user
conversation :-
    % Prompt the user for input
    write('Hello, how can I assist you today? '),nl,
    % Call the helper predicate to handle the user input
    get_user_input.


% Start the program by calling the conversation predicate
:- initialization(conversation).
