function gf=pp(t,x,y,L,n)
if n==1
    gf=p(t,x,y)-p(t,x+2*L,y+2*L);
   
elseif n==2
    gf=p(t,x,y)+p(t,x+2*L,y+2*L); 
end
end