load('gradeDist');
load('deptJargonUsage');

deptGradeVals = cell2mat(deptGradeDist(2:end,2));
deptJargonUsageVals = cell2mat(deptJargonUsage(2:end,2));
deptNames =[deptGradeDist{2:end,1}]';

scatter(deptGradeVals,deptJargonUsageVals,'k');
xlabel('Average Median Grade');
ylabel('Jargon Usage [%]');

%label points with deptartment name
for i=1:length(deptNames)
    x = deptGradeVals(i);
    y = deptJargonUsageVals(i);
    dx = 0.01; 
    dy = 1; % displacement so the text does not overlay the data points
    text(x+dx, y+dy, deptNames(i),'color',[0,0.5,0]);
end