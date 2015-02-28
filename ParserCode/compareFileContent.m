function [numOfFeatureWordsPresent, FeatureWordsPresent, FeatureWordFrequency, IndividualFeatureWordFrequency] = compareFileContent(featureWordsVocab, syllabusVocab, SyllabusWordDistribution)
    %% Check overlap of words of interest in syllabus vocab
    overlapIndices = ismember(featureWordsVocab,syllabusVocab);  % indices of words of shared words 
    numOfFeatureWordsPresent = sum(overlapIndices);              % How many words are shared between both files
    FeatureWordsPresent = featureWordsVocab(overlapIndices);     % Gives words common to both txt files
    FeatureWordFrequency = 0;
    IndividualFeatureWordFrequency = 0;
    
    for featureWord = 1:numOfFeatureWordsPresent
        FeatureWordIndex = find(ismember(FeatureWordsPresent{featureWord},SyllabusWordDistribution(:,1)));
        FeatureWordFrequency = SyllabusWordDistribution(FeatureWordIndex,1)
    end
%     %% Now count the number of times a negative word is used in the syllabus
%     SharedVocabFrequency = zeros(numel(vocabShared), 1);
%     for Word = 1:numel(vocabShared)
%                 SharedVocabWordIndex = 0;
%     end
end