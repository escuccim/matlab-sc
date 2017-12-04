load matrix_lu.mat
A = sparse(linsys.row,linsys.col,linsys.val);
b = linsys.b;
clear linsys;

%% Cholesky
p = amd(A);

R    = chol(A);
Ramd = chol(A(p,p));
%add alpha*diag(A) to make diagonally dominant matrix so incomplete
%Cholesky is defined
alpha = max(sum(abs(A),2)./diag(A))-2;
Rinc = ichol(A, struct('type','ict','droptol',1e-2,'diagcomp',alpha, 'shape', 'upper'));

figure;
subplot(2,2,1); spy(A); title('A');
subplot(2,2,2); spy(R); title('R');
subplot(2,2,3); spy(Ramd); title('R (amd)');
subplot(2,2,4); spy(Rinc); title('R (inc)');