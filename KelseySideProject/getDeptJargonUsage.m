%% Input: department jargon info; department vocabs
%  output: percentage of dept vocab that is jargon
load('deptVocab');
load('deptJargon');

deptJargonUsage = cell(size(deptVocab));
deptJargonUsage{1,1} = 'Department Name';
deptJargonUsage{1,2} = 'Department Jargon Usage %';
for dept =2:size(deptVocab,1)
    numOfJargonWords = length(deptJargon{dept,2});
    numOfVocabWords = length(deptVocab{dept,2});
    deptJargonUsage{dept,1} = deptJargon{dept,1};
    deptJargonUsage{dept,2} = 100*numOfJargonWords/numOfVocabWords;
end
save('deptJargonUsage','deptJargonUsage');