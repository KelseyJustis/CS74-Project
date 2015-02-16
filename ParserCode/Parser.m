% Cite her: http://www.mathworks.com/matlabcentral/fileexchange/19505-wordcount/content/wordcount.m

addpath('../PDFTextExtractionCode')
regristrarCourseData = '../PDFTextExtractionCode/TEST/MedianGrades.csv';
[term, classes, enrollment, medians] = getCourseData(regristrarCourseData);

%Folder of converted syllabi files from pdf to text format.
folderOfSyllabiTxtFiles = dir('../PDFTextExtractionCode/TEST/TEST/SyllabiTxtFiles/*.txt');

% Loop over each syllabus text file
for fileNumber = 1:length(folderOfSyllabiTxtFiles)
   CurrCourseFileName = folderOfSyllabiTxtFiles(fileNumber).name;
   CurrSyllabusTextFile = fopen(['../PDFTextExtractionCode/TEST/TEST/SyllabiTxtFiles/'  CurrCourseFileName], 'r');
   courseName = char(CurrCourseFileName(1:end-4)); % remove .txt extension to get the course name
   courseNameSplit = strsplit(courseName, '-'); 
   courseDept = str2double(courseNameSplit(1, 1)); % get the course department
   courseNum = str2double(courseNameSplit(1, 2)); % get the course number
   [courseMedian, regristrarCourseDataIndex]  = getMedian(char(CurrCourseFileName),medians,classes,term); %get corresponding medain grade for course
   courseEnrollment = enrollment{regristrarCourseDataIndex};
   if (courseMedian == -1)
       courseMedian = 0;
       courseEnrollment = 0;
   end
   
   CurrSylabusWords = textscan(CurrSyllabusTextFile, '%s');
   
   negWordsTextFile = fopen('../OutsideVocabDatabases/negativeWords.txt', 'r');
   negWords = textscan(negWordsTextFile,'%s','delimiter',',');
   
   %% Words of interest prep work
    % Get rid of all the characters that are not letters or numbers in WordsOfInterest file.
    for Word=1:numel(negWords{1,1})
        ind = find(isstrprop(negWords{1,1}{Word,1}, 'alphanum') == 0);
        negWords{1,1}{Word,1}(ind)=[];
    end

    % Remove words that have zero characters in WordsOfInterest file.
    for Word = 1:numel(negWords{1,1})
        if size(negWords{1,1}{Word,1}, 2) == 0
            negWords{1,1}{Word,1} = ' ';
        end
    end
    
    negWordsVocab = unique(negWords{1,1}); % list of unique words used in the words of interest text file
    
    %% Syllabus prep work
    % Get rid of all the characters that are not letters or numbers
    for Word=1:numel(CurrSylabusWords{1,1})
        ind = find(isstrprop(CurrSylabusWords{1,1}{Word,1}, 'alphanum') == 0);
        CurrSylabusWords{1,1}{Word,1}(ind)=[];
    end

    % Remove words that have zero characters
    for Word = 1:numel(CurrSylabusWords{1,1})
        if size(CurrSylabusWords{1,1}{Word,1}, 2) == 0
            CurrSylabusWords{1,1}{Word,1} = ' ';
        end
    end
    
    syllabusVocab = unique(CurrSylabusWords{1,1});
    
%     %% Check overlap of words of interest in syllabus vocab
%     negWordsInSyllabus = ismember(negWordsVocab,syllabusVocab); % binary list of which words of interest are present (1 if present, 0 if not)
%     sum(negWordsInSyllabus); %tells how many words are shared between both files
%     negWordsVocab(negWordsInSyllabus); % Prints out words common to both txt files
    
    
    %% Now count the number of times a negative word is used in the syllabus
    negWordFreq = zeros(numel(negWordsVocab), 1);

    for Word = 1:numel(negWordsVocab)
        if max(negWordsVocab{Word} ~= ' ')
            for j = 1:numel(CurrSylabusWords{1,1})
                if strcmpi(CurrSylabusWords{1,1}(j), negWordsVocab{Word})
                    negWordFreq(Word) = negWordFreq(Word) + 1;
                end
            end
        end
    end
   numOfNegWords = sum(negWordFreq);
   totNumOfWordsInSyllabus = numel(CurrSylabusWords{1,1});
   totNumOfUniqueWordsInSyllabus = numel(find(syllabusWordFreq));
  save('mediansData','courseMedian','-append'); % save a data matrix for median grades
  save('courseFeaturesData','courseName','courseNum','totNumOfWordsInSyllabus','courseEnrollment','numOfNegWords','-append');
  fclose('all');
end
