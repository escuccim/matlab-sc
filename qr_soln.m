%% QR (regression)
load('regression_data.mat');
xfine = linspace(min(x),max(x),1000);
order = 5;

V = vander(x);
V = V(:,end-order:end);
%a = V \ y;
[Q,R] = qr(V,0);
a = R \ (Q'*y);

figure;
plot(x,y,'ro'); hold on;
plot(xfine,polyval(a,xfine),'k-','linew',2);
legend('Data','Polynomial');
