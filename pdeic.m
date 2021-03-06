%% Code Initial Conditions
% The initial condition is applied at the first time value and provides the value of u(x,t0) for any value of x.
% The number of initial conditions must equal the number of equations, so for this problem there are 11 initial conditions.
% vector icMesh contains the sample points within the depth interval, and matrix icData contains the corresponding values, 
% each row indicating each component. x is the query points.
% interp1 is used to return interpolated values for multiple sets of data. Use matrix icData' as one input, columns are vectors for components.
% method 'pchip': shape-preserving piecewise cubic interpolation.

%% write a function that returns the initial condition
function u0 = pdeic(x,msInfo) 
u0 = interp1(msInfo.icMesh,msInfo.icData',x,'pchip')';

