function prob = q4_posterior(mu, m, H, a, Z)
% Returns the posterior for multiple values of mu, given the parameters m, H, a, and Z.
%
% INPUT
%  mu: [1 x N] vector, containing some values for mu
%  m: scalar
%  H: scalar
%  a: scalar
%  Z: scalar
%
% OUTPUT
%  prob: [1 x N] vector containing the posterior values associated with the entries of mu

    likelihood=q4_likelihood(mu, m, H);
    prior=q4_prior(mu, a, Z);
    prob=likelihood.*prior;
end