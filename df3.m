function v = df3(X)
% f is an optimized function
%Himmelblau function
%  v = (x.^2 + y  - 11).^2 + (x + y.^2 - 7).^2;
x = X(1);
y = X(2);

v = X;
v(1) = 2*(x.^2 + y  - 11).*(2*x) + 2*(x + y.^2 - 7);
v(2) = 2*(x.^2 + y  - 11) + 2*(x + y.^2 - 7).*(2*y);
end