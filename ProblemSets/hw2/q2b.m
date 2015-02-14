function q2b()
% This script requires the following functions to be implemented:
% q2_initialize
% q2_predict
% q2_loglik
% q2_gradient
% q2_train
% q2_error
% q2_train_line_search

assert(checking('q2b')==0);

% load data
S = load('parkinsons.mat');
X = S.trainsetX;
Y = S.trainsetY;
Xtest = S.testsetX;
Ytest = S.testsetY;

clear S;

% adding bias term on the features
N = size(X,1);
X = [ones(N,1) X];
N = size(Xtest,1);
Xtest = [ones(N,1) Xtest];

alpha = 10^-6; % learning rate for gradient ascent
large_alpha = 10^-4;

tol = 6; % tolerance on the norm of the gradient to decide when to stop

theta_init = q2_initialize(X, Y, 'heuristic');
[theta1, n_iter1, loglik1] = q2_train(X, Y, theta_init, alpha, tol);

[pred_Y, ~] = q2_predict(X, theta1);
train_error1 = q2_error(Y, pred_Y);

[pred_Ytest, ~] = q2_predict(Xtest, theta1);
test_error1 = q2_error(Ytest, pred_Ytest);

fprintf('Gradient ascent using fixed alpha=%.6f\n', alpha);
fprintf('Number of iterations: %d\n', n_iter1);
fprintf('Training error: %f%%\n', train_error1*100);
fprintf('Testing error: %f%%\n', test_error1*100);

[theta2, n_iter2, loglik2] = q2_train_line_search(X, Y, theta_init, large_alpha, tol);

[pred_Y, ~] = q2_predict(X, theta2);
train_error2 = q2_error(Y, pred_Y);

[pred_Ytest, ~] = q2_predict(Xtest, theta2);
test_error2 = q2_error(Ytest, pred_Ytest);

fprintf('Gradient ascent using line search\n');
fprintf('Number of iterations: %d\n', n_iter2);
fprintf('Training error: %f%%\n', train_error2*100);
fprintf('Testing error: %f%%\n', test_error2*100);

% close curent opening figures
close all;

plot(1:n_iter1, loglik1, 'bo--');
hold on;
plot(1:n_iter2, loglik2, 'rs--');
ylabel('Data log likelihood');
title('Log likelihood plotting of gradient ascent');
xlabel('Number of iterations');
grid on;
legend('fixed step','line search','Location','SouthEast');

saveas(gcf, 'q2b.fig');