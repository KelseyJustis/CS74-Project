%% Program Description
% Program takes in syllabus .txt files and outputs matrices with information regarding
% the word distribution (which words are used and how often).
% INPUT:
% Syllabus .txt files
%
% OUTPUT:
%  Syllabus word distibution matrix

%Folder of converted syllabi files from pdf to text format.
addpath('../PDFTextExtractionCode')
folderOfSyllabiTxtFiles = dir('../PDFTextExtractionCode/TEST/TEST/SyllabiTxtFiles/*.txt');
numOfFeatures = 6;
numOfCourses =  length(folderOfSyllabiTxtFiles);
syllabiDictionaries = cell(numOfCourses,numOfFeatures);
stopWordListID = fopen('../OutsideVocabDatabases/stopWords.txt', 'r');
[~,stopWordsVocab] = getFeatureTextInfo(stopWordListID);

fprintf(['Dictionary generation process initialized.\n'])
% Loop over each syllabus text file
for syllabusFileNum = 1:numOfCourses
  fprintf(['...Generating dictionary for file ' num2str(syllabusFileNum) '/' num2str(numOfCourses) ' (Process ' sprintf('%.1f%s', syllabusFileNum*100/numOfCourses) '%% complete)...' '\n']);
  %% Get course syllabus information
  CurrSyllabusFileName = folderOfSyllabiTxtFiles(syllabusFileNum).name;
  CurrSyllabusFileID = fopen(['../PDFTextExtractionCode/TEST/TEST/SyllabiTxtFiles/'  CurrSyllabusFileName], 'r');
  courseName = CurrSyllabusFileName(1:end-4); % remove .txt extension to get the course name
  courseNameSplit = strsplit(courseName, '-'); 
  courseDept = char(courseNameSplit(1, 1)); % get the course department
  courseNum = str2double(courseNameSplit(1, 2));  % get the course number
  
    %% Get file Content
    syllabusContent = textscan(CurrSyllabusFileID, '%s');
    syllabusWordCount = numel(syllabusContent{1,1});
    percentSignFreq =  0;

    %% Get rid of all the characters that are not letters or numbers
    for syllabusWord=1:syllabusWordCount
    ind = find((isstrprop(syllabusContent{1,1}{syllabusWord,1}, 'alphanum') == 0));
    syllabusContent{1,1}{syllabusWord,1}(ind)=[];
        if (ismember(syllabusContent{1,1}{syllabusWord,1},stopWordsVocab))
            syllabusContent{1,1}{syllabusWord,1} = [];
        end
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

  % SyllabuS information saving
  syllabiDictionaries{syllabusFileNum,1} = courseDept;
  syllabiDictionaries{syllabusFileNum,2} = courseName;
  syllabiDictionaries{syllabusFileNum,3} = courseNum;
  syllabiDictionaries{syllabusFileNum,4} = syllabusWordCount;
  syllabiDictionaries{syllabusFileNum,5} = syllabusWordDistribution;
  
  save('SyllabiDictionairies/syllabiDictionaries','syllabiDictionaries');
  fclose('all');
end
fprintf('Dictionary generaion complete.')