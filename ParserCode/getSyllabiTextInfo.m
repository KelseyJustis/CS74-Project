function [syllabusWordCount, syllabusVocab, syllabusWordDistribution] = getSyllabiTextInfo(syllabusFileID)
    %% Get file Content
    syllabusContent = textscan(syllabusFileID, '%s');
    syllabusWordCount = numel(syllabusContent{1,1});

    %% Get rid of all the characters that are not letters or numbers
    for syllabusWord=1:syllabusWordCount
        ind = find(isstrprop(syllabusContent{1,1}{syllabusWord,1}, 'alphanum') == 0);
        syllabusContent{1,1}{syllabusWord,1}(ind)=[];
    end

    %% Remove words with zero characters
    for syllabusWord = 1:syllabusWordCount
        if size(syllabusContent{1,1}{syllabusWord,1}, 2) == 0
            syllabusContent{1,1}{syllabusWord,1} = ' ';
        end
    end
    syllabusVocab = unique(syllabusContent{1,1});
    numOfSyllabusVocabWords = numel(syllabusVocab);
    
    %% Count number of vocabulary word occurences in file
    syllabusWordFreq = zeros(numOfSyllabusVocabWords, 1);
    for syllabusWord = 1:numOfSyllabusVocabWords
        if max(syllabusVocab{syllabusWord} ~= ' ')
            for fileWord = 1:syllabusWordCount
                if strcmp(syllabusContent{1,1}(fileWord), syllabusVocab{syllabusWord})
                    syllabusWordFreq(syllabusWord) = syllabusWordFreq(syllabusWord) + 1;
                end
            end
        end
    end

    %% Return "Pretty" cell with frequency of each word in file
    u_freq = unique(syllabusWordFreq);
    sortFreq = sort(u_freq, 'descend');
    syllabusWordDistribution={ 'WORD' 'FREQ' '% OF FILE WORDS'};
    for syllabusWord = 1:min(numel(find(sortFreq > 1)), numOfSyllabusVocabWords)
        ind = find(syllabusWordFreq == sortFreq(syllabusWord));
        syllabusWordDistribution{syllabusWord+1, 1} = syllabusVocab{ind};
        syllabusWordDistribution{syllabusWord+1, 2} = unique(syllabusWordFreq(ind));
        syllabusWordDistribution{syllabusWord+1, 3} = sprintf('%.4f%s', unique(syllabusWordFreq(ind)/syllabusWordCount)*100, '%');
    end
end
