bX=1;
bT=0.4;
m=160;
n=20;

%stage 1
Sig1=0.5*0.25;
lambda1=-1;
u1=fdmPE2(bX,bT,Sig1,lambda1,n,m);

%stage 2
%beta=0.5;
Sig2=0.5*0.09;
lambda2=-0.5;
u2=fdmPE3(u1,bX,bT,Sig2,lambda2,n,m);
U=horzcat(u1,u2(:,2:m+1));

%stage 3
Sig3=0.5*0.16;
lambda3=1;
u3=fdmPE4(u2,bX,bT,Sig3,lambda3,n,m);
U=horzcat(U,u3(:,2:m+1));

u33=fdmPE4(u3,bX,bT,Sig3,lambda3,n,m);
U=horzcat(U,u33(:,2:m+1));

% figure
fig=figure;

[X,Y]=meshgrid(0:0.0025:1.6,0:0.05:1);
s=surf(X,Y,U);
s.EdgeColor='none';
xlabel('T');
ylabel('X');
title('iron1');
%response= fig2plotly(fig,'offline',true,'filename','iron1');



