function q6b()
% depedent functions
% q6_W
% q6_train
% q6_predict
% q6_test_error
% q5_features
% q5_mse

checking('q6b');


% Loading in data from the file
S = load('autompg.mat');
X = S.trainsetX;
Y = S.trainsetY;
Xt = S.testsetX;
Yt = S.testsetY;

clear S;

% set of \tau parameters 
tau = 10.^[2:3 5:6]; 

% perform full evaluation on test set
test_errors = q6_test_error(X, Y, Xt, Yt, tau);

% close curent opening figures
close all;

% plotting test errors versus different tau parameters
plot(log10(tau), test_errors, '-*r');
ylabel('squared error per sample');
title('test error of locally weighted least square with b^l(x)');
xlabel('log_{10} \tau');
grid on;

saveas(gcf, 'q6b.fig');
print(gcf, '-depsc2', 'q6b.eps');
