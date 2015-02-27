function graphResults(error, error_trn, Y)
   baseline = zeros(size(error,1), 1);
   baseline(1:end) = sampleVariance(Y);
   
   bad_choice_error = zeros(size(error, 1), 1);
   bad_choice_error(1:size(error, 1), 1) = MSE(sum(Y)/size(Y, 1), Y);
   
   
   plot(1:size(error,1), error, '-db');
   hold on; 
   plot(1:size(error_trn, 1), error_trn, '-*r');
   hold on;
   plot(1:size(baseline, 1), baseline, '--g');
   hold on;
   plot(1:size(bad_choice_error, 1), bad_choice_error, '--r');
   
   legend('Test Error', 'Training Error', 'Data Variance');
   ylabel('Mean Squared Error');
   title('Preliminary Test Results');
   xlabel('Max Depth of Regression Tree');

end