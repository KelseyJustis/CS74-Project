%% Input: Text content of syllabi (each individual syllabus).
%% Output: Syllabi Dictionairies without numbers or stop words.
load('syllabiVocab.mat')

% Get List of stop words to look for
stopWordListID = fopen('OutsideVocabDatabases/stopWords.txt', 'r');
[~,stopWordsVocab] = getFeatureTextInfo(stopWordListID);

% Initialize a cell to hold filtered dictionaires
numOfCourses = size(syllabiDictionaries,1);
filteredSyllabiVocab = cell(numOfCourses+1,2);
filteredSyllabiVocab{1,1} = {'Course Name'};
filteredSyllabiVocab{1,2} = {'Course Dictionary'};

%Intial array to hold all words used in all syllabi
dartmouthWords = [];

% For each syllabus vocab
for i=2:numOfCourses +1
    filteredSyllabiVocab{i,1} = syllabiDictionaries{i-1,2}; % Get course name
    filteredSyllabiVocab{i,2} = syllabiDictionaries{i-1,5}(2:end,1); %Get course syllabi vocab
    numOfWords = length(filteredSyllabiVocab{i,2}); % number of unique words used in syllabus
    courseVocab = []; % Intial array for holding filitered syllabus vocab
    
    % For each word in the current syllabus vocab
    for j=1:numOfWords
        indOfNums = find((isstrprop(filteredSyllabiVocab{i,2}{j,1}, 'alpha') == 0)); % Finds words that are numbers
        notANumber = isempty(indOfNums); % Flag to say word is/isnt a number
        notAStopWord = sum(ismember(stopWordsVocab,filteredSyllabiVocab{i,2}{j,1}))==0; % Flag to say word is/isnt a stop word
        isAWord = length(filteredSyllabiVocab{i,2}{j,1})>1; % Flag to say word is/isnt just a single character
        % If meets criteria add to filtered syllabus dictionary
        if (notANumber && notAStopWord && isAWord)
            courseVocab = [courseVocab; cellstr(filteredSyllabiVocab{i,2}{j,1})];
        end
    end
    filteredSyllabiVocab{i,2} = courseVocab; % Rewrite syllabus dictionary with filtered one
    dartmouthWords = [dartmouthWords; courseVocab]; % Add filtered dictionary to words used in all syllabi
end
sumOfCourseVocabSizes = length(dartmouthWords);
dartmouthVocab = unique(dartmouthWords); % Get unique words from all course vocabs
dartmouthVocabSize = length(dartmouthVocab); % Size of vocab(unique words) used in all syllabi combined

%Save to a matrix to be loaded so dont have to keep running unless need to
%apply new criteria to filtered words
save('filteredSyllabiVocab','filteredSyllabiVocab','dartmouthWords','sumOfCourseVocabSizes','dartmouthVocab','dartmouthVocabSize'); 