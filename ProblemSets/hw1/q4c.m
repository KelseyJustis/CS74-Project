function q4c()
% depedent functions
% q4_likelihood

checking('q4c');


% some example values for mu
mu = [0:0.005:1];

% case 1
figure
subplot(1,3,1);
m = 1;
H = 1;
lik = q4_likelihood(mu, m, H);
plot(mu, lik);
title('m=1, H=1');
xlabel('\mu');
ylabel('L');

% case 2
subplot(1,3,2);
m = 100;
H = 100;
lik = q4_likelihood(mu, m, H);
plot(mu, lik);
title('m=100, H=100');
xlabel('\mu');
ylabel('L');

% case 3
subplot(1,3,3);
m = 100;
H = 80;
lik = q4_likelihood(mu, m, H);
plot(mu, lik);
title('m=100, H=80');
xlabel('\mu');
ylabel('L');

saveas(gcf, 'q4c.fig');

end
