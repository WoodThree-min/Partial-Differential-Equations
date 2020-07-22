clc;clear;

% ������
data_size=100000; % Խ��Խ׼
start=1; % �Ǹ�����

% ��ʼ��
data=start;
index=1;

% ֱ�����ɶ�����Ӿ�ֵΪ10��ָ���ֲ�������
data_dir=exprnd(10,[1,data_size]);

%%
figure;
subplot(1,2,1)
histogram(data_dir,'BinWidth',1);
axis([0,100,0,data_size/10]);

% ���ģ��
while(index<data_size)
    u=rand; % ���ȳ���
    data_next=normrnd(data(index),1); % �򵥷ֲ�Ϊ��׼��̬�ֲ�

    buf=exppdf(data_next,10)/exppdf(data(index),10);
    alpha=min(1,buf);

    if u<alpha
        data=[data data_next];
    else
        data=[data data(index)];
    end

    index = index+1;
end
subplot(1,2,2)
histogram(data,'BinWidth',1);
axis([0,100,0,data_size/10]);