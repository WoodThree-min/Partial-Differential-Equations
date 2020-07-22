Times=50:50:600;
lgstd=log(sqrt(resvar)); 

fig=figure;
subplot(1,2,1);
plot(Times,resstd,'--*');
xlabel("number of tracks");
ylabel("error");
title("Error (by Monte-Carlo Method)");

subplot(1,2,2);
plot(log(Times),lgstd,'--*')
xlabel('log of the number of tracks');
ylabel('log of the error');
title('Log of Error');

response=fig2plotly(fig,'offline',true,'filename','Error-of-MC');
ploylu_url=response.url;

