function [syllabusWordCount, syllabusVocab, syllabusWordDistribution, percentSignFreq] = getSyllabiTextInfo(syllabusFileID)
    %% Get file Content
    syllabusContent = textscan(syllabusFileID, '%s');
    syllabusWordCount = numel(syllabusContent{1,1});
    percentSignFreq =  0;

    %% Get rid of all the characters that are not letters or numbers
    for syllabusWord=1:syllabusWordCount
        percentSignFreq =  percentSignFreq + length(strfind(syllabusContent{1,1}{syllabusWord,1},'%'));
        percentSignFreq =  percentSignFreq + length(strfind(syllabusContent{1,1}{syllabusWord,1},'percent'));
        percentSignFreq =  percentSignFreq + length(strfind(syllabusContent{1,1}{syllabusWord,1},'Percent'));
        percentSignFreq =  percentSignFreq + length(strfind(syllabusContent{1,1}{syllabusWord,1},'percentage'));
        ind = find(isstrprop(syllabusContent{1,1}{syllabusWord,1}, 'alphanum') == 0);
        syllabusContent{1,1}{syllabusWord,1}(ind)=[];
    end

    %% Remove blank space in words
    for syllabusWord = 1:syllabusWordCount
        if size(syllabusContent{1,1}{syllabusWord,1}, 2) == 0
            syllabusContent{1,1}{syllabusWord,1} = ' ';
        end
    end
    syllabusVocab = unique(lower(syllabusContent{1,1}));
    numOfSyllabusVocabWords = numel(syllabusVocab);
    
    %% Count number of vocabulary word occurences in file
    syllabusWordFreq = zeros(numOfSyllabusVocabWords, 1);
    for syllabusWord = 1:numOfSyllabusVocabWords
        if max(syllabusVocab{syllabusWord} ~= ' ')
            for fileWord = 1:syllabusWordCount
                if strcmpi(syllabusContent{1,1}(fileWord), syllabusVocab{syllabusWord})
                    syllabusWordFreq(syllabusWord) = syllabusWordFreq(syllabusWord) + 1;
                end
            end
        end
    end
    
    %% Return "Pretty" cell with frequency of each word in file
    % {'WORD' 'FREQ' '% OF FILE WORDS'}
    syllabusWordDistribution={ 'WORD' 'FREQ' '% OF FILE WORDS'};
    for syllabusWord = 1:numOfSyllabusVocabWords
        syllabusWordDistribution{syllabusWord+1, 1} = syllabusVocab{syllabusWord};
        syllabusWordDistribution{syllabusWord+1, 2} = syllabusWordFreq(syllabusWord);
        syllabusWordDistribution{syllabusWord+1, 3} = sprintf('%.4f%s', (syllabusWordFreq(syllabusWord)/syllabusWordCount)*100, '%');
    end
end
