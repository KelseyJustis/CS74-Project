function q4d()
% depedent functions
% q4_prior

checking('q4d');


% some values for mu
mu = [0:0.005:1];

% case 1
a=2;
Z = 1/6;
prob = q4_prior(mu, a, Z);
figure;
plot(mu, prob, '-b');
xlabel('\mu');
ylabel('p(\mu; a)');

% case 2
hold on;
a=10;
Z = 1/923780;
prob = q4_prior(mu, a, Z);
plot(mu, prob, '-r');
title('prior');
legend('a=2', 'a=10');

saveas(gcf, 'q4d.fig');

end
