load matrix_lu.mat
A = sparse(linsys.row,linsys.col,linsys.val);
b = linsys.b;
clear linsys;

%% CG, MINRES, GMRES
Rinc = cholinc(A,1e-3);

% Get exact solution using backslash
x = A \ b;
chol(A);

% Use PCG to solve Ax = b (precondition with Rinc)
[x_pcg,flag_pcg,relres_pcg,iter_pcg,resvec_pcg] = pcg(A,b,1e-6,1000,@(x) Rinc\(Rinc'\x));
% Use MINRES to solve Ax = b (precondition with Rinc)
[x_mnr,flag_mnr,relres_mnr,iter_mnr,resvec_mnr] = minres(A,b,1e-6,1000,@(x) Rinc\(Rinc'\x));
% Use GMRES to solve Ax = b (precondition with Rinc)
[x_gmr,flag_gmr,relres_gmr,iter_gmr,resvec_gmr] = gmres(A,b,[],1e-9,1000,@(x) Rinc\(Rinc'\x));

fprintf('Error, iter PCG    = %e, %d\n',norm(x - x_pcg),iter_pcg);
fprintf('Error, iter MINRES = %e, %d\n',norm(x - x_mnr),iter_mnr);
fprintf('Error, iter GMRES  = %e, %d\n',norm(x - x_gmr),prod(iter_gmr));

plot(resvec_pcg,'b--','linew',2); hold on;
plot(resvec_mnr,'k:','linew',2);
plot(resvec_gmr,'r-.','linew',2); grid on;
legend('PCG','MINRES','GMRES');
set(gca,'yscale','log');