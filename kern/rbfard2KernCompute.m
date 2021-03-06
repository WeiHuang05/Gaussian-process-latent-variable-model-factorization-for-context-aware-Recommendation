function [k, n2] = rbfard2KernCompute(model, i)

% RBFARD2KERNCOMPUTE Compute the RBFARD kernel given the parameters and X.
% FORMAT
% DESC computes the kernel parameters for the automatic relevance determination radial basis function
% kernel given inputs associated with rows and columns.
% ARG kern : the kernel structure for which the matrix is computed.
% ARG x : the input matrix associated with the rows of the kernel.
% ARG x2 : the input matrix associated with the columns of the kernel.
% RETURN k : the kernel matrix computed at the given points.
%
% FORMAT
% DESC computes the kernel matrix for the automatic relevance determination radial basis function
% kernel given a design matrix of inputs.
% ARG kern : the kernel structure for which the matrix is computed.
% ARG x : input data matrix in the form of a design matrix.
% RETURN k : the kernel matrix computed at the given points.
%
% SEEALSO : rbfard2KernParamInit, kernCompute, kernCreate, rbfard2KernDiagCompute
%
% COPYRIGHT : Neil D. Lawrence, 2004, 2005, 2006
%
% COPYRIGHT : Michalis K. Titsias, 2009

% KERN

if model.qinverse
    invQ = sqrt(model.kern.inverseWidth);
else
    invQ = sqrt(model.kern.inverseWidth(i));
    invQ = repmat(invQ,[1 model.q]);
end
scales = sparse(diag(invQ));
x = model.X_u;
x = x*scales;
    
n2 = dist2(x, x);
if model.onevariance
   k = model.kern.variance*exp(-n2*0.5);
else
   k = model.kern.variance(i)*exp(-n2*0.5);
end

