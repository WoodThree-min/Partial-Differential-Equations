%�����
x=linspace(0,1,50);
t=linspace(0,1,50);
%pde���
m=0;
sol=pdepe(m,@pdefun,@pdeic,@pdebc,x,t);
u=sol(:,:,1);

surf(x,t,u);
title('���޲�ַ���ֵ��ʾ��ͼ');
xlabel('x');
ylabel('t');

figure
plot(x,u(end,:));
title('��t=1���ʾ��ʾ��');
xlabel('x');
ylabel('u(x,1)');
