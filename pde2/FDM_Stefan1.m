%%  --------------Stefan Problem-------------------------------------

% -------------- Finite Difference Method (Fixed Step)-----------------

% Ut=a^2*Uxx, 0<=x<=s(t)
% Ux(0,t)=-1
% U(x,0)=F(x)
% U(s(t),t)=0, s(0)=0
% Ux(s(t),t)=-ds(t)/dt
  % s(t)=?
   %F(x)=(x-1/2)^2-1/4
%--------------------------------------------------------------------------
clear;
a=1;

dx=0.001;dt=0.005;
r=dt/(dx)^2;
t=0:dt:2;
x=0:dx:1;

U=zeros(length(x),30);
% % Initial Conditions
% U(:,1)=(x-0.5).^2-1/4;
U=[dx*ones(1,size(U,2));U];


for i=2:length(t)
    dS=0.0001; S0=t(i)*2;
    while abs(dS)>10^(-5)
        S0=S0+dS;
        N=floor(S0/dx);
        % calculate
        c1=-2*dt/(dx*(S0*2+dt-(N-1)*dx));
        c2=1+2*dt/(dx*(S0*2+dt-N*dx));
        L=diag([1,(1+r),(2*r+1)*ones(1,N-2),c2]);
        D1=diag([-2*r,ones(1,N-2)*(-r),c1],-1);
        D2=diag([0,0,-r*ones(1,N-2)],1);
        L=L+D1+D2;
        L(2,4)=-r;
        
        U(1:size(L,2),i)=L^(-1)*U(1:size(L,1),i-1);
        
        S1=t(i+1)-sum(U(3:(N-1),i))*dx-0.5*(S0*2-(N-1)*dx)*U(N,i);
        dS=S1-S0;
    end
   S(i)=S0; 
    % L2=diag((2*r+1)*ones(1,length(U(:,i-1))-N-2))...
    %     +diag(-r*ones(1,length(U(:,i-1))-3-N),-1)...
    %     +diag(-r*ones(1,length(U(:,i-1))-3-N),1);
    % l=L2(2:size(L2,1)-1,:);
    % U(N+3:length(U(:,i-1)),i)=pinv(l)*U(N+4:length(U(:,i-1))-1,i-1);
end

for i=1:30
   u(:,i)=U(:,31-i);
end

u=flip(u,1);
%%
figure;

[X,T]=meshgrid(t(1:19),x(2:1001));
% mesh(X,T,u(3:102,1:30));
% ylabel('T(时间)'); xlabel('X(空间)');
% xlim([0 1]);
% hold on
mesh(X,T,U(2:1001,1:19));
 xlabel('T(时间)');ylabel('X(空间)');
% xlim([0 1]);

% hold on;
% s=0.9*t+1;
% plot(t,s,'r','Linewidth',2)

