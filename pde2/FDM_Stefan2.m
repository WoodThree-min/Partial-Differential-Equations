%%  --------------Stefan Problem-------------------------------------

% -------------- Finite Difference Method (moved Step)-----------------

% Ut=a^2*Uxx, 0<=x<=s(t)
% Ux(0,t)=-1
% U(x,0)=F(x)
% U(s(t),t)=0, s(0)=0
% Ux(s(t),t)=-ds(t)/dt
  % s(t)=t^2+0.05
%--------------------------------------------------------------------------
clear;
a=1;m=100;

dx=0.01;
x=0:dx:1; t=zeros(m,1);
t(1)=0.15;S0=t(1)^2+0.005; 
N=floor(S0/dx);
U=zeros(length(x),m);
% % Initial Conditions
U=[dx*ones(1,size(U,2));U];
   
for i=2:m
    dT=0.0001; 
    dT0=(t(i-1)^2 + dx)^(1/2) - t(i-1);
    %dT0=dx/2;
    while abs(dT)>10^(-5)
        dT0=dT0+dT;
        r=a*dT0/(dx)^2;

        % calculate
        L=diag([1,(1+r),(2*r+1)*ones(1,N-1),0]);
        D1=diag([-2*r,ones(1,N-1)*(-r),0],-1);
        D2=diag([0,0,-r*ones(1,N-1)],1);
        L=L+D1+D2;
        L=L(1:N+1,:);
        L(2,4)=-r;
        
        U(1:size(L,2),i)=pinv(L)*U(1:size(L,1),i-1);
        U(N+2,i)=U(N+1,i)*r/(2*r+1);
        
        dT1=(t(i-1)+dT0)^2-t(i-1)+sum(U(3:(N+2),i))*dx;
        %dT1=(t(i-1)+dT0)*2-t(i-1)+sum(U(3:(N+2),i))*dx;
        dT=dT1-dT0;   
    end
    U(find(U<0))=0;
    N=N+1;
    t(i)=t(i-1)+dT0;
    if t(i)<0
        error('Wrong Initial t');
        break;
    end
end
U=U(2:length(x),:);
%%

figure;
x=x(2:101); t(1)=0;
[X,T]=meshgrid(t,x);
mesh(X,T,U);
xlabel('T(Ê±¼ä)'); ylabel('X(¿Õ¼ä)');

