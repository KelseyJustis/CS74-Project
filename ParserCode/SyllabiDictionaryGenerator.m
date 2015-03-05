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

  % Syllabus words prep work
  [syllabusWordCount, syllabusVocab, syllabusWordDistribution] = getSyllabiTextInfo(CurrSyllabusFileID);
  syllabiDictionaries{syllabusFileNum,1} = courseDept;
  syllabiDictionaries{syllabusFileNum,2} = courseName;
  syllabiDictionaries{syllabusFileNum,3} = courseNum;
  syllabiDictionaries{syllabusFileNum,4} = syllabusWordCount;
  syllabiDictionaries{syllabusFileNum,5} = syllabusVocab;
  syllabiDictionaries{syllabusFileNum,6} = syllabusWordDistribution;
  
  save('SyllabiDictionairies/syllabiDictionaries','syllabiDictionaries');
  fclose('all');
end
fprintf('Dictionary generaion complete.')