function U=fdmPE1(boundaryX,boundaryT,mu,Sig,f,n,m)
h=boundaryX/n;
k=boundaryT/m;
r=Sig*k/h^2;

U=zeros(n+1,m+1);
%Initial Conditions
for i=1:n+1
    U(i,1)=InitialConditions1((i-1)*h);
end


for j=1:m
    for i=2:n
        if length(f)==1
            U(i,j+1)=r*(U(i-1,j)+U(i+1,j))+(1-2*r)*U(i,j);
        else
            f(i,j)=2*exp(-j*k)*sin(pi/4+pi/2*i*h);
            U(i,j+1)=mu*k/h*(U(i,j)-U(i-1,j))+r*(U(i-1,j)+U(i+1,j)-2*U(i,j))+U(i,j)+k*f(i,j);        
        end
    end
    if length(f)==1
        U(1,j+1)=2*r*U(2,j)+(1-2*r)*U(1,j);
        U(n+1,j+1)=2*r*U(n,j)+(1-2*r)*U(n,j);
    else
        f(1,j)=2*exp(-j*k)*sin(pi/4);
        f(n,j)=2*exp(-j*k)*sin(pi/4+pi/2*n*h);
        U(1,j+1)=2*r*U(2,j)+(1-2*r)*U(1,j)+k*f(1,j);
        U(n+1,j+1)=2*r*U(n,j)+(1-2*r)*U(n,j)+k*f(n,j);
    end
end

end