% This code is a simple prolog implementation of a psychaiatrist chatbot
%
%
% @version 1.0
% @since April 2023


% define keywords and corresponding responses using an association list
keywords([    [mother, mom , mum, mummy, mama]-"Tell me more about your relationship with your mother.",
    [parents]-"Tell me about your relationship with your parents parents.",
    [father, dad, daddy, papa, dada]-"Tell me more about your relationship with your father",
    [hello, hi, hey, "good morning" , "good evening" , "good afternoon"] - "Hey there! how are you doing?",
    ["don't like them" , "annoying me", "makes me angry"]-"Have you told them how you feel?",
    ["don't like him", "don't love them", "don't like her"]- "Do they do anything in particular to make you feel this way?",
    ["like her", "like them", "like him"]- "Sounds like they mean a lot to you! Good relationships are very healthy. Tell me more about them",
    ["love him", "love her", "love them", "in love with"]-"I think you should let them know how you feel. How would you do that?",
    [brother, sister, siblings]- "What is your relationship with your siblings like?",
    ["i am doing great"]-"Awesome. I am all ears.",
    [""]-"It is okay if you don't want to talk yet",
    ["i'm fine", "i'm good" , "i'm well"]- "Glad to hear it! So what's going on with you lately",
    [friend, friends, bestie] - "Tell me more about your friends",
    [family, aunt, auntie, uncle, cousins] - "Oh tell me more about your extended family",
    [stress, anxious, anxiety, worry, worried, afraid,stressed]- "I am sorry to hear that. Can you share what makes you feel this way?", 
    [depressed, sad, unhappy, depression]-"What do you think is  causing your sadness?", 
    [work, assignment, homework, career]-"Have you noticed any changes to your mood when working on assignments?",  
    ["i hate school", "class is boring", "i don't understand"]- "I know it's difficult but having a more positive mindset is everything",
    [hate, anger, stupid]-"What's making you feel this way?. Talking about it helps a lot :)",
    ["good job", "well done"]-"Thank you! Let's continue:",
    [relationship, partner, girlfriend, boyfriend]-"What's going on in your relationship?",
    [drugs, alcohol, weed, cocaine, smoking, "i like being high"]- "At what times do you feel the urge to take these things?",
    [suicide, "i want to die", "life is pointless", "kill myself" , "take my life"]- "What makes you feel this way?. Also you're very much appreciated and you can always reach out for help. ", 
    [harrassed, harrass, inappropriate, "sexual harrassment", "forced himself on", "forced herself on", "not consensual", "i did'nt consent"]- "You're not alone. Have you sought or reported any such incidents?"
]).


% this is a predicate that checks if the users input contains a keyword and gets the appropriate response
keyword_match(Input, Response) :-
    % retrieve the list of keywords
    keywords(Keywords),
    % convert the input to lowercase so that it is case insesitive
    downcase_atom(Input, L_input),
    % fetch the keywords lists and their responses
    member(KeywordList-Response, Keywords),
    % fetch the keywords from keywords list
    member(Keyword, KeywordList),
    % check if the keyword is a substring of the input
    sub_atom(L_input, _, _, _, Keyword). 



process_response :-
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
        ; (% If no keyword was found, check for "goodbye" to end conversation print phrase and continue conversation
            downcase_atom(N_Input, Lower_N_Input),
            sub_atom(Lower_N_Input, _, _, _, "goodbye")
                % end conversation if goodbye is found
                -> write("See you later :)"), nl
                % ask user to continue conversation
                ; (write("Interesting, Tell me more"),nl, process_response)
        )
    ).




% this predicate begins a conversation with the user
begin_conversation :-
    % begin the conversation 
    write("Hey there! I am the Prolog Psychiatrist. What's going on with you?"),nl,
    % call the process response predicate 
    process_response.


% intialize conversation
:- initialization(begin_conversation).