% This code is attached to paper 'Investigating the Distribution of Learning Coverage in MOOCs',
% submitted to Special Issue "Supporting Technologies and Enablers for Big Data"
% under journal Information

% Copyright (c) 2017 Chang Men
%-------------------------------------------------------------------------------------------------
% This code is a function calculating the log-likelihood function of data x and its
% gradient respect to alpha
% Parameters:
% ---- alpha: exponent parameter in Zipf's law
% ---- x: sample data, a list of the number of student having that learning coverage
% Return:
% ---- f: log-likelihood value of given alpha and x
% ---- gradient: the gradient of log-likelihood function respect to alpha 
%-------------------------------------------------------------------------------------------------

function [f,grad ] = ln_likelihood(alpha,x)

l = length(x);
n = sum(x);
ilist = 1:l;
s = 0;
for i=1:l
    s = s + sum( log(1:x(i)) );
end

f = n*log(sum(ilist.^(-alpha))) + alpha*sum(x'.*log(ilist)) - sum(log(ilist)) + s;
grad = sum(x'.*log(ilist)) - n*sum( (ilist.^(-alpha)) .* log(ilist) ) / sum(ilist.^(-alpha));



