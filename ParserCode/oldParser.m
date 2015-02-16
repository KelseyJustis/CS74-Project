% Cite her: http://www.mathworks.com/matlabcentral/fileexchange/19505-wordcount/content/wordcount.m
%Folder of converted syllabi files from pdf to text format.
FolderOfSyllabiTxtFiles = dir('../PDFTextExtractionCode/TEST/TEST/SyllabiTxtFiles/*.txt');

% Loop over each syllabus text file
for fileNumber = 1:length(FolderOfSyllabiTxtFiles)
   CurrTxtFileName = FolderOfSyllabiTxtFiles(fileNumber).name;
   CurrSyllabusTextFile = fopen(['../PDFTextExtractionCode/TEST/TEST/SyllabiTxtFiles/'  CurrTxtFileName], 'r');
   CurrSylabusWords = textscan(CurrSyllabusTextFile, '%s');
   StopWordsTextFile = fopen('../OutsideVocabDatabases/stopwords.txt', 'r');
   StopWords = textscan(StopWordsTextFile,'%s','delimiter',',');
   WordsOfInterestTextFile = fopen('../OutsideVocabDatabases/wordsOfInterest.txt', 'r');
   WordsOfInterest = textscan(WordsOfInterestTextFile,'%s','delimiter',',');
   
   %% Words of interest prep work
    % Get rid of all the characters that are not letters or numbers in WordsOfInterest file.
    for Word=1:numel(WordsOfInterest{1,1})
        ind = find(isstrprop(WordsOfInterest{1,1}{Word,1}, 'alphanum') == 0);
        WordsOfInterest{1,1}{Word,1}(ind)=[];
    end

    % Remove words that have zero characters in WordsOfInterest file.
    for Word = 1:numel(WordsOfInterest{1,1})
        if size(WordsOfInterest{1,1}{Word,1}, 2) == 0
            WordsOfInterest{1,1}{Word,1} = ' ';
        end
    end
    WordsOfInterestVocab = unique(WordsOfInterest{1,1}); % list of unique words used in the words of interest text file
    
    %% Stop words prep work
    % Get rid of all the characters that are not letters or numbers in StopWords file.
    for Word=1:numel(StopWords{1,1})
        ind = find(isstrprop(StopWords{1,1}{Word,1}, 'alphanum') == 0);
        StopWords{1,1}{Word,1}(ind)=[];
    end

    % Remove words that have zero characters in StopWords file.
    for Word = 1:numel(StopWords{1,1})
        if size(StopWords{1,1}{Word,1}, 2) == 0
            StopWords{1,1}{Word,1} = ' ';
        end
    end
    StopWordsVocab = unique(StopWords{1,1}); % list of unique words used in the StopWords text file
    
    %% Syllabus prep work
    % Get rid of all the characters that are not letters or numbers
    for Word=1:numel(CurrSylabusWords{1,1})
        ind = find(isstrprop(CurrSylabusWords{1,1}{Word,1}, 'alphanum') == 0);
        CurrSylabusWords{1,1}{Word,1}(ind)=[];
    end

    % Remove words that have zero characters
    for Word = 1:numel(CurrSylabusWords{1,1})
        if size(CurrSylabusWords{1,1}{Word,1}, 2) == 0
            CurrSylabusWords{1,1}{Word,1} = ' ';
        end
    end
    
    syllabusVocab = unique(CurrSylabusWords{1,1});
    
    %% Check overlap of words of interest in syllabus vocab
    wordOfInterestInSyllabus = ismember(WordsOfInterestVocab,syllabusVocab); % binary list of which words of interest are present (1 if present, 0 if not)
    sum(wordOfInterestInSyllabus); %tells how many words are shared between both files
    WordsOfInterestVocab(wordOfInterestInSyllabus); % Prints out words common to both txt files
    
    StopWordsInSyllabus = ismember(StopWordsVocab,syllabusVocab); % binary list of which StopWords are present (1 if present, 0 if not)
    sum(StopWordsInSyllabus); %tells how many words are shared between both files
    StopWordsVocab(StopWordsInSyllabus); % Prints out words common to both txt files
    
    %% Now count the number of times each syllabus vocabulary word appears in the syllabus
    syllabusWordFreq = zeros(numel(syllabusVocab), 1);

    for Word = 1:numel(syllabusVocab)
        if max(syllabusVocab{Word} ~= ' ')
            for j = 1:numel(CurrSylabusWords{1,1})
                if strcmp(CurrSylabusWords{1,1}(j), syllabusVocab{Word})
                    syllabusWordFreq(Word) = syllabusWordFreq(Word) + 1;
                end
            end
        end
    end

    %% Print out frequency of each word in syllabus
    u_freq = unique(syllabusWordFreq);
    sortFreq = sort(u_freq, 'descend');
    commonWordResults={ 'WORD' 'FREQ' '% OF WORDS'};
    numberOfPopWords = 5;
    for Word = 1:min(numel(find(sortFreq > 1)), numberOfPopWords)
        ind = find(syllabusWordFreq == sortFreq(Word));
        commonWordResults{Word+1, 1} = syllabusVocab{ind};
        commonWordResults{Word+1, 2} = unique(syllabusWordFreq(ind));
        commonWordResults{Word+1, 3} = sprintf('%.4f%s', unique(syllabusWordFreq(ind)/numel(CurrSylabusWords{1,1}))*100, '%');
    end
    
    %% Now count the number of times each syllabus vocabulary word appears in the syllabus
    StopWordFreq = zeros(numel(StopWordsVocab), 1);

    for Word = 1:numel(StopWordsVocab)
        if max(StopWordsVocab{Word} ~= ' ')
            for j = 1:numel(CurrSylabusWords{1,1})
                if strcmpi(CurrSylabusWords{1,1}(j), StopWordsVocab{Word})
                    StopWordFreq(Word) = StopWordFreq(Word) + 1;
                end
            end
        end
    end

    %% Print out frequency of each word in syllabus
    u_freq = unique(StopWordFreq);
    sortFreq = sort(u_freq, 'descend');
    StopWordResults={ 'WORD' 'FREQ' '% OF WORDS'};
    numberOfStopWords = 60;
    for Word = 1:min(numel(find(sortFreq > 1)), numberOfStopWords)
        ind = find(StopWordFreq == sortFreq(Word));
        StopWordResults{Word+1, 1} = StopWordsVocab{ind};
        StopWordResults{Word+1, 2} = unique(StopWordFreq(ind));
        StopWordResults{Word+1, 3} = sprintf('%.4f%s', unique(StopWordFreq(ind)/numel(CurrSylabusWords{1,1}))*100, '%');
    end
    
   negativeWordResults={ 'WORD' 'FREQ' '% OF WORDS'};
   positiveWordResults={ 'WORD' 'FREQ' '% OF WORDS'};
   
   totNumOfWordsInSyllabus = numel(CurrSylabusWords{1,1});
   totNumOfUniqueWordsInSyllabus = numel(find(syllabusWordFreq));
   CurrTxtFileName = strsplit(char(CurrTxtFileName), '.txt');
   CurrTxtFileName = CurrTxtFileName(1,1);
   fileDataName = strcat('Results/',CurrTxtFileName);

   
  save(char(fileDataName),'CurrTxtFileName','totNumOfWordsInSyllabus','totNumOfUniqueWordsInSyllabus','syllabusVocab','commonWordResults','StopWordsVocab','StopWordResults');
  fclose('all');
end
