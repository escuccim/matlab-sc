load matrix_lu.mat
A = sparse(linsys.row,linsys.col,linsys.val);
b = linsys.b;
clear linsys;

%% LU
[L,U] = lu(A);
figure;
subplot(1,3,1); spy(A); title('A');
subplot(1,3,2); spy(L); title('L');
subplot(1,3,3); spy(U); title('U');
norm(A - L*U,'fro')

[L,U,p] = lu(A,'vector');
figure;
subplot(1,3,1); spy(A(p,:)); title('A(p,:)');
subplot(1,3,2); spy(L); title('L');
subplot(1,3,3); spy(U); title('U');
norm(A(p,:) - L*U,'fro')

[L,U,p,q] = lu(A,'vector');
figure;
subplot(1,3,1); spy(A(p,q)); title('A(p,q)');
subplot(1,3,2); spy(L); title('L');
subplot(1,3,3); spy(U); title('U');
norm(A(p,q) - L*U,'fro')