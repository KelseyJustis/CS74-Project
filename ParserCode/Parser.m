% Cite her: http://www.mathworks.com/matlabcentral/fileexchange/19505-wordcount/content/wordcount.m
FolderOfSyllabiTxtFiles = dir('../PDFTextExtractionCode/TEST/TEST/SyllabiTxtFiles/*.txt');


for fileNumber = 1:length(FolderOfSyllabiTxtFiles)
   CurrTxtFileName = FolderOfSyllabiTxtFiles(fileNumber).name;
   fprintf(['Processing ' CurrTxtFileName ' . . .' '\n']);
   
   CurrSyllabusTextFile = fopen(['../PDFTextExtractionCode/TEST/TEST/SyllabiTxtFiles/'  CurrTxtFileName], 'r');
   CurrSylabusWords = textscan(CurrSyllabusTextFile, '%s');
   StopWordsTextFile = fopen('../OutsideVocabDatabases/stopwords.txt', 'r');
   StopWords = textscan(StopWordsTextFile,'%s','delimiter',',');
   
    %% Get rid of all the characters that are not letters or numbers
    for Word=1:numel(CurrSylabusWords{1,1})
        ind = find(isstrprop(CurrSylabusWords{1,1}{Word,1}, 'alphanum') == 0);
        CurrSylabusWords{1,1}{Word,1}(ind)=[];
    end

    %% Remove entries in words that have zero characters
    for Word = 1:numel(CurrSylabusWords{1,1})
        if size(CurrSylabusWords{1,1}{Word,1}, 2) == 0
            CurrSylabusWords{1,1}{Word,1} = ' ';
        end
    end

    %% Now count the number of times each wordin the syllabus appears
    uniqueWords = unique(CurrSylabusWords{1,1});
   % ismember(StopWords,uniqueWords)

    wordFreq = zeros(numel(uniqueWords), 1);

    for Word = 1:numel(uniqueWords)
        if max(uniqueWords{Word} ~= ' ')
            for j = 1:numel(CurrSylabusWords{1,1})
                if strcmp(CurrSylabusWords{1,1}(j), uniqueWords{Word})
                    wordFreq(Word) = wordFreq(Word) + 1;
                end
            end
        end
    end

    %% Print out frequency of each word in syllabus

    u_freq = unique(wordFreq);

    sorted_freq = sort(u_freq, 'descend');

    commonWordResults={ 'WORD' 'FREQ' '% OF WORDS'};
    numberOfPopWords = 5;
    for Word = 1:min(numel(find(sorted_freq > 1)), numberOfPopWords)
        ind = find(wordFreq == sorted_freq(Word));
        commonWordResults{Word+1, 1} = uniqueWords{ind};
        commonWordResults{Word+1, 2} = unique(wordFreq(ind));
        commonWordResults{Word+1, 3} = sprintf('%.4f%s', unique(wordFreq(ind)/numel(CurrSylabusWords{1,1}))*100, '%');
    end
    
   stopWordResults={ 'WORD' 'FREQ' '% OF WORDS'};
   negativeWordResults={ 'WORD' 'FREQ' '% OF WORDS'};
   positiveWordResults={ 'WORD' 'FREQ' '% OF WORDS'};
   
   fprintf('Total number of words in "%s" = %d \n Total number of unique words = %d \n %d Most Common Words: \n', CurrTxtFileName, numel(CurrSylabusWords{1,1}), numel(find(wordFreq)),numberOfPopWords)
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