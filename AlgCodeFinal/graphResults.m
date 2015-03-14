function graphResults(error, error_trn, Y)
   baseline = zeros(size(error,1), 1);
   baseline(1:end) = error(1);
  
   plot(0:size(error,1) - 1, error, '-db');
   hold on; 
   plot(0:size(error_trn, 1) - 1, error_trn, '-*r');
   hold on;
   plot(0:size(baseline, 1) - 1, baseline, '--g');

   
   legend('Test Error', 'Training Error', 'Baseline Error (Mean)');
   ylabel('Mean Squared Error');
   title('Final Test Results');
   xlabel('Max Depth of Regression Tree');

end