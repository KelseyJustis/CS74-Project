function hw2_final_check()

script_list = {'q2a', 'q2b', 'q3a', 'q3b', 'q3c', 'q4a', 'q4b'};

msg = [];
for i=1:size(script_list,2)
    fprintf(['Testing ' script_list{i} '...']);
    if checking(script_list{i})~=0
        msg = [msg 'script ' script_list{i} ' does not pass the format test\n'];
    end
end

if isempty(msg)
    fprintf('Congratulations, all of your functions passed the format tests\n');
else
    fprintf('***** ERROR *****\n');
    fprintf(msg);
end
