function [wordCount, fileVocab, wordCountResults] = getFileText(fileID)
    %% Get file Content
    fileContent = textscan(fileID, '%s');
    wordCount = numel(fileContent{1,1});

    %% Get rid of all the characters that are not letters or numbers
    for Word=1:wordCount
        ind = find(isstrprop(fileContent{1,1}{Word,1}, 'alphanum') == 0);
        fileContent{1,1}{Word,1}(ind)=[];
    end

    %% Remove words with zero characters
    for Word = 1:wordCount
        if size(fileContent{1,1}{Word,1}, 2) == 0
            fileContent{1,1}{Word,1} = ' ';
        end
    end
    fileVocab = unique(fileContent{1,1});
    numberOfVocabWords = numel(fileVocab);
    
    %% Count number of vocabulary word occurences in file
    wordFreq = zeros(numberOfVocabWords, 1);
    for Word = 1:numberOfVocabWords
        if max(fileVocab{Word} ~= ' ')
            for fileWord = 1:wordCount
                if strcmp(fileContent{1,1}(fileWord), fileVocab{Word})
                    wordFreq(Word) = wordFreq(Word) + 1;
                end
            end
        end
    end

    %% Return "Pretty" cell with frequency of each word in file
    u_freq = unique(wordFreq);
    sortFreq = sort(u_freq, 'descend');
    wordCountResults={ 'WORD' 'FREQ' '% OF FILE WORDS'};
    for Word = 1:min(numel(find(sortFreq > 1)), numberOfVocabWords)
        ind = find(wordFreq == sortFreq(Word));
        wordCountResults{Word+1, 1} = fileVocab{ind};
        wordCountResults{Word+1, 2} = unique(wordFreq(ind));
        wordCountResults{Word+1, 3} = sprintf('%.4f%s', unique(wordFreq(ind)/wordCount)*100, '%');
    end
end
