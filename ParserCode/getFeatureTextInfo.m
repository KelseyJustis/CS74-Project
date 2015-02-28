function [numOfFeatureVocabWords, featureFileVocab] = getFeatureTextInfo(featureTextFileID)
    %% Get file Content
    featureFileContent = textscan(featureTextFileID, '%s','delimiter',',');
    featureWordListSize = numel(featureFileContent{1,1});

    %% Get rid of all characters that are not letters or numbers
    for featureWord=1:featureWordListSize
        ind = find(isstrprop(featureFileContent{1,1}{featureWord,1}, 'alphanum') == 0);
        featureFileContent{1,1}{featureWord,1}(ind)=[];
    end

    %% Remove words with zero characters
    for featureWord = 1:featureWordListSize
        if size(featureFileContent{1,1}{featureWord,1}, 2) == 0
            featureFileContent{1,1}{featureWord,1} = ' ';
        end
    end
    
    featureFileVocab = unique(featureFileContent{1,1});
    numOfFeatureVocabWords = numel(featureFileVocab);
end
