%%  --------------Moving Boundary-------------------------------------

% -------------- Spectral Method (Neumann Boundary)-----------------

% Ut=a^2*Uxx, 0<=x<=l(t)
% Ux(0,t)=0
% U(l(t),t)=0
% U(x,0)=F(x), 0<=x<=1
  % l(t)=c1*t+c2
  % F(x)=(x-1/2)^2-1/4
%--------------------------------------------------------------------------
clear;  
a=0.5;c1=0.9;c2=1;


n=20;
syms x t
F=(x-1/2)^2-1/4;
temp=int(1/(c1*t+c2)^2,t,0,inf);
temp=double(temp);
for k=1:n
    y=exp((a*(2*k-1)*pi)^2/4*temp+c1*x^2/(4*a^2*c2))*F*cos((2*k-1)*pi*x/(2*c2));  
    B(k)=2/sqrt(c2)*int(y,x,0,c2);
end
B=double(B);

x=0:0.005:2.8;
t=0:0.005:2;
for i=1:length(x)
    for j=1:length(t)
        BB=B.*cos((2*(1:n)-1)*pi*x(i)/(2*(c1*t(j)+c2))).*exp(-(a*pi.*(2*(1:n)-1)).^2/4*temp-0.5*log(c1*t(j)+c2)-c1*x(i)^2/(4*a^2*(c1*t(j)+c2)));
        BB(find(isnan(BB)==1))=0;
        u(i,j)=sum(BB);
    end
end

for i=1:length(t)
    indx=find(x>c1*t(i)+c2);
    u(indx,i)=0;
end
%%
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


