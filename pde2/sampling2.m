%% Random Block Size M-H algorithm

% Initiate theta0£¨Parameters)
Mm=10:5:101;
for j=1:1%length(Mm)
    M=Mm(j);
    dt=dT/(M);
    t=0:dt:dt*(M*(N-1)-1);
    
    n=1000;
    theta=zeros(n,3);
    theta(1,:)=[5,0.1,0.03]; % Initialize theta*
    
    dt=dT/(M);
    
    
    
    % Initialize Y*
    for i=2:N
        xr(1+M*(i-2):M*(i-1))=step1_i(x(i-1),x(i),M,theta(1,:),dt);
        
    end
    for time=2:n
        k=1;
        % update unobserved samples
        
        for i=2:N
            xr_next(1+M*(i-2):M*(i-1))=step2(theta(time-1,:),[xr(1+M*(i-2):M*(i-1)),x(i)],M,dt,k);
        end
        
        %     %example
        %     hold on
        %
        %     plot(t(1:M+1),[xr_next2,x(2)],'.-');
        %
        %     %plot(t(1:5*M+1),xr(1:5*M+1),'.-');
        %     legend('observed','unobserved');
        
        % update Parameter
        
        theta(time,:) = step4(xr_next,dt);
        xr=xr_next;
    end
    %theta_h(j,:)=theta(n,:);
end



%%

figure;
alpha=theta(:,1);
beta=theta(:,2);
sigma2=theta(:,3);
subplot(131)
plot(1:n,alpha,'.');
subplot(132)
plot(1:n,beta,'.');
subplot(133)
plot(1:n,sigma2,'.');

[theta(n,:)]
