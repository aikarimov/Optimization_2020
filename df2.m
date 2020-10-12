function v = df2(X)
% f is an optimized function
x = X(1);
y = X(2);

v = X;
eps = 1e-16;
v(1) = f2(X + eps*[1; 0]) - f2(X - eps*[1; 0])/2/eps;
v(2) = f2(X + eps*[0; 1]) - f2(X - eps*[0; 1])/2/eps;
end