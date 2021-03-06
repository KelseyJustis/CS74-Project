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
%     X(:,1) := Department
%     X(:,2) := Course Name
%     X(:,3) := Course Number
%     X(:,4) := Course Enrollment
%     X(:,5) := Total Number Of Words In Course Syllabus
%     X(:,6) := Number Of Negative Words (No, Nothing, Never, Not)
%     X(:,7) := Number Of Testing Words (quizzes,tests,exams,etc.?)
%     X(:,8) := Binary; labs are mentioned (1 if present; 0 if not)
%     X(:,9) := Percent sign frequency
%     X(:10) := Binary; projects are mentioned (1 if present; 0 if not)
%     X(:,11):= Number Of homework Words (problemset,essays, homework,etc.?)
%     X(:,12):= Number Of I how much prof says I
%     X(:,13):= Number Of you how much prof says you
%
%  Y: a matrix [m x 1], with each row containing a different course median
%  grade:
%     Y(:,1) = courseMedian
fprintf(['Retrieving registrar course data.\n'])

addpath('../PDFTextExtractionCode')
regristrarCourseData = '../PDFTextExtractionCode/MedianGrades.csv';
[term, classes, enrollment, medians] = getCourseData(regristrarCourseData);
fprintf(['Registrar course data retrieved.\n\n'])

%Folder of converted syllabi files from pdf to text format.
folderOfSyllabiTxtFiles = dir('../PDFTextExtractionCode/TEST/TEST/SyllabiTxtFiles/*.txt');
numOfFeatures = 9;
numOfCourses =  length(folderOfSyllabiTxtFiles);
X = cell(numOfCourses,numOfFeatures);
Y = zeros(numOfCourses,1);

%% Word lists prep work
fprintf(['Compiling feature word dictionaries.\n'])
% Negative words prep work
negWordsFileID = fopen('../OutsideVocabDatabases/negativeWords.txt', 'r');
[negWordCount, negWordsVocab] = getFeatureTextInfo(negWordsFileID);
% Test words prep work
testWordsFileID = fopen('../OutsideVocabDatabases/testingWords.txt', 'r');
[testWordCount, testWordsVocab] = getFeatureTextInfo(testWordsFileID);
% Lab words prep work
labWordsFileID = fopen('../OutsideVocabDatabases/labWords.txt', 'r');
[labWordCount, labWordsVocab] = getFeatureTextInfo(labWordsFileID);
% Project words prep work
projectWordsFileID = fopen('../OutsideVocabDatabases/projectWords.txt', 'r');
[projectWordCount, projectWordsVocab] = getFeatureTextInfo(projectWordsFileID);
% Homework words prep work
homeworkWordsFileID = fopen('../OutsideVocabDatabases/homeworkWords.txt', 'r');
[homeworkWordCount, homeworkWordsVocab] = getFeatureTextInfo(homeworkWordsFileID);
% I words prep work
IWordsFileID = fopen('../OutsideVocabDatabases/IWords.txt', 'r');
[IWordCount, IWordsVocab] = getFeatureTextInfo(IWordsFileID);
% you words prep work
youWordsFileID = fopen('../OutsideVocabDatabases/youWords.txt', 'r');
[youWordCount, youWordsVocab] = getFeatureTextInfo(youWordsFileID);


fprintf(['Feature word dictionaries compiled.\n\n'])

fprintf(['Parsing process initialized.\n'])
% Loop over each syllabus text file
for fileNumber = 1:numOfCourses
  fprintf(['...Parsing file ' num2str(fileNumber) '/' num2str(numOfCourses) ' (Process ' sprintf('%.1f%s', fileNumber*100/numOfCourses) '%% complete)...' '\n']);
  %% Get course syllabus information
  CurrSyllabusFileName = folderOfSyllabiTxtFiles(fileNumber).name;
  CurrSyllabusFileID = fopen(['../PDFTextExtractionCode/TEST/TEST/SyllabiTxtFiles/'  CurrSyllabusFileName], 'r');
  courseName = CurrSyllabusFileName(1:end-4); % remove .txt extension to get the course name
  courseNameSplit = strsplit(courseName, '-'); 
  courseDept = char(courseNameSplit(1, 1)); % get the course department
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
  [syllabusWordCount, syllabusVocab, syllabusWordDistribution,percentSignFreq] = getSyllabiTextInfo(CurrSyllabusFileID);

  %% Analyze the syllabus with respect to various word lists
  % Negative words
  [numOfNegWords, NegWordsPresent, NegWordFrequency, IndividualNegWordFrequency] = compareFileContent(negWordsVocab, syllabusVocab, syllabusWordDistribution);  
  
  % Test words
  [numOfTestWords, TestWordsPresent, TestWordFrequency, IndividualTestWordFrequency] = compareFileContent(testWordsVocab, syllabusVocab, syllabusWordDistribution);  
  
  % Lab words
  [numOfLabWords, LabWordsPresent, LabWordFrequency, IndividualLabWordFrequency] = compareFileContent(labWordsVocab, syllabusVocab, syllabusWordDistribution);  
  labWordPresent = (numOfLabWords >0);
  
  % Project words
  [numOfProjectWords, ProjectWordsPresent, ProjectWordFrequency, IndividualProjectWordFrequency] = compareFileContent(projectWordsVocab, syllabusVocab, syllabusWordDistribution);  
  projectWordPresent = (numOfProjectWords >0);
   % Homework words
  [numOfHomeworkWords, HomeworkWordsPresent, HomeworkWordFrequency, IndividualHomeworkWordFrequency] = compareFileContent(homeworkWordsVocab, syllabusVocab, syllabusWordDistribution);  
   % I words
  [numOfIWords, IWordsPresent, IWordFrequency, IndividualIWordFrequency] = compareFileContent(IWordsVocab, syllabusVocab, syllabusWordDistribution);  
  % you words
  [numOfYouWords, youWordsPresent, youWordFrequency, IndividualYouWordFrequency] = compareFileContent(youWordsVocab, syllabusVocab, syllabusWordDistribution);  
  
  X{fileNumber,1} = courseDept;
  X{fileNumber,2} = courseName;
  X{fileNumber,3} = courseNum;
  X{fileNumber,4} = courseEnrollment;
  X{fileNumber,5} = syllabusWordCount;
  X{fileNumber,6} = NegWordFrequency;
  X{fileNumber,7} = numOfTestWords;
  X{fileNumber,8} = labWordPresent;
  X{fileNumber,9} = percentSignFreq;
  X{fileNumber,10} = projectWordPresent;
  X{fileNumber,11} = HomeworkWordFrequency;
  X{fileNumber,12} = IWordFrequency;
  X{fileNumber,13} = youWordFrequency;
 
  
  
  save('courseFeaturesData','X');
  fclose('all');
end
fprintf('Parsing of all files complete.')