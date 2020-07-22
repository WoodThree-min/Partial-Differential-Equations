 %% update unobserved samples

function xr=step21(theta0,xr,M,dt)

    xr_p=zeros(1,M+1);
    xr_p(1) = xr(1); xr_p(M+1) = xr(M+1);

% update sample (unobserved)
 
    % Produce Block samples
    for i=2:M
        mu0 = (xr_p(M+1)+(M+1-i)*xr_p(i-1))/(M+2-i);
        sigma0 = theta0(3)*(M+1-i)*dt/(M+2-i);
        xr_p(i) = normrnd(mu0,sqrt(sigma0));
    end
    
    % Accept-reject strategy
    f1 = 1; f2 = 1; q1 = 1; q2 = 1;
    for i=2:M
        mu1 = (xr_p(i-1)+theta0(1)*(theta0(2)-xr_p(i-1))*dt);
        sigma1 = sqrt(dt*theta0(3));
        f1 = f1*normpdf(xr_p(i),mu1,sigma1);
        f2 = f2*normpdf(xr(i),xr(i-1)+theta0(1)*(theta0(2)-xr(i-1))*dt,...
            sqrt(dt*theta0(3)));
        q1 = q1*normpdf(xr_p(i),(xr_p(M+1)+(M+1-i)*xr_p(i-1))/(M+2-i),...
            sqrt(theta0(3)*(M+1-i)*dt/(M+2-i)));
        q2 = q2*normpdf(xr(i),(xr(M+1)+(M+1-i)*xr(i-1))/(M+2-i),...
            sqrt(theta0(3)*(M+1-i)*dt/(M+2-i)));
    end
    
    u = rand(1);
    a = f1*q2/(f2*q1);
    if (f2*q1)>0
        P = min(1,a);
    else
        P=1;
    end
    if (u < P)
        xr = xr_p;
        xr=xr(1:M);
    else
        xr=xr(1:M);
    end
     xr = xr_p(1:M);
end
%update theta ---> step 4


