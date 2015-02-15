addpath('../PDFTextExtractionCode')
file_name = '../PDFTextExtractionCode/TEST/MedianGrades.csv';
[term, classes, enrollment, medians] = getCourseData(file_name);

deptNameList = classes;
for classRow=1:length(classes)
    classRowString = strsplit(char(classes{classRow}), '-');
    classDeptName = strtrim(classRowString(1));
    deptNameList(classRow) = classDeptName;       
end
deptNameList = unique(deptNameList);

numOfGradeTypes =7;
deptMedianCount = zeros(length(deptNameList),numOfGradeTypes);
for dept = 1:length(deptNameList)
   deptName = deptNameList{dept};
   for classRow=1:length(classes)
        classRowString = strsplit(char(classes{classRow}), '-');
        classDeptName = strtrim(char(classRowString(1)));
        medianGrade = char(medians{classRow});

        if strcmpi(classDeptName,deptName) 
            switch medianGrade
                case 'A'
                    deptMedianCount(dept,1) = deptMedianCount(dept,1) + 1;
                case 'A-'
                    deptMedianCount(dept,2) = deptMedianCount(dept,2) + 1;
                case 'B+'
                    deptMedianCount(dept,3) = deptMedianCount(dept,3) + 1;
                case 'B'
                    deptMedianCount(dept,4) = deptMedianCount(dept,4) + 1;
                case 'B-'
                    deptMedianCount(dept,5) = deptMedianCount(dept,5) + 1;
                case 'C+'
                    deptMedianCount(dept,6) = deptMedianCount(dept,6) + 1;
                case 'C'
                    deptMedianCount(dept,7) = deptMedianCount(dept,7) + 1;
                otherwise
                    break
            end
        end
   end
end

for dept = 1:length(deptNameList)
    fprintf([ deptNameList{dept} ' department grade distribution is: ' '\n']);
    numOfGrades = sum(deptMedianCount(dept,:));
    fprintf(['A :' num2str(deptMedianCount(dept,1)) ', ' num2str(100*(deptMedianCount(dept,1)/numOfGrades)) '%% of deptartment grades' '\n']);
    fprintf(['A-:' num2str(deptMedianCount(dept,2)) ', ' num2str(100*(deptMedianCount(dept,2)/numOfGrades)) '%% of deptartment grades' '\n']);
    fprintf(['B+:' num2str(deptMedianCount(dept,3)) ', ' num2str(100*(deptMedianCount(dept,3)/numOfGrades)) '%% of deptartment grades' '\n']);
    fprintf(['B :' num2str(deptMedianCount(dept,4)) ', ' num2str(100*(deptMedianCount(dept,4)/numOfGrades)) '%% of deptartment grades' '\n']);
    fprintf(['B-:' num2str(deptMedianCount(dept,5)) ', ' num2str(100*(deptMedianCount(dept,5)/numOfGrades)) '%% of deptartment grades' '\n']);
    fprintf(['C+:' num2str(deptMedianCount(dept,6)) ', ' num2str(100*(deptMedianCount(dept,6)/numOfGrades)) '%% of deptartment grades' '\n']);
    fprintf(['C :' num2str(deptMedianCount(dept,7)) ', ' num2str(100*(deptMedianCount(dept,7)/numOfGrades)) '%% of deptartment grades' '\n \n']);
end

