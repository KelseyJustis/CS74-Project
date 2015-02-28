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
numOfCourses = 3;% length(folderOfSyllabiTxtFiles);
X = cell(numOfCourses,numOfFeatures);
Y = zeros(numOfCourses,1);

%% Words to compare prep work
% Negative words prep work
negWordsFileID = fopen('../OutsideVocabDatabases/negativeWords.txt', 'r');
[negWordCount, negWordsVocab] = getFeatureTextInfo(negWordsFileID);

% Loop over each syllabus text file
for fileNumber = 1:numOfCourses
  %% Get course syllabus information
  CurrSyllabusFileName = folderOfSyllabiTxtFiles(fileNumber).name;
  CurrSyllabusFileID = fopen(['../PDFTextExtractionCode/TEST/TEST/SyllabiTxtFiles/'  CurrSyllabusFileName], 'r');
  courseName = char(CurrSyllabusFileName(1:end-4)); % remove .txt extension to get the course name
  courseNameSplit = strsplit(courseName, '-'); 
  courseDept = str2double(courseNameSplit(1, 1)); % get the course department
  courseNum = str2double(courseNameSplit(1, 2));  % get the course number
  [courseMedian, regristrarCourseDataIndex]  = getMedian(char(CurrSyllabusFileName),medians,classes,term); %get corresponding medain grade for course
  courseEnrollment = enrollment{regristrarCourseDataIndex}; % get the course enrollement 
  
  % If no data found for course median
  if (courseMedian == -1)
       courseMedian = 0;
       courseEnrollment = 0;
  end
  
  % save a data matrix for median grades
  Y(fileNumber) = courseMedian;
  save('mediansData','Y');

  % Syllabus words prep work
  [syllabusWordCount, syllabusVocab, syllabusWordDistribution] = getSyllabiTextInfo(CurrSyllabusFileID);

  %% Analyze the syllabus with respect to the negative words list
  [numOfNegWords, NegWordsPresent, NegWordFrequency, IndividualNegWordFrequency] = compareFileContent(negWordsVocab, syllabusVocab, syllabusWordDistribution)  
  
  X{fileNumber,1} = courseName;
  X{fileNumber,2} = courseNum;
  X{fileNumber,3} = SyllabusWordCount;
  X{fileNumber,4} = courseEnrollment;
  X{fileNumber,5} = numOfNegWords;
  X{fileNumber,6} = labWordFreq;
  X{fileNumber,7} = percentSignFreq;
  X{fileNumber,8} = noExceptionsFreq;
  save('courseFeaturesData','X');
  fclose('all');
end