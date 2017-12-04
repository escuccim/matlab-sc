[p,e,t]=initmesh('naca');
pdemesh(p,e,t); axis equal;

u=parabolic(0,linspace(0,0.1,200),@nacabound,p,e,t,1,0,0,1);
pdeplot(p,e,t,'xydata',u(:,end),'colormap','jet'); axis equal;