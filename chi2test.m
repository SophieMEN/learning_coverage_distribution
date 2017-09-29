% This code is attached to paper 'Investigating the Distribution of Learning Coverage in MOOCs',
% submitted to Special Issue "Supporting Technologies and Enablers for Big Data"
% under journal Information

% Copyright (c) 2017 Chang Men
%-------------------------------------------------------------------------------------------------
% This code is a function conducting chi-square test and return the conclusion and p-value
% Parameters:
% ---- data: sample data
% ---- expt: expected values calculated from fitting curve
% ---- npara: number of parameters, here we only have one parameter alpha.
% ---- significance_level: signivicance level used to compared with p-value to draw conclusion
% Return:
% ---- h: conclusion of chi-square test. 0 means acceptance of null
% ----    hypothesis; 1 means rejection of null hypothesis.
% ---- pv: p-value
%-------------------------------------------------------------------------------------------------

function [h pv] = chi2test(data,expt,npara,significance_level) 
    m = sum(data>=5);
    l = length(data);
    if m < l
        data2 = zeros(m+1,1);
        expt2 = zeros(m+1,1);
        for i=1:m
            data2(i) = data(i);
            expt2(i) = expt(i);
        end
        data2(m+1) = sum(data(m+1:l));
        expt2(m+1) = sum(expt(m+1:l));
    else
        data2 = data;
        expt2 = expt;
    end
    df = m - npara;
    dist = data2 - expt2;
    chi2 = sum(dist.*dist./expt2);
    pv = 1 - chi2cdf(chi2,df);
    if pv > significance_level
        h = 0
    else
        h = 1
    end
