%% Finite Difference Method
% subdivision (X,T)->(n,m*500)
m=10;
x=zeros(1,n);
x(1)=min(X);x(n)=max(X)+range(X);
dX=(x(n)-x(1))/(n-1);
dT=dt/m;
r=dT/(dX^2);

x=linspace(x(1),x(n),n);
T=linspace(t(1),t(n),n*m);
%% A_l and A_r

% Initial parameters
  % alpha=;beta=;sigma=?

mun=alpha*(beta-x); gn=0.03;


        P=gn^2*(3*mun(n)*dX-2*gn^2)-mun(n)*dX*(3*gn^2-4*mun(n)*dX);
        Q=gn^2*(4*mun(n)*dX-2*gn^2);
        R=4/r*(3*gn^2-4*mun(n)*dX);
   
        P1=gn^2*(3*mun(1)*dX-2*gn^2)+mun(3)*dX*(3*gn^2-4*mun(1)*dX);
        Q1=gn^2*(4*mun(1)*dX-2*gn^2);
        R1=4/r*(3*gn^2-4*mun(1)*dX);
    
        A1=-r*(gn^2-dX*mun(3:n));
        A2=-A1;
        B1=2*(2+r*gn^2);
        B2=2*(2-r*gn^2);
        C1=-r*(gn^2+dX*mun(1:n-2));
        C2=-C1;
 

A_l=diag([0,B1*ones(1,n-2),0])+diag([-(Q1-R1),A1],1)+diag([C1,-(Q-R)],-1);
A_l(1,3)=P1;A_l(n,n-2)=P;
A_r=diag([0,B2*ones(1,n-2),0])+diag([-(Q1+R1),A2],1)+diag([C2,-(Q+R)],-1);
A_r(1,3)=-P1;A_r(n,n-2)=-P;

%% Initial condition

for k=1:200
    f(:,1+(k-1)*m)=1/(sigma*sqrt(2*pi*dT))*exp(-1/(2*dT*sigma^2)*(x-X(k)-mun(k)*dT).^2);

    for i=2:m
        f(:,i+(k-1)*m)=A_l^(-1)*A_r*f(:,i-1+(k-1)*m);
    end 
end
        f(find(f<=(10)^(-6)))=10^(-6);
        f(find(f>150))=150;

%%
for k=201:300
    f(:,1+(k-1)*m)=1/(sigma*sqrt(2*pi*dT))*exp(-1/(2*dT*sigma^2)*(x-X(k)-mun(k)*dT).^2);

    for i=2:m
        f(:,i+(k-1)*m)=A_l^(-1)*A_r*f(:,i-1+(k-1)*m);
    end 
end
        f(find(f<=(10)^(-6)))=10^(-6);
        f(find(f>150))=150;

%%
for k=301:500
    f(:,1+(k-1)*m)=1/(sigma*sqrt(2*pi*dT))*exp(-1/(2*dT*sigma^2)*(x-X(k)-mun(k)*dT).^2);

    for i=2:m
        f(:,i+(k-1)*m)=A_l^(-1)*A_r*f(:,i-1+(k-1)*m);
    end 
end


        f(find(f<=(10)^(-6)))=10^(-6);
        f(find(f>150))=150;
        
        %%
        
figure;
[A,B]=meshgrid(T,x);
mesh(A,B,f);
%contour(A,B,f);
xlabel('T');ylabel('X');
ylim([0 0.18]);xlim([0 t(n)])

%%
logf=log(f);
mesh(logf(:,1:50));

Nl=sum(logf(find(abs(logf-log(10^(-6)))>10^(-6))));


