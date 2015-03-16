load('mediansData.mat');
load('courseFeaturesData.mat');

courseGradeDist = cell(1,3);
courseGradeDist{1,1} = 'Department Name';
courseGradeDist{1,2} = 'Course Name';
courseGradeDist{1,3} = 'Course Median';
courseGradeDist = [courseGradeDist;X(:,1:2),num2cell(Y(:),259)];

deptNames = unique(courseGradeDist(2:end,1));
numOfDepts = length(deptNames);

deptGradeDist = cell(numOfDepts + 1,2);
deptGradeDist{1,1} = 'Department Name';
deptGradeDist{1,2} = 'Department Average Median';

currDeptMedian =[];
for dept=1:numOfDepts
    currDeptName = deptNames(dept); % Get current dept name
    deptGradeDist{dept+1,1} = currDeptName; % Assign current department name
    currDeptInd = strcmp(courseGradeDist(:,1),currDeptName);
    numOfDeptCourses = sum(currDeptInd); 
    currDeptMedian = sum([courseGradeDist{currDeptInd,3}])/numOfDeptCourses;
    deptGradeDist{dept+1,2} = currDeptMedian;
end
save('gradeDist','courseGradeDist','deptGradeDist');