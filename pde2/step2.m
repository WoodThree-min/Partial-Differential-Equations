 %% update unobserved samples

function xr_next=step2(theta0,xr,M,dt,k)

% figure;
% plot(1:M+1,xr(1:M+1),'.-');
% hold on;
% update Block size sample (unobserved)
 
xr_p = zeros(1,10);
xr_p=[xr_p,xr(M+1)];
while k<M
    m=poissrnd(3)+1;
    k=k+m;
    
    if k>M
        k=M;
    end
    
    if m>M-1
        break;
    end
    
    % Produce Block samples
    
    xr_p(k-m)=xr(k-m);
    for i=k-m+1:k
        mu0 = (xr_p(M+1)+(M-i+1)*xr_p(i-1))/(M+2-i);
        sigma0 = theta0(3)*(M-i+1)*dt/(M+2-i);
        xr_p(i) = normrnd(mu0,sqrt(sigma0));
    end
    
    % Accept-reject strategy
    f1 = 1; f2 = 1; q1 = 1; q2 = 1;
    for i=k-m+1:k
        mu1 = (xr_p(i-1)+theta0(1)*(theta0(2)-xr_p(i-1))*dt);
        sigma1 = sqrt(dt*theta0(3));
        f1 = f1*normcdf(xr_p(i),mu1,sigma1);
        f2 = f2*normcdf(xr(i),xr(i-1)+theta0(1)*(theta0(2)-xr(i-1))*dt,...
            sqrt(dt*theta0(3)));
        q1 = q1*normpdf(xr_p(i),(xr_p(M+1)+(M-i+1)*xr_p(i-1))/(M+2-i),...
            sqrt(theta0(3)*(M-i+1)*dt/(M+2-i)));
        q2 = q2*normpdf(xr(i),(xr(M+1)+(M-i+1)*xr(i-1))/(M+2-i),...
            sqrt(theta0(3)*(M-i+1)*dt/(M+2-i)));
    end
    
    u = rand(1);
    a = f1*q2/(f2*q1);
    if (f2*q1)>0
        P = min(1,a);
    else
        P=1;
    end
    
    if (u < P)
        xr(k-m+1:k) = xr_p(k-m+1:k);
    
    else
        xr(k-m+1:k) = xr(k-m+1:k);
    end
%     hold on;
%     plot(k:k+m+1,xr(k:k+m+1));
end
xr_next=xr(1:M);
% update theta ---> step 4

end
