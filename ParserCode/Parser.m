% Cite her: http://www.mathworks.com/matlabcentral/fileexchange/19505-wordcount/content/wordcount.m
%Folder of converted syllabi files from pdf to text format.
FolderOfSyllabiTxtFiles = dir('../PDFTextExtractionCode/TEST/TEST/SyllabiTxtFiles/*.txt');

% Loop over each syllabus text file
for fileNumber = 1:length(FolderOfSyllabiTxtFiles)
   CurrTxtFileName = FolderOfSyllabiTxtFiles(fileNumber).name;
   fprintf(['Processing ' CurrTxtFileName ' . . .' '\n']);
   
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
    
    wordPresent = ismember(WordsOfInterestVocab,syllabusVocab); % binary list of which words of interest are present (1 if present, 0 if not)
    sum(wordPresent); %tells how many words are shared between both files
    WordsOfInterestVocab(wordPresent); % Prints out words common to both txt files
    
    %% Now count the number of times each word in the syllabus appears in the syllabus
    commonWordFreq = zeros(numel(syllabusVocab), 1);

    for Word = 1:numel(syllabusVocab)
        if max(syllabusVocab{Word} ~= ' ')
            for j = 1:numel(CurrSylabusWords{1,1})
                if strcmp(CurrSylabusWords{1,1}(j), syllabusVocab{Word})
                    commonWordFreq(Word) = commonWordFreq(Word) + 1;
                end
            end
        end
    end

    %% Print out frequency of each word in syllabus

    u_freq = unique(commonWordFreq);

    sortFreq = sort(u_freq, 'descend');

    commonWordResults={ 'WORD' 'FREQ' '% OF WORDS'};
    numberOfPopWords = 5;
    for Word = 1:min(numel(find(sortFreq > 1)), numberOfPopWords)
        ind = find(commonWordFreq == sortFreq(Word));
        commonWordResults{Word+1, 1} = syllabusVocab{ind};
        commonWordResults{Word+1, 2} = unique(commonWordFreq(ind));
        commonWordResults{Word+1, 3} = sprintf('%.4f%s', unique(commonWordFreq(ind)/numel(CurrSylabusWords{1,1}))*100, '%');
    end
    
   stopWordResults={ 'WORD' 'FREQ' '% OF WORDS'};
   negativeWordResults={ 'WORD' 'FREQ' '% OF WORDS'};
   positiveWordResults={ 'WORD' 'FREQ' '% OF WORDS'};
   
   fprintf('Total number of words in "%s" = %d \n Total number of unique words = %d \n %d Most Common Words: \n', CurrTxtFileName, numel(CurrSylabusWords{1,1}), numel(find(commonWordFreq)),numberOfPopWords)
   disp(commonWordResults);
   
   fprintf('Stop Word Usage: \n');
   disp(stopWordResults);
   
   fprintf('Negative Word Usage: \n');
   disp(negativeWordResults);
   
   fprintf('Positive Word Usage: \n');
   disp(positiveWordResults);
   
   fprintf(['Done with ' CurrTxtFileName '\n \n']);
   fclose('all');
end