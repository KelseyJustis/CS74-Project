%% Check overlap of words of interest in syllabus vocab
    wordOfInterestInSyllabus = ismember(WordsOfInterestVocab,fileVocab); % binary list of which words of interest are present (1 if present, 0 if not)
    sum(wordOfInterestInSyllabus); %tells how many words are shared between both files
    WordsOfInterestVocab(wordOfInterestInSyllabus); % Prints out words common to both txt files
    
    StopWordsInSyllabus = ismember(StopWordsVocab,fileVocab); % binary list of which StopWords are present (1 if present, 0 if not)
    sum(StopWordsInSyllabus); %tells how many words are shared between both files
    StopWordsVocab(StopWordsInSyllabus); % Prints out words common to both txt files