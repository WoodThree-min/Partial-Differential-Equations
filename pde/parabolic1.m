%网格点
x=linspace(0,1,50);
t=linspace(0,1,50);
%pde求解
m=0;
sol=pdepe(m,@pdefun,@pdeic,@pdebc,x,t);
u=sol(:,:,1);

surf(x,t,u);
title('有限差分法数值解示意图');
xlabel('x');
ylabel('t');

figure
plot(x,u(end,:));
title('在t=1点表示显示解');
xlabel('x');
ylabel('u(x,1)');
