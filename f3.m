function v = f3(X)
% f is an optimized function
%Himmelblau function
x = X(1);
y = X(2);
v = (x.^2 + y  - 11).^2 + (x + y.^2 - 7).^2;
end