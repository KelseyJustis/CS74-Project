fid = fopen('../PDFTextExtractionCode/TEST/MedianGrades.csv');
out = textscan(fid,'%s%s%s%s','delimiter',',');
fclose(fid);

termColumn = out{1};
classColumn = out{2};
enrollmentColumn = out{3};
for classRow=1:size(classColumn, 1)
   className = strsplit(classColumn{classRow, 1}, '-'); 
   classNum = str2double(className(1, 2));
   className{1, 2} = num2str(classNum);
   
   classSectionNum = str2double(className(1, 3));
   className{1, 3} = num2str(classSectionNum);
   
   classColumn{classRow, 1} = strcat(className(1,1), '-', className(1,2), '-', className(1,3));
end  

medianColumn = out{4};
count = 0;
PDFSyllabiFiles = dir('TEST/*.txt');
for Syllabus = PDFSyllabiFiles'
    txtFileName = Syllabus.name(1:end-4);
    nameSplit = strsplit(txtFileName, '-');
    
    classNum = str2double(nameSplit(1, 2));
    nameSplit{1, 2} = num2str(classNum);
    
    if size(nameSplit, 2) == 3 
        nameSplit = [nameSplit {'1'}];
    end
    
    reform = strcat(nameSplit(1,1), '-', nameSplit(1,2), '-', nameSplit(1,4));
    
    ind=find(ismember(termColumn,nameSplit{1, 3}));

    found = 0;
    for classRow = ind.'
        if strcmp(classColumn{classRow, 1}, reform)
           found = 1;
           count = count + 1;
        end    
    end
    if found == 0
       disp(Syllabus.name);
    end    
end


