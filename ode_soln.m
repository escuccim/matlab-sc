%% ODE solvers
eps = [1, 1e-1 1e-2 1e-3 1e-4];
%eps = 1e-4;
f = @(t,y) y^2*(1-y);
for i = 1:length(eps)
    [t45,y45]  = ode45(f,[0,2/eps(i)],eps(i));
    [t23s,y23s] = ode23s(f,[0,2/eps(i)],eps(i));
    fprintf('ODE45 Timesteps for eps = %f: %d\n', eps(i),length(t45))
    fprintf('ODE23s Timesteps for eps = %f: %d\n', eps(i),length(t23s))
    if (eps(i) == 1e-1)
        plot(t45,y45,'b-', t23s, y23s, 'r--');
        legend('ODE45', 'ODE23')
    end
end