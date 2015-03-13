function[formattedData] = formatData(fileName)
    [term, courses, enrollment, medians] = getCourseData('MedianGrades.csv');
    formattedData = {'Department' 'Course' 'Term' 'Median'};

    letterGrades = {'A', 'A-', 'B+', 'B', 'B-', 'A/A-', 'A-/B+', 'B+/B', 'B/B-' 'C+' 'C'};
    letterToGPA = [4.0, 3.67, 3.33, 3.0, 2.67, 3.83, 3.5, 3.17, 2.83 2.66 2.0];

    for i=2:length(courses)
        formattedData(i,2) = courses(i);
        formattedData(i,3) = term(i);
        letterGrade = medians{i};
        letterGrade = letterGrade(~isspace(letterGrade));
        [~, j] = ismember(letterGrade, letterGrades);
        median = letterToGPA(1, j);  
        formattedData(i,4) = {median};
        courseName = char(courses{i}); % remove .txt extension to get the course name
        courseNameSplit = strsplit(courseName, '-'); 
        courseDept = char(courseNameSplit(1, 1)); % get the course department
        formattedData(i,1) = {courseDept}; 
    end
end