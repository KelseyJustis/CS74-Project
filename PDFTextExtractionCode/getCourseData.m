function [term, classes, enrollment, medians] = getCourseData(file_name)

    fid = fopen(file_name);
    out = textscan(fid,'%s%s%s%s','delimiter',',');
    fclose(fid);

    term = out{1};
    classes = out{2};
    enrollment = out{3};
    for i=1:size(classes, 1)
       classSplit = strsplit(classes{i, 1}, '-'); 
       classNum = str2double(classSplit(1, 2));
       classSplit{1, 2} = num2str(classNum);

       classNum2 = str2double(classSplit(1, 3));
       classSplit{1, 3} = num2str(classNum2);

       classes{i, 1} = strcat(classSplit(1,1), '-', classSplit(1,2), '-', classSplit(1,3));
    end    
    medians = out{4};

end




