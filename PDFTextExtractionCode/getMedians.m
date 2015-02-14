fid = fopen('MedianGrades.csv');
out = textscan(fid,'%s%s%s%s','delimiter',',');
fclose(fid);

term = out{1};
class = out{2};
enrollment = out{3};
for i=1:size(class, 1)
   classSplit = strsplit(class{i, 1}, '-'); 
   classNum = str2double(classSplit(1, 2));
   classSplit{1, 2} = num2str(classNum);
   
   classNum2 = str2double(classSplit(1, 3));
   classSplit{1, 3} = num2str(classNum2);
   
   class{i, 1} = strcat(classSplit(1,1), '-', classSplit(1,2), '-', classSplit(1,3));
end    
median = out{4};
count = 0;
files = dir('TEST/*.txt');
for file = files'
    S = file.name(1:end-4);
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
        if strcmp(class{i, 1}, reform)
           found = 1;
           count = count + 1;
        end    
    end
    if found == 0
       disp(file.name);
    end    
end


