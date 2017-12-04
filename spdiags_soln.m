% spdiags_soln
n = 1000;

Ad = diag(-2*ones(n,1),0) + diag(ones(n-1,1),-1) + ...
     diag(ones(n-1,1),1);
s1 = whos('Ad');
s1.bytes

As = spdiags([ones(n,1),-2*ones(n,1),ones(n,1)],-1:1,n,n);
s2 = whos('As');
s2.bytes

s1.bytes/s2.bytes

isequal(As, sparse(Ad))