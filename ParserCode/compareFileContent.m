function [numOfFeatureWordsPresent, FeatureWordsPresent, FeatureWordFrequency, IndividualFeatureWordFrequency] = compareFileContent(featureWordsVocab, syllabusVocab, SyllabusWordDistribution)
    %% Check overlap of words of interest in syllabus vocab 
    overlapIndicesSyllabus = ismember(syllabusVocab,featureWordsVocab);        % indices of words of shared words 
    SyllabusWordDistribution(1,:) = [];                                        % Remove title row in syllabus word distribution
    FeatureWordsPresent = SyllabusWordDistribution(overlapIndicesSyllabus,1);  % Gives words common to both txt files
    numOfFeatureWordsPresent = length(FeatureWordsPresent);                    % How many words are shared between both files
    IndividualFeatureWordFrequency = SyllabusWordDistribution(overlapIndicesSyllabus,2);
    FeatureWordFrequency = sum([IndividualFeatureWordFrequency{:}]);
end