% NEED SYMBOLIC TOOLBOX - RUN WITH 2012b version!!
syms rho lam mu u X1 X2 X3

X = [X1;X2;X3];
u = [X1*X2*X3;X1^2+X2^2;sin(X3)];

dudX = jacobian(u,X);
F = eye(3) + dudX;
E = 0.5*(F.'*F - eye(3));
S = lam*trace(E)*eye(3) + 2*mu*E;
P = S*F.';

b = (-1/rho)*[divergence(P(:,1),X);divergence(P(:,2),X);...
              divergence(P(:,3),X)];

matlabFunction(b)
fortran(b)
ccode(b)
latex(b)