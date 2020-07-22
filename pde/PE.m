%解热方程

%% 网格法
%要求k必须满足k<=h^2/(2*c^2)
U1=forwardPE(1,1,0,0.125,20,400);
[X,Y]=meshgrid(0:0.0025:1,0:0.05:1);
fig1=figure;
%subplot(2,2,1)
mesh(X,Y,U1);
xlabel('T');
ylabel('X');
title('Forward Difference Method');

response= fig2plotly(fig1,'offline',true,'filename','Forward Difference Method');
%% 本源谱方法
k=30;
[X,Y]=meshgrid(0:0.0025:1,0:0.05:1);
U2=spectrm(1,1,401,21,k);

fig2=figure;

subplot(2,2,2)
mesh(X,Y,U2);
xlabel('T');
ylabel('X');
title('Spectral Method');

response2= fig2plotly(fig2,'offline',true,'filename','Origin Spectral Method');

 

%% F-K公式（MC算法）
[X,Y]=meshgrid(0:0.0025:1,0:0.05:1);
U3=tfkac(1,1,400,20,10,900,0,0.5);


fig3=figure;
subplot(2,2,4)
mesh(X,Y,U3);
title('Monte-Carlo Method(900 tracks)');
xlabel('T')
ylabel('X')

response3= fig2plotly(fig3,'offline',true,'filename','Monte-Carlo Method(1500 tracks)');


%% 镜像法

[X,Y]=meshgrid(0:0.0025:1,0:0.05:1);
U4=imagemthd(3,0,1,400,20,0,0.25);

fig4=figure;
subplot(2,2,3)
mesh(X,Y,U4);
title('Image Method');
xlabel('T')
ylabel('X')

response4=fig2plotly(fig4,'offline',true,'filename','Image Method');

 




