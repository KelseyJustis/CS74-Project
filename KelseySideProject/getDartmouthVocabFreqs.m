%% Input: Filtered syllabi dictionaries
% Output: Number of syllabi dictionaries each word (out of all words used in all
% dictionaries) appears in.
load('filteredSyllabiVocab');
dartmouthVocabDist = cell(dartmouthVocabSize + 1,2);
dartmouthVocabDist{1,1} = {'Vocab Word'};
dartmouthVocabDist{1,2} = {'Num of Syllabi Dictionaries Present'};

% Words used in multiple syllabi
freqWords = cell(dartmouthVocabSize,2);
freqWords{1,1} = {'Vocab Word'};
freqWords{1,2} = {'Num of Syllabi Dictionaries Present'};
rowOfFreq=2;

% Words used only in 1 syllabus
oddWords = cell(dartmouthVocabSize,2);
oddWords{1,1} = {'Vocab Word'};
oddWords{1,2} = {'Num of Syllabi Dictionaries Present'};
rowOfOdd=2;

% Count number of syllabi using each word from all syllabi
for i = 1:dartmouthVocabSize
    dartmouthVocabDist{i+1,1} = dartmouthVocab{i};
    numOfSyllabiUsedIn = sum(strcmpi(dartmouthVocab{i},dartmouthWords));
    dartmouthVocabDist{i+1,2}= numOfSyllabiUsedIn;
    
    % Seperate words used in multiple syllabi from words used in only 1
    if (numOfSyllabiUsedIn >1)
        freqWords{rowOfFreq,1} = dartmouthVocab{i};
        freqWords{rowOfFreq,2} = numOfSyllabiUsedIn;
        rowOfFreq = rowOfFreq + 1;
    else
        oddWords{rowOfOdd,1} = dartmouthVocab{i};
        oddWords{rowOfOdd,2} = numOfSyllabiUsedIn;
        rowOfOdd = rowOfOdd + 1;
    end
end

% Get rid of empty cells in frequent words cell array
emptyCells = cellfun('isempty', freqWords);
cols = size(freqWords,2);
freqWords(emptyCells) = [];
freqWords = reshape(freqWords, [], cols);

% Get rid of empty cells in odd words cell array
emptyCells = cellfun('isempty', oddWords);
cols = size(oddWords,2);
oddWords(emptyCells) = [];
oddWords = reshape(oddWords, [], cols);