load('freqWords');
load('syllabiVocab');

commonWords = freqWords(2:end,1);
numOfSyllabi = length(syllabiDictionaries);
syllabiVocabMatrix = cell(numOfSyllabi,1);
newX = cell(numOfSyllabi,length(commonWords));

% Loop over each syllabus text file
for i = 1:numOfSyllabi
  syllabiVocab = syllabiDictionaries{i,5}(2:end,1); %Get course syllabi vocab
  overlapIndicesSyllabus = ismember(commonWords,syllabiVocab);        % indices of words of shared words 
  syllabiVocabMatrix{i} = overlapIndicesSyllabus(:);
  for j = 1:length(syllabiVocabMatrix{i})
      newX{i,j} = syllabiVocabMatrix{i}(j);
  end
end
newX = [X,newX];
save('newCourseFeaturesData','newX','freqWords');
