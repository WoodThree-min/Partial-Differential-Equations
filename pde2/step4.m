%% update Parameter

function theta = step4(xr,dt)

l = length(xr);

c1=0.5*dt*sum(xr(1:l-1).^2);
c2=0.5*dt*sum(xr(1:l-1));
c3=0.5*dt*(l-1);
c4=0.5*1/dt*sum((xr(2:l)-xr(1:l-1)).^2);
c5=0.5*sum(xr(1:l-1).*(xr(2:l)-xr(1:l-1)));
c6=0.5*sum((xr(2:l)-xr(1:l-1)));

theta(1)=(c2*c6-c3*c5)/(c1*c3-c2^2);
theta(2)=1/theta(1)*(c1*c6-c2*c5)/(c1*c3-c2^2);


theta(3)=1/(l*dt)*sum((xr(2:l)-xr(1:l-1)-theta(1)*(theta(2)-xr(1:l-1))*dt).^2);
end



