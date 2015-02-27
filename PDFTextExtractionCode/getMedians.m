[term, classes, enrollment, medians] = getCourseData('MedianGrades.csv');

files = dir('TEST/*.txt');
for file = files'
    [median, ~] = getMedian(file.name, medians, classes, term);
end


