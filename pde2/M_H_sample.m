clc;clear;

% 随意设
data_size=100000; % 越大越准
start=1; % 非负即可

% 初始化
data=start;
index=1;

% 直接生成多个服从均值为10的指数分布的样本
data_dir=exprnd(10,[1,data_size]);

%%
figure;
subplot(1,2,1)
histogram(data_dir,'BinWidth',1);
axis([0,100,0,data_size/10]);

% 随机模拟
while(index<data_size)
    u=rand; % 均匀抽样
    data_next=normrnd(data(index),1); % 简单分布为标准正态分布

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