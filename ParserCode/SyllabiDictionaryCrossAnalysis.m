%% Program Description
% Program takes in syllabus dictionaries, compares each to each other and outputs matrices with information regarding
% how the word distributions (which words are used and how often) compare.
% INPUT:
% Syllabus dictionaries
%
% OUTPUT:
% Syllabus word distibution comparision matrix
syllabiDictionaries = load('SyllabiDictionairies/syllabiDictionaries.mat');
numOfSyllabi = size(syllabiDictionaries,1);

for syllabusDictionaryNum = 1:numOfSyllabi
  fprintf(['...Comparing syllabus dictionary' num2str(syllabusDictionaryNum) '/' num2str(numOfSyllabi) ' (Process ' sprintf('%.1f%s', syllabusDictionaryNum*100/numOfSyllabi) '%% complete)...' '\n']);
  
  %% Get current syllabus text information
  syllabusDictionary = syllabiDictionaries{syllabusDictionaryNum,6};
  SyllabusDictionary(1,:) = []; 
  syllabusVocab = syllabusDictionary{:,1};
  syllabusWordFrequency = syllabusDictionary{:,2};
  
  for syllabusDictionaryNum = 1:numOfSyllabi
  %% Check overlap of words of interest in syllabus vocab 
  overlapIndicesSyllabus = ismember(syllabusVocab,featureWordsVocab);        % indices of words of shared words 
  SyllabusWordDistribution(1,:) = [];                                        % Remove title row in syllabus word distribution
  FeatureWordsPresent = SyllabusWordDistribution(overlapIndicesSyllabus,1);  % Gives words common to both txt files
  numOfFeatureWordsPresent = length(FeatureWordsPresent);                    % How many words are shared between both files
  IndividualFeatureWordFrequency = SyllabusWordDistribution(overlapIndicesSyllabus,2);
  FeatureWordFrequency = sum([IndividualFeatureWordFrequency{:}]);

  % Syllabus words prep work
  [syllabusWordCount, syllabusVocab, syllabusWordDistribution] = getSyllabiTextInfo(CurrSyllabusFileID);
  syllabiDictionaries{syllabusDictionaryNum,1} = courseDept;
  syllabiDictionaries{syllabusDictionaryNum,2} = courseName;
  syllabiDictionaries{syllabusDictionaryNum,3} = courseNum;
  syllabiDictionaries{syllabusDictionaryNum,4} = syllabusWordCount;
  syllabiDictionaries{syllabusDictionaryNum,5} = syllabusVocab;
  syllabiDictionaries{syllabusDictionaryNum,6} = syllabusWordDistribution;
  
  save('SyllabiDictionairies/syllabiDictionaries','syllabiDictionaries');
  fclose('all');
end