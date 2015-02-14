function q4g()
% depedent functions
% q4_posterior

checking('q4g');


% some values for mu
mu = [0:0.005:1];

% case 1
figure;
subplot(1,3,1);
m=1;
H = 1;
a = 10;
Z = 1/923780;
prob = q4_posterior(mu, m, H, a, Z);
plot(mu, prob);
title('m=1, H=1');
xlabel('\mu');
ylabel('posterior');

% case 2
subplot(1,3,2);
m= 100;
H = 100;
a = 10;
Z = 1/923780;
prob = q4_posterior(mu, m, H, a, Z);
plot(mu, prob);
title('m=100, H=100');
xlabel('\mu');
ylabel('posterior');

% case 3
subplot(1,3,3);
m=100;
H = 80;
a = 10;
Z = 1/923780;
prob = q4_posterior(mu, m, H, a, Z);
plot(mu, prob);
title('m=100, H=80');
xlabel('\mu');
ylabel('posterior');

saveas(gcf, 'q4g.fig');

end
