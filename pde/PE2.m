%% �׷�����Ч��

figure;
for i=1:50
    [U3,temp]=spectrm(1,1,401,21,i);
    temp=temp(:);
    td(i)=temp'*temp;
end
plot(td,'--*','LineWidth',2,'MarkerSize',10);
ylim([0 10^(-6)]);
title('�׷���Ч��');


%% һά�ȷ��̽��ʱ��仯ͼ
x=0:0.05:1;
U=forwardPE(1,1,0.25,20,400);

avi_heat=VideoWriter('heat change over time.avi');
open(avi_heat);
M=moviein(400);
for j=1:400
    u=U(:,j)';
    plot(x,u,'LineWidth',2);
    axis([0,1,-2,4]);
    title("heat change over time");
    xlabel("X");ylabel("U");
    %M(j)=getframe;
    %writeVideo(avi_heat,M(j));
    frame=getframe(gcf);
    im=frame2im(frame); %�Ƚ��ṹframeת��Ϊ��Ӧ��ͼ��
    [l,map]=rgb2ind(im,256); %��ͼ��תΪ����ͼ������gif�ļ�
    if j==1
        imwrite(l,map,'heat_change_over_time.gif','gif','LoopCount',inf);
    else
        imwrite(l,map,'heat_change_over_time.gif','gif','WriteMode','append');
    end
    
    
end
close(avi_heat);
movie(M,10);


