function graphResults(error, error_trn, Y)
   baseline = zeros(size(error,1), 1);
   baseline(1:end) = sampleVariance(Y);
   

   
   plot(1:size(error,1), error, '-db');
   hold on; 
   plot(1:size(error_trn, 1), error_trn, '-*r');
   hold on;
   plot(1:size(baseline, 1), baseline, '--g');

   
   legend('Test Error', 'Training Error', 'Data Variance');
   ylabel('Mean Squared Error');
   title('Preliminary Test Results');
   xlabel('Max Depth of Regression Tree');

end