function [U,temp]=spectrm(boundaryT,boundaryX,m,n,k)
for i=1:k
   syms z
   %initialconditions=8*z*(1-z)*sin(i*pi*z); 
   y(i)=InitialConditions(z)*sin(i*pi*z);
   c(i)=int(y(i),z,0,1);
end
c=2*double(c);
temp=zeros(m,n);
U=zeros(n,m);
T=linspace(0,boundaryT,m);
X=linspace(0,boundaryX,n);
for j=1:k
    temp=c(j)*exp(-0.25*(j*pi)^2*T').*sin(j*pi*X);
    temp=temp';
    U=U+temp;
end

end




