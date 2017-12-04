syms X1 X2 X3
u = [X1*X2*X3; X1^2 + X2^2; sin(X3)];
%%INSERT YOUR CODE HERE: COMPUTE JACOBIAN dudX of u
dudX = jacobian(u); %3x3 matrix
%%INSERT YOUR CODE HERE: Generate Matlab, C and Fortran form of symbolic
%%expression
matlabFunction(dudX) %returns function handle
ccode(dudX) %returns C 2D array indexing stored rowwise
fortran(dudX) %returns Fortran 2D array indexing stored columnwise