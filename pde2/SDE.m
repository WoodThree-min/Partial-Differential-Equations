clear;clc

%% Create OU Model
alpha=2; beta=0.04; sigma2=0.03^2;
N=501; % Observations
dT=0.01; T=0:dT:dT*(N-1);


    x=zeros(1,N);
    
    %for j=1:n
    for i=2:N
        xdw(i)=normrnd(0,sqrt(dT));
        x(i)=x(i-1)+dT*(alpha*(beta-x(i-1)))+sqrt(sigma2)*xdw(i);
    end
    % theta(j,:)=step4(x,dT);
    % end
    
    % figure;
    % plot(T,x,'.-');
    % title('Observed sample');
    %
    
    %%  M-H algorithm
    
    % Initiate theta0£¨Parameters)
    
    
    M=30;
    dt=dT/(M);
    t=0:dt:dt*(M*(N-1)-1);
    
    n=1000;
    theta=zeros(n,3);
    theta(1,:)=[5,0.1,0.03]; % Initialize theta*
    
    dt=dT/(M);
    
%     figure;
%     title('Example');
%     plot(T(1:2),x(1:2),'o');
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
        
%             %example
%             hold on
%         
%             plot(t(1:M+1),[xr_next,x(2)],'.-');
%         
%             %plot(t(1:5*M+1),xr(1:5*M+1),'.-');
%             legend('observed','unobserved');
%         
        % update Parameter
        
        theta(time,:) = step4(xr_next,dt);
        %theta2(time,:)=step4(xr_next2,dt);
        xr=xr_next;
        %xr2=xr_next2;
    end
   




%%

figure;
alpha=theta(:,1);
beta=theta(:,2);
sigma2=theta(:,3);
subplot(131)
plot(1:n,alpha,'.');
xlabel('alpha');
subplot(132)
plot(1:n,beta,'.');
xlabel('beta')
subplot(133)
plot(1:n,sigma2,'.');
xlabel('sigma2')

[theta(n,:)]


%%
figure;
bars=13;
subplot(131);
hist(theta_h(:,1),bars);xlabel('alpha');
subplot(132);
hist(theta_h(:,2),bars);xlabel('beta');
subplot(133);
hist(theta_h(:,3),bars);xlabel('sigma2');






