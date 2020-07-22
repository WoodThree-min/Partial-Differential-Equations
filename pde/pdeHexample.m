g='squareg';               % 定义单位方形区域
b='squareb1';              % 定义零边界条件
c=2;
a=0;
f=1;
d=1;

[p,e,t]=initmesh(g);      %网格化
%定义初始条件
u0=zeros(size(p,2),1);
ix=find(sqrt(p(1,:).^2+p(2,:).^2)<0.4);
u0(ix)=ones(size(ix));

%在时间段为0~1的点上求解
nframes=200;
tlist=linspace(0,0.1,nframes);
u1=parabolic(u0,tlist,b,p,e,t,c,a,f,d);


%网格插值
x=linspace(-1,1,31);
y=x;
[unused,tn,a2,a3]=tri2grid(p,t,u0,x,y);

newplot;
Mv = moviein(nframes);
umax=max(max(u1));
umin=min(min(u1));
for j=1:nframes,...
  u=tri2grid(p,t,u1(:,j),tn,a2,a3);
  i=find(isnan(u));
  u(i)=zeros(size(i));...
  surf(x,y,u);
  caxis([umin umax]);
  colormap(cool),...
  axis([-1 1 -1 1 0 1]);...
  Mv(:,j) = getframe;...
end
%演示动画
movie(Mv,10)

