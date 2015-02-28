[term, classes, enrollment, medians] = getCourseData('MedianGrades.csv');

files = dir('TEST/TEST/SyllabiTxtFiles/*.txt');
for file = files'
    [median, ~] = getMedian(file.name, medians, classes, term);
end


