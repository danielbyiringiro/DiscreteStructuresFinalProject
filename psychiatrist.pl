% This code is a simple prolog implementation of a psychaiatrist chatbot
%
%
% @version 1.0
% @since April 2023


% define keywords and corresponding responses using an association list
keywords([[mother, father, mom , dad, mum, mummy, daddy, papa, mama]-"Tell me more about your relationship with your parents",
    ["don't like him", "don't love them", "don't like her", "don't like them" , "annoying me", "makes me angry"]- "Do they do anything in particular to make you feel this way?",
    ["love him", "love her", "love them", "in love with", "like her", "like them", "like him"]- "Sounds like they mean a lot to you! Good relationships are very healthy. Tell me more about them",
    [brother, sister, siblings]- "What is your relationship with your siblings like?",
    ["i am doing great"]-"Awesome. I am all ears.",
    ["i'm fine", "i'm good" , "i'm well"]- "Glad to hear it! So what's going on with you lately",
    [boyfriend, girlfriend]-"What's going on in your relationship?",
    [friend, friends, bestie] - "Tell me more about your friends",
    [family, aunt, auntie, uncle, cousins] - "Oh tell me more about your extended family",
    [stress, anxious, anxiety, worry, worried, afraid,stressed]- "I am sorry to hear that. can you share what makes you feel this way?", 
    [depressed,depression]-"What do you think is  causing your depression?", 
    [sad, unhappy] - "I am sorry to hear that. can you share what makes you feel this way?",
    [assignment, homework, assignments]-"Have you noticed any changes to your mood when working on assignments?", 
    [work, career] - "What is going on at work?",
    ["i hate school", "class is boring", "i don't understand"]- "I know it's difficult but having a more positive mindset is everything and can be more helpful",
    [anger, angry]-"What makes you feel angry?",
    [stupid] - "Why do you think you're stupid?",
    [deadline, deadlines] - "What do you think cause you to work when deadlines are near?",
    [hate] - "Why do you hate it?",
    ["good job", "well done"]-"Thank you! Let's continue:",
    [partner, spouse]-"What's going on in your marriage?",
    [drugs, alcohol, weed, cocaine, smoking, "i like being high"]- "At what times do you feel the urge to take these things?",
    ["life is pointless","take my life"]- "What makes you feel this way?. Also you're very much appreciated and you can always reach out for help. ", 
    [suicide, "kill myself","i want to die" ] - "Death is not the solution, have you tried reaching out to friends or loved ones ?",
    [harrassed, harrass]- "Have you sought for help or reported any such incidents?",
    ["sexual harrassment", "forced himself on", "forced herself on","not consensual", "i did'nt consent" ]- "Can you tell me more about the situation or experience where you felt that you didn't consent or someone forced themselves on you?",
    [inappropriate] - "Please explain what happened",
    [anorexia, bulimia, "eating disorder"]- "Can you tell me more about your relationship with food and how it affects your daily life?",
    [insomnia, sleep, tired, fatigue]- "How many hours of sleep do you get each night? Have you noticed any changes in your sleep patterns?",
    [medication, prescription, pills]- "Are you currently taking any medication? If so, how do you feel it is affecting you?",
    [trauma, ptsd, abuse, assault]- "It takes a lot of courage to speak up about trauma. Can you tell me more about what happened and how it has affected you?",
    ["self-harm", cutting, "suicidal thoughts", "suicide attempts"]- "I'm here to support you through this difficult time. Have you ever talked to a therapist or counselor about these thoughts and feelings?",
    ["panic attack", "anxiety attack"]- "I'm sorry to hear that you're experiencing panic attacks. Can you tell me more about what triggers them?",
    [ocd, "obsessive-compulsive disorder"]- "OCD can be very distressing. Can you tell me more about your compulsions and how they affect your daily life?",
    [phobia, fear, anxiety]- "Facing your fears can be challenging, but it's important to take small steps towards overcoming them. What steps have you taken so far?",
    [loneliness, isolated, "social anxiety"]- "Feeling lonely or isolated can be difficult, but there are ways to connect with others. Have you considered joining any social groups or clubs?",
    ["relationship problems", "marriage problems"]- "Relationship problems can be very distressing. Can you tell me more about what's been going on in your relationship/marriage?",
    [hello, "good morning", "good morning","good afternoon", "good evening"]- "Hey there, what's up?"
]).

% keywords for if theres no response
no_response_keywords(["I see, please continue..","Interesting. Tell me more", "Okay. Go on", "Okay what else?"]).


% predicate to get a response if no keyword is provided
no_key_response :-
    % Get the list of strings
    no_response_keywords(List),
    % Get the length of the list
    length(List, Length),
    % Generate a random index between 1 and the length of the list
    random(1, Length, Index),
    % Get the string at the random index
    nth1(Index, List, Response),
    % print the response
    write(Response).


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




% predicate to receive user input and return appropriate response
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
            Lower_N_Input = 'goodbye'
                % end conversation if goodbye is found
                -> write("It was nice speaking with you! See you later :)"), nl
                % ask user to continue conversation
                ; (no_key_response,nl, process_response)
        )
    ).




% this predicate begins a conversation with the user
begin_conversation :-
    % begin the conversation 
    write('Hello! Welcome to Prolog Psychiatrist version 1.0'),nl,
    write("                      Rules                         "),nl,
    write("===================================================="),nl,
    write("When you see the '>' you can enter input"),nl,
    write("To end the conversation at any point type 'goodbye'"),nl,
    write("Let's Begin"),nl,
    write("===================================================="),nl,nl,
    write("Hey there! I am the Prolog Psychiatrist. What's going on with you?"),nl,
    % call the process response predicate 
    process_response.


% intialize conversation
:- initialization(begin_conversation).
