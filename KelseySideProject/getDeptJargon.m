%% Input: Department vocab
%  Output: Department vocab not shared with outher departments and
%  frequency of shares with other departments

load('deptVocab');
numOfDepts = length(deptVocab) - 1;
deptJargon = cell(numOfDepts + 1,3);
deptJargon{1,1} = 'Department Name';
deptJargon{1,2} = 'Department Jargon';
deptJargon{1,3} = 'Department Vocab Comparision';


for currDept=2:numOfDepts+1
    currDeptName = deptVocab{currDept,1};
    currDeptVocab =deptVocab{currDept,2};
    deptJargon{currDept,1} = currDeptName; % Assign current department name
    
    % Creates a matrix to hold information on how departments compare
    deptVocabShared = cell(numOfDepts+1,3);
    deptVocabShared{1,1} = 'Department Shared With';
    deptVocabShared{1,2} = '# Of Words Shared';
    deptVocabShared{1,3} = 'Department Vocab Shared';
    
    % Assign self/trivial comparision values
    deptVocabShared{currDept,1} = currDeptName;
    deptVocabShared{currDept,2} = length(currDeptVocab);
    deptVocabShared{currDept,3} = currDeptVocab;
    allVocabShared = [];
    vocabShared = [];
    % Compare each department's vocab to current department's vocab
    for dept = 2:numOfDepts+1
        if (dept~=currDept)
            compareDeptVocab = deptVocab{dept,2};
            compareDeptInd = ismember(currDeptVocab,compareDeptVocab); % Find indices of vocab word shared current and comparision department
            numOfWordsShared = sum(compareDeptInd); % How many words are shared with comparing dept
            vocabShared = currDeptVocab(compareDeptInd); % What words are shared with comparing dept
            
            % Assign to comparision matrix
            deptVocabShared{dept,1} = deptVocab{dept,1}; 
            deptVocabShared{dept,2} = numOfWordsShared;
            deptVocabShared{dept,3} = vocabShared;
        end
        % Keep track of all words shared with all departments
        allVocabShared = [allVocabShared; vocabShared];   
    end
    deptJargon{currDept,3} = deptVocabShared;
    notDeptJargon = unique(allVocabShared);
    if (size(notDeptJargon,1)>0)
        removeIndices = ismember(currDeptVocab, notDeptJargon);
        deptJargon{currDept,2} = currDeptVocab(~removeIndices);
    else
        deptJargon{currDept,2} = currDeptVocab;
    end
end
save('deptJargon','deptJargon');