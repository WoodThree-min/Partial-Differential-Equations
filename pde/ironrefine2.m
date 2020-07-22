x=0:0.05:1;
avi_heat=VideoWriter('heat-time.avi');
open(avi_heat);
steps=size(U,2);
M=moviein(steps);
for j=1:steps
    u=U(:,j)';
    plot(x,u,'LineWidth',2);
    axis([0,1,0,4]);
    title("heat-time");
    xlabel("X");ylabel("U");
    %M(j)=getframe;
    %writeVideo(avi_heat,M(j));
    frame=getframe(gcf);
    im=frame2im(frame); %�Ƚ��ṹframeת��Ϊ��Ӧ��ͼ��
    [l,map]=rgb2ind(im,256); %��ͼ��תΪ����ͼ������gif�ļ�
    if j==1
        imwrite(l,map,'heat-time.gif','gif','LoopCount',inf);
    else
        imwrite(l,map,'heat-time.gif','gif','WriteMode','append');
    end
    
    
end
close(avi_heat);
movie(M,20);

