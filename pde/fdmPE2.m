function U=fdmPE2(boundaryT,Sig,lambda,n,m)

k=boundaryT/m;
T=0:k:1;
for i=1:length(T)
    boundaryX=T(i);
    h=boundaryX/n;
    r=Sig*k/(h^2);

U=zeros(n+1,m+1);

for i=1:n+1
    U(i,1)=InitialConditions1((i-1)*h);
end


for j=1:m
    for i=2:n
        U(i,j+1)=r*(U(i-1,j)+U(i+1,j))+(1-2*r)*U(i,j)+k*lambda*U(i,j);    
    end
    U(1,j+1)=2*r*U(2,j)+(1-2*r)*U(1,j)+k*lambda*U(1,j);
    U(n+1,j+1)=2*r*U(n,j)+(1-2*r)*U(n,j)+k*lambda*U(n,j)+2*r*beta*();
end
end