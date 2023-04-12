keywords([    [mother, father]-'Tell me more about your relationship with your parents',
    ['love him', 'love her', 'love them', 'in love with', 'like her', 'like them', 'like him']- 'Sounds like they mean a lot to you! Good relationships are very healthy. Tell me more about them',
    [brother, sister, siblings]- 'What is your relationship with your siblings like?',
    [family, aunt, auntie, uncle, cousins] - 'Oh tell me more about your extended family',
    [stress, anxious, anxiety, worry, worried, afraid,stressed]- 'I am sorry to hear that. can you share what makes you feel this way?', 
    ['don\'t like him', 'don\'t love them', 'don\'t like her', 'don\'t like them' , 'annoying me', 'makes me angry']- 'Do they do anything in particular to make you feel this way?',
    [depressed, sad, unhappy, depression]-'What do you think is  causing your sadness specifically?', 
    [work, assignment, homework, career]-'Have you noticed any changes to your mood when working on assignments?',  
    ['i hate school', 'class is boring', 'i don\'t understand']- 'I know it\'s difficult but having a more positive mindset is everything',
    [hate, anger, stupid]-'What\'s making you feel this way?. Talking about it helps a lot :)',
    ['good job', 'well done']-'Thank you! Let\'s continue:',
    [relationship, partner, girlfriend, boyfriend]-'What\'s going on in your relationship?',
    [drugs, alcohol, weed, cocaine, smoking, 'i like being high']- 'At what times do you feel the urge to take these things?',
    [suicide, 'i want to die', 'life is pointless', 'kill myself' , 'take my life']- 'What makes you feel this way?. Also you\'re very much appreciated and you can always reach out for help. ', 
    [harrassed, harrass, inappropriate, 'sexual harrassment', 'forced himself on', 'forced herself on', 'not consensual', 'i did\'nt consent']- 'You\'re not alone. Have you sought or reported any such incidents?'
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
    write('Hello, I am Prolog Psychiatrist. What\'s going on with you?'),nl,
    % Call the helper predicate to handle the user input
    get_user_input.


% Start the program by calling the conversation predicate
:- initialization(conversation).
