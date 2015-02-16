function [wordCount, fileVocab, wordCountResults] = getFileText(fileName)
   file = fopen(fileName, 'r');
   fileContent = textscan(file, '%s');
   wordCount = numel(fileContent{1,1});
    %% File prep work
    % Get rid of all the characters that are not letters or numbers
    for Word=1:wordCount
        ind = find(isstrprop(fileContent{1,1}{Word,1}, 'alphanum') == 0);
        fileContent{1,1}{Word,1}(ind)=[];
    end

    % Remove words that have zero characters
    for Word = 1:wordCount
        if size(fileContent{1,1}{Word,1}, 2) == 0
            fileContent{1,1}{Word,1} = ' ';
        end
    end
    
    fileVocab = unique(fileContent{1,1});
    numberOfVocabWords = numel(fileVocab);
    %% Now count the number of times each syllabus vocabulary word appears in the syllabus
    wordFreq = zeros(numberOfVocabWords, 1);

    for Word = 1:numberOfVocabWords
        if max(fileVocab{Word} ~= ' ')
            for j = 1:wordCount
                if strcmp(fileContent{1,1}(j), fileVocab{Word})
                    wordFreq(Word) = wordFreq(Word) + 1;
                end
            end
        end
    end

    %% Print out frequency of each word in syllabus
    u_freq = unique(wordFreq);
    sortFreq = sort(u_freq, 'descend');
    wordCountResults={ 'WORD' 'FREQ' '% OF WORDS'};
    for Word = 1:min(numel(find(sortFreq > 1)), numberOfVocabWords)
        ind = find(wordFreq == sortFreq(Word));
        wordCountResults{Word+1, 1} = fileVocab{ind};
        wordCountResults{Word+1, 2} = unique(wordFreq(ind));
        wordCountResults{Word+1, 3} = sprintf('%.4f%s', unique(wordFreq(ind)/wordCount)*100, '%');
    end
end
