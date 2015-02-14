function q6c()
% depedent functions
% q6_W
% q6_train
% q6_predict
% q6_test_error
% q5_features
% q5_mse
% q6_cross_validation_error

checking('q6c');


% Loading in data from the file
S = load('autompg.mat');
X = S.trainsetX;
Y = S.trainsetY;
Xt = S.testsetX;
Yt = S.testsetY;
clear S;

% N fold cross validation
N = 10;

% set of \tau parameters 
tau = 10.^[2:3 5:6]; 

% perform N-fold cross valiadtion
cross_validation_errors = q6_cross_validation_error(X, Y, tau, N);

% perform full evaluation on test set
test_errors = q6_test_error(X, Y, Xt, Yt, tau);

% close curent opening figures
close all;

% plotting test errors versus different tau parameters
plot(log10(tau), cross_validation_errors, '-db');
hold on; plot(log10(tau), test_errors, '-*r');
legend('cross validation', 'test', 'Location', 'SouthEast');
ylabel('square error per sample');
title('test versus cross validation error of locally weighted least square with b^l(x)');
xlabel('log_{10} \tau');
grid on;

saveas(gcf, 'q6c.fig');
print(gcf, '-depsc2', 'q6c.eps');
