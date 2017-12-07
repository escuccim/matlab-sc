eps = [1, 1e-1, 1e-2, 1e-3, 1e-4];
f = @(t,y) y^2*(1-y);

%% ODE solvers


for i = 1:length(eps)
    [t45, y45] = ode45(f, [0,2/eps(i)],eps(i));
    [t23, y23] = ode23s(f, [0,2/eps(i)],eps(i));
    fprintf('ODE45 Timesteps for eps = %f: %d\n', eps(i),length(t45))
    fprintf('ODE23s Timesteps for eps = %f: %d\n', eps(i),length(t23))
end