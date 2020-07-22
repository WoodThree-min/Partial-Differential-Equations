function u=im1(number,Boundary_a,Boundary_b,m,n,mu,sig)


%syms t x y

F=@(x,y,t) propagB1(t,x,y,number,mu,sig).*(2*cos(pi*y));
%A=integral(F,Boundary_a,Boundary_b);

u=zeros(m+1,n+1);
for k=1:(n+1)
    intx=(Boundary_b-Boundary_a)/n;
    temp=intx*(k-1);
    u(1,k)=InitialConditions1(temp);
end

for i=2:m+1
    for j=1:n+1
        u(i,j)=integral(@(y)F(0.02*(j-1),y,(0.0004*(i-1))),Boundary_a,Boundary_b);
        %B=subs(A,{t,x},{0.0025*i,0.05*(j-1)});
        %u(i,j)=double(B);
    end
end
u=u';
end

