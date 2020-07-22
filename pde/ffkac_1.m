function fm=ffkac_1(x0,N,number,m)
fm=zeros(m,1);
for j=1:m
    dZ=zeros(number,j*N);
    Z=zeros(number,j*N);
    f=zeros(number,j*N);
    for i=1:number
        dZ(i,:)=(2.*(rand(1,j*N)<0.5)-1)*1/(j*N);
        %normrnd(0,sqrt(deltat/N),1,j*N);
        Z(i,:)=x0+cumsum(dZ(i,:));
        for k=1:(j*N)
            if Z(i,k)< 0
                f(i,:)=0;
                break;
            elseif Z(i,k)>1                                  
                f(i,:)=0;
                break;
            else
                %f(i,k)=8*Z(i,k)*(1-Z(i,k));
                f(i,k)=InitialConditions(Z(i,k));
            end
        end
        
    end
fm(j)=mean(f(:,j*N));
end
end

