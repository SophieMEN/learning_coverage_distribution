% This code is attached to paper 'Investigating the Distribution of Learning Coverage in MOOCs',
% submitted to Special Issue "Supporting Technologies and Enablers for Big Data"
% under journal Information

% Copyright (c) 2017 Chang Men
%--------------------------------------------------------------------------------
% This code conducts fitting and test procedure on all data under in the data folder
% ln_likelihood.m and chi2test.m are needed in current directory
% Results will be output to folder result as zipf_result.csv
%--------------------------------------------------------------------------------

significance_level = 0.01;
init_alpha = 1.0
path = pwd;
files = dir( fullfile( path, 'data' ,'*.txt') );

n_file = length(files);
c_list = zeros(n_file, 1);
alpha_list = zeros(n_file, 1);
num_list = zeros(n_file, 1);
len_list = zeros(n_file, 1);
h_list = zeros(n_file, 1);
pv_list = zeros(n_file, 1);
course_list = cell(n_file, 1);
for j = 1:n_file
    filename = files(j).name
    input_file = fullfile(path, 'data', filename);
    data = load(input_file);
    len_list(j) = length(data);
    n = sum(data);
    num_list(j) = n;
    course_list{j} = filename( 1:length(filename)-8 );
    options = optimset('GradObj', 'on', 'MaxIter', 400);
    [alpha_hat,lnlikeli] = fminunc(@(alpha)(ln_likelihood(alpha,data)), init_alpha, options);
    expt = zeros(length(data),1);
    for i = 1:length(data)
        expt(i) = 1 / (i^alpha_hat);
    end
    c = 1 / sum(expt);
    expt = n * expt * c;
    [h,pv] = chi2test(data, expt, length(alpha_hat), significance_level);
    c_list(j) = c;
    alpha_list(j) = alpha_hat;
    h_list(j) = h;
    pv_list(j) = pv; 
end;
names = {'course';'num';'len';'c';'alpha';'h';'pv'};
result = table(course_list, num_list, len_list, c_list ,alpha_list, h_list, pv_list, 'VariableNames', names);
output_file = fullfile(path, 'result', 'zipf_result.csv');
writetable(result,output_file,'WriteVariableNames' ,true);