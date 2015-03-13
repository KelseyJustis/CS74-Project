%% Input: Vocab for each course
%  Output: Combined vocab for each department
load('filteredSyllabiVocab');
deptNames = unique(syllabiDictionaries(:,1));
numOfDepts = length(deptNames);
deptVocab = cell(numOfDepts + 1,1);
deptVocab{1,1} = 'Department Name';
deptVocab{1,2} = 'Department Vocab';

currDeptName = deptNames(1);
currDeptVocab =[];
j = 2;
for i=1:numOfDepts
    currDeptName = deptNames(i); % Get current dept name
    deptVocab{i+1,1} = currDeptName; % Assign current department name
    currDeptInd = strcmp(syllabiDictionaries(:,1),currDeptName); % find courses with current department
    temp = [false;currDeptInd]; % Shift indices found
    currDeptVocab = filteredSyllabiVocab(temp,2);
    currDeptVocab = vertcat(currDeptVocab{:});
    deptVocab{i+1,2} = unique(currDeptVocab);
end