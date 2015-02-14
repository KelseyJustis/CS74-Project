function lik = q4_likelihood(mu, m, H)
% Returns the likelihood for different values of mu, given the scalar parameters m and H.
%
% INPUT
%  mu: [1 x N] vector, containing N different values for mu
%  m: scalar
%  H: scalar
%
% OUTPUT
%  lik: [1 x N] vector containing the likelihood values associated with the entries of mu
    lik=(mu.^H).*((1-mu).^(m-H));
end