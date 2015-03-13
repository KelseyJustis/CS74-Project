function [gradeDist] = getMedianCountData()
[data] = formatData('MedianGrades.csv');
gradeDist={ [] 'A' 'A-' 'B+' 'B' 'B-' 'A/A-' 'A-/B+' 'B+/B', 'B/B-' 'C+' 'C'};
allIndex = 2;
AIndex = 2;
gradeDist{allIndex,AIndex-1} = 'All Courses';
gradeDist{allIndex,AIndex}= sum([data{2:end,4}]==4.0);
gradeDist{allIndex,AIndex + 1} = sum([data{2:end,4}]==3.67);
gradeDist{allIndex,AIndex + 2} = sum([data{2:end,4}]==3.33);
gradeDist{allIndex,AIndex + 3} = sum([data{2:end,4}]==3.0);
gradeDist{allIndex,AIndex + 4} = sum([data{2:end,4}]==2.67);
gradeDist{allIndex,AIndex + 5} = sum([data{2:end,4}]==3.83);
gradeDist{allIndex,AIndex + 6} = sum([data{2:end,4}]==3.5);
gradeDist{allIndex,AIndex + 7} = sum([data{2:end,4}]==3.17);
gradeDist{allIndex,AIndex + 8} = sum([data{2:end,4}]==2.83);
gradeDist{allIndex,AIndex + 9} = sum([data{2:end,4}]==2.33);
gradeDist{allIndex,AIndex + 10} = sum([data{2:end,4}]==2);

deptNames = unique(data(2:end,1));
numOfDepts = length(deptNames);
currDeptName = deptNames(1);
for i=1:numOfDepts
     gradeDist{allIndex + i,1} = deptNames(i);
     for j=2:size(gradeDist,2)
         gradeDist{allIndex + i,j} = 0;
     end
end

for i=2:size(data,1)
    currDeptName = char(data{i,1});
    deptIndex = min(find(ismember([gradeDist{3:end,1}],currDeptName)==1))+2;
    median = data{i,4};
    switch median
        case 4.0
            gradeDist{deptIndex,AIndex} = gradeDist{deptIndex,AIndex} + 1;
        case 3.67
            gradeDist{deptIndex,AIndex + 1} = gradeDist{deptIndex,AIndex + 1} + 1;
        case 3.33
            gradeDist{deptIndex,AIndex + 2} = gradeDist{deptIndex,AIndex + 2} + 1;
        case 3.0
            gradeDist{deptIndex,AIndex + 3} = gradeDist{deptIndex,AIndex + 3} + 1;
        case 2.67
            gradeDist{deptIndex,AIndex + 4} = gradeDist{deptIndex,AIndex + 4} + 1;
        case 3.83
            gradeDist{deptIndex,AIndex + 5} = gradeDist{deptIndex,AIndex + 5} + 1;
        case 3.5
            gradeDist{deptIndex,AIndex + 6} = gradeDist{deptIndex,AIndex + 6} + 1;
        case 3.17
            gradeDist{deptIndex,AIndex + 7} = gradeDist{deptIndex,AIndex + 7} + 1;
        case 2.83
            gradeDist{deptIndex,AIndex + 8} = gradeDist{deptIndex,AIndex + 8} + 1;
        case 2.33
            gradeDist{deptIndex,AIndex + 9} = gradeDist{deptIndex,AIndex + 9} + 1;
        case 2.0
            gradeDist{deptIndex,AIndex + 10} = gradeDist{deptIndex,AIndex + 10} + 1;
    end
end