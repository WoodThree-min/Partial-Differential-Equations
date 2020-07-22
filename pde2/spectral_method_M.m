%%  --------------Moving Boundary-------------------------------------

% -------------- Fourier Method (Dirichlet Boundary)-----------------

% Ut=a^2*Uxx, 0<=x<=l(t)
% U(0,t)=0
% U(l(t),t)=0
% U(x,0)=F(x), 0<=x<=1
  % l(t)=c1*t+c2
  % F(x)=(x-1/2)^2-1/4
%--------------------------------------------------------------------------
clear;  
a=0.5;c1=0.9;c2=1;

n=30;
syms x
F=(x-1/2)^2-1/4;
for k=1:n
    y=exp(c1*x^2/(4*a*a*c2))*F*sin(k*pi*x/c2);  
    A(k)=2/sqrt(c2)*exp(-(a*pi*k)^2/(c1*c2))*int(y,x,0,c1);
end
A=double(A);


x=0:0.005:2.8;
t=0:0.005:2;
for i=1:length(x)
    for j=1:length(t)
        AA=A.*sin((1:n)*pi*x(i)/(0.5*t(j)+1)).*exp((a*pi.*(1:n)).^2/(c1*(c1*t(j)+c2)));
        AA(find(isnan(AA)==1))=0;
        u(i,j)=exp(-c1*x(i)^2/(4*a^2*(c1*t(j)+c2)))/(c1*t(j)+c2)^(1/2)*sum(AA);
    end
end
for i=1:length(t)
    indx=find(x>c1*t(i)+c2);
    u(indx,i)=0;
end


figure;
subplot(121)
[X,T]=meshgrid(t,x);
mesh(X,T,u);
xlabel('T(时间)'); ylabel('X(空间)');
subplot(122)
contour(X,T,u,800);
xlabel('T(时间)');ylabel('X(空间)');
hold on;
s=0.9*t+1;
plot(t,s,'r','Linewidth',2)
        