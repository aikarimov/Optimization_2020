function [xmin, fmin, neval, coordinates] = lbfgssearch(f,df,x0,tol)
% LBFGSSEARCH searches for minimum using L-BFGS method
% 	[xmin, fmin, neval,coordinates] = LBFGSSEARCH(f,df,x0,tol)
%   INPUT ARGUMENTS
% 	f is a function handle
% 	df is a gradient function handle
%   x0 - starting point
% 	tol - tolerance for both range and function value
%   OUTPUT ARGUMENTS
% 	xmin is a function minimizer
% 	fmin = f(xmin)
% 	neval - number of function evaluations
%   coordinates - array of the coordinates for each step
k = 1;
Kmax = 1900;
dim = length(x0); %problem dimension
M = 1; %max number of stored elements
m = 0; %actual stored length
%values for Armijo search:
s = 1;
c1 = 1e-4;
interval = 1*[-1;1];
coordinates = zeros(2,Kmax);
coordinates(:,1) = x0;

q0 = df(x0);
z0 = - q0; %initial direction
p0 = tol; %step difference, tol for passing stop criterion

%data for the method
Ps = zeros(dim,M);
Ys = zeros(dim,M);
gams = zeros(1,M);

%auxuliary vectors
alfs = zeros(1,M);
while ( norm(p0) >= tol || norm(q0) >= tol) && (k < Kmax)
    %recompute for k = k + 1
    f1dim = @(al)(f(x0 + al*z0));
    [al,~,~] = goldensectionsearch(f1dim,interval,tol);
    
    %df1dim = @(al)(z0'*df(x0 + al*z0));
    %[al,~,~] = armijosearch(f1dim,df1dim,s,c1);
    
    
    p0 = al*z0;
    x1 = x0 + p0; %quasi-Newton coordinate update
    q1 = df(x1); %new derivative
    %update the coordinates
    coordinates(:,k+1) = x1;
    
    %update stored memory
    if m < M
        m = m + 1;
    end
    %shift store arrays right
    Ps = circshift(Ps,1,2);
    Ys = circshift(Ys,1,2);
    gams = circshift(gams,1,2);
    
    %record current values
    Ps(:,1) = p0;
    y0 = q1 - q0;
    Ys(:,1) = y0;
    gams(1) = 1/(y0'*p0);
    
    %recurrect calculations
    q = q1;
    delta = p0'*y0/(y0'*y0);
    for i = 1:m %go backwards in time
        alfs(i) = gams(i)*Ps(:,i)'*q;
        q = q - alfs(i)*Ys(i);
    end
    z = delta*q;
    for i = m:-1:1 %go forwards in time
        bet = gams(i)*Ys(:,i)'*z;
        z = z + (alfs(i) - bet)*Ps(:,i);
    end
    %update step approximation
    z0 = -z;

    %ordinary BFGS
%      H0 = (eye(dim) - gams(1)*p0*y0')*H0*(eye(dim) - gams(1)*y0*p0') - gams(1)*(p0*p0');
%      z0 = -H0*q1;
    %shift vectors back
    x0 = x1;
    q0 = q1;
    
    k = k + 1;
    
end

xmin = x1;
fmin = feval(f,xmin);
neval = k;
end