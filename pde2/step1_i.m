
% Initialize Y*,theta0
function xr=step1_i(x1,x2,M,theta0,dt)
xr=zeros(1,M);
xr(1)=x1; xr(M+1)=x2;

i=2;
while (i<=M)
    mu0 = (x2+(M+1-i)*xr(i-1))/(M+2-i);
    sigma0 = theta0(3)*(M+1-i)*dt/(M+2-i);
    xr(i) = normrnd(mu0,sqrt(sigma0));
    i=i+1;
end
xr=xr(1:M);
end