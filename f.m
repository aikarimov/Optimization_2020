function v = f(X)
% f is an optimized function
%Rosenbrosk function
x = X(1);
y = X(2);
v = (1 - x).^2 + 100*( y - x.^2).^2;
end