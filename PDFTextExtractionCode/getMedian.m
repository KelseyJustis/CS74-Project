function [median, parserIndex] = getMedian(file_name, medians, classes, term)
    median = 0;
    
    letterGrades = {'A', 'A-', 'B+', 'B', 'B-', 'A/A-', 'A-/B+', 'B+/B', 'B/B-'};
    letterToGPA = [4.0, 3.67, 3.33, 3.0, 2.67, 3.83, 3.5, 3.17, 2.83];
    
    S = file_name(1:end-4);
    nameSplit = strsplit(S, '-');
    
    classNum = str2double(nameSplit(1, 2));
    nameSplit{1, 2} = num2str(classNum);
    
    if size(nameSplit, 2) == 3 
        nameSplit = [nameSplit {'1'}];
    end
    
    reform = strcat(nameSplit(1,1), '-', nameSplit(1,2), '-', nameSplit(1,4));
    
    ind=find(ismember(term,nameSplit{1, 3}));
    
    found = 0;
    for i = ind.'
        if strcmp(classes{i, 1}, reform)
           letterGrade = medians{i, 1};
           letterGrade = letterGrade(~isspace(letterGrade));
           [~, j] = ismember(letterGrade, letterGrades);
           
           median = letterToGPA(1, j);      
           found = 1;
           parserIndex = i;     
        end
       
    end
    if found == 0
       disp(file_name);
       median = -1;
    end    
end
