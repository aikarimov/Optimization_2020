function v = df(X)
% f is an optimized function
%Rosenbrosk function
x = X(1);
y = X(2);

v = X;
v(1) = -2*(1 - x) + 200*( y - x.^2).*( - 2*x);
v(2) = 200*(y - x.^2);
end