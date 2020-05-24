function [C, sigma] = dataset3Params(X, y, Xval, yval)
%DATASET3PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = DATASET3PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C_vec = [0 0.001 0.003 0.01 0.03 0.1 0.3 1 3 10];
sigma_vec = [0 0.001 0.003 0.01 0.03 0.1 0.3 1 3 10];
error_val = zeros(length(C_vec), length(sigma_vec));
% model = zeros(length(C_vec), length(sigma_vec));

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%

for i = 1:length(C_vec)
  C = C_vec(i);
  for j = 1:length(sigma_vec)
    sigma = sigma_vec(j);
    model = svmTrain(X, y, C, @(x1, x2) gaussianKernel(x1, x2, sigma));
    predictions = svmPredict(model, Xval);
    error_val(i, j) = mean(double(predictions != yval));
  endfor
endfor

[min_row, min_rowIndexs] = min(error_val);
[min_val, min_colIndex] = min(min_row);
min_rowIndex = min_rowIndexs(min_colIndex);

C = C_vec(min_rowIndex);
sigma = sigma_vec(min_colIndex);

% =========================================================================

end