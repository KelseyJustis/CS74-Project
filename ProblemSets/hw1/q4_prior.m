function prob = q4_prior(mu, a, Z)
% Returns the prior for multiple values of mu, given the parameters a and Z.
%
% INPUT
%  mu: [1 x N] vector, containing some values for mu
%  a: scalar
%  Z: scalar
%
% OUTPUT
%  prob: [1 x N] vector containing the prior probabilities associated with the entries of mu
    prob=(1/Z).*(mu.^(a-1)).*((1-mu).^(a-1));
end 