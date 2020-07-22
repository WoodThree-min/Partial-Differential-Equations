clear;clc;
%% Create a dataset £¨observed sample£º500£©
% OU Process 
alpha=0.20; beta=0.08; sigma=0.03;
n=500;
dt=1/12;%10^(-3);
X=zeros(1,n);X(1)=0;
for i=2:n
    X(i)=normrnd(X(i-1)+alpha*(beta-X(i-1))*dt, sigma*sqrt(dt));
end

t=0:dt:dt*(n-1);

%%
figure;plot(t,X);xlabel('t');ylabel('X');
title('Simulated Sample from OU Process')
ylim([0 0.18]);xlim([0 t(n)])


