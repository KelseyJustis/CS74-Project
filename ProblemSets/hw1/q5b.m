function q5b()
% depedent functions
% q5_features
% q5_mse
% q5_train
% q5_predict
% q5_cross_validation_error

checking('q5b');


% Load data
S = load('autompg.mat');
X = S.trainsetX;
Y = S.trainsetY;
clear S

% Try different lambda with a linear model
lambda = 10.^[-5:2:7];
error = q5_cross_validation_error(X, Y, lambda, 'linear', 10);
% Plot the results
figure;
subplot(2,1,1);
plot(log10(lambda), error, '-db');
ylabel('squared error per sample');
title('cross validation error for regularized least square with b^l(x)');
xlabel('log_{10}\lambda');

% Try different lambda with a quadratic model
lambda = 10.^[-5:2:7];
error = q5_cross_validation_error(X, Y, lambda, 'quadratic', 10);
% Plot the results
subplot(2,1,2);
plot(log10(lambda), error, '-db');
ylabel('squared error per sample');
title('cross validation error for regularized least square with b^q(x)');
xlabel('log_{10}\lambda');

saveas(gcf, 'q5b.fig');

end

