%%  M-H algorithm

% Initiate theta0£¨Parameters)
Mn=30:2:100;
for j=29:length(Mn)
    M=Mn(j);
    dt=dT/(M);
    t=0:dt:dt*(M*(N-1)-1);
    
    n=1000;
    theta=zeros(n,3);
    theta(1,:)=[5,0.1,0.03]; % Initialize theta*
    
    dt=dT/(M);
    
    % figure;
    % title('Example');
    % plot(T(1:2),x(1:2),'o');
    %

    % Initialize Y*
    for i=2:N
        xr(1+M*(i-2):M*(i-1))=step1_i(x(i-1),x(i),M,theta(1,:),dt);
        
    end
    %xr1=xr;xr2=xr;
    for time=2:n
        k=1;
        % update unobserved samples
        
        for i=2:N
            xr_next(1+M*(i-2):M*(i-1))=step21(theta(time-1,:),[xr(1+M*(i-2):M*(i-1)),x(i)],M,dt);
            %xr_next2(1+M*(i-2):M*(i-1))=step2(theta(time-1,:),[xr2(1+M*(i-2):M*(i-1)),x(i)],M,dt,k);
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
        %theta2(time,:)=step4(xr_next2,dt);
        xr=xr_next;
        %xr2=xr_next2;
    end
    theta_h(j,:)=theta(n,:);
end


%%

figure;
alpha=theta_h(:,1);
beta=theta_h(:,2);
sigma2=theta_h(:,3);
subplot(131)
plot(alpha,'.');
subplot(132)
plot(beta,'.');
subplot(133)
plot(sigma2,'.');

[theta(n,:)]
