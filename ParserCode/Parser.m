% Cite her: http://www.mathworks.com/matlabcentral/fileexchange/19505-wordcount/content/wordcount.m
%% Program Description
% Program takes in formatted data and syllabus .txt files and out put
% matrices with features specified to be used with ML algorithims.
% INPUT:
% Formatted registrar office median and course information and syllabus .txt files
%
% OUTPUT:
%  X: a matrix [m x n], with each row containing a different course's features and
%  each column a different feature:
% 
%     X(fileNumber,feature) := feature for given syllabus file 
%     X(:,1) := Course Name
%     X(:,2) := Course Number
%     X(:,3) := Total Number Of Words In Course Syllabus
%     X(:,4) := Course Enrollment
%     X(:,5) := Number Of Negative Words
%     X(:,6) := Number of time mentioning specific words of interest such as lab,
%               homework,etc.
%     X(:,7) := Percent sign frequency
%
%  Y: a matrix [m x 1], with each row containing a different course median
%  grade:
%     Y(:,1) = courseMedian

addpath('../PDFTextExtractionCode')
regristrarCourseData = '../PDFTextExtractionCode/TEST/MedianGrades.csv';
[term, classes, enrollment, medians] = getCourseData(regristrarCourseData);

%Folder of converted syllabi files from pdf to text format.
folderOfSyllabiTxtFiles = dir('../PDFTextExtractionCode/TEST/TEST/SyllabiTxtFiles/*.txt');
numOfFeatures = 8;
numOfCourses = length(folderOfSyllabiTxtFiles);
X = cell(numOfCourses,numOfFeatures);
Y = zeros(numOfCourses,1);
% Loop over each syllabus text file
for fileNumber = 1:numOfCourses
   CurrCourseFileName = folderOfSyllabiTxtFiles(fileNumber).name;
   CurrSyllabusTextFile = fopen(['../PDFTextExtractionCode/TEST/TEST/SyllabiTxtFiles/'  CurrCourseFileName], 'r');
   courseName = char(CurrCourseFileName(1:end-4)); % remove .txt extension to get the course name
   courseNameSplit = strsplit(courseName, '-'); 
   courseDept = str2double(courseNameSplit(1, 1)); % get the course department
   courseNum = str2double(courseNameSplit(1, 2)); % get the course number
   [courseMedian, regristrarCourseDataIndex]  = getMedian(char(CurrCourseFileName),medians,classes,term); %get corresponding medain grade for course
   courseEnrollment = enrollment{regristrarCourseDataIndex, 1};
   if (courseMedian == -1)
       courseMedian = 0;
       courseEnrollment = 0;
   end
   Y(fileNumber) = courseMedian;
   save('mediansData','Y'); % save a data matrix for median grades

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
    percentSignFreq =  0;
    % Get rid of all the characters that are not letters or numbers
    for Word=1:numel(CurrSylabusWords{1,1})
        percentSignFreq =  percentSignFreq + length(strfind(CurrSylabusWords{1,1}{Word,1},'%'));
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
    
    %% Now count the number of times a negative word is used in the syllabus
    negWordFreq = zeros(numel(negWordsVocab), 1);
    labWordFreq = 0;
    noExceptionsFreq =0;
    for Word = 1:numel(negWordsVocab)
        if max(negWordsVocab{Word} ~= ' ')
            for j = 1:numel(CurrSylabusWords{1,1})
                if strcmpi(CurrSylabusWords{1,1}(j), negWordsVocab{Word})
                    negWordFreq(Word) = negWordFreq(Word) + 1;
                end
                
                % count the number of times lab or Lab is used in the syllabus
                if strcmpi(CurrSylabusWords{1,1}(j), 'lab')
                    labWordFreq = labWordFreq + 1;
                end
                if strcmpi(CurrSylabusWords{1,1}(j), 'labs')
                    labWordFreq = labWordFreq + 1;
                end
            end
        end
    end
  numOfNegWords = sum(negWordFreq);

  totNumOfWordsInSyllabus = numel(CurrSylabusWords{1,1}); 
  X{fileNumber,1} = courseName;
  X{fileNumber,2} = courseNum;
  X{fileNumber,3} = totNumOfWordsInSyllabus;
  X{fileNumber,4} = courseEnrollment;
  X{fileNumber,5} = numOfNegWords;
  X{fileNumber,6} = labWordFreq;
  X{fileNumber,7} = percentSignFreq;
  X{fileNumber,8} = noExceptionsFreq;
  save('courseFeaturesData','X');
  fclose('all');
end