 load('gradeDist');
 gradeDistMat = zeros(size(gradeDist,1)-2,size(gradeDist,2)-1);
for dept=3:size(gradeDist,1)
    for grade=2:size(gradeDist,2)
        gradeDistMat(dept-2,grade-1) = gradeDist{dept,grade};
    end
end
grades = ['A' 'A-' 'B+' 'B' 'B-' 'A/A-' 'A-/B+' 'B+/B', 'B/B-' 'C+' 'C'];
for dept=1:size(gradeDistMat,1)
    bar(gradeDistMat(dept,:),'facecolor', 'k');
    hold on;
end
set(gca,'XTickLabel',{'A' 'A-' 'B+' 'B' 'B-' 'A/A-' 'A-/B+' 'B+/B', 'B/B-' 'C+' 'C'})
xlabel('Median Grades');
ylabel('Number of Courses');
   