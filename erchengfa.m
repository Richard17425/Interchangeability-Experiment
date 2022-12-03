a=importdata('mrq1110.txt');
aaa=mat2cell(a,[2000],[1 1]);
[x,y]=deal(aaa{:});

len=length(x);        %获取数据的长度 

% 公式法计算最小二乘理想直线
k=(5*sum(x.*y)-sum(x)*sum(y))/(5*sum(x.^2)-(sum(x))^2);
b=mean(y)-k*mean(x);

% 用polyfit函数确定最小二乘理想直线
% p=polyfit(x,y,1)
% x1=x;
% y1=polyval(p,x1);
% k=p(1); % 一次项系数
% b=p(2); % 常数项系数 
% 两个方法均可行
xx=x;
yy=k*x+b;

plot(x,y,'linewidth',0.5)                                      %绘制原始数据图
hold on
plot(xx,yy,'r','linewidth',0.5)                      %绘制端点连线图

set(gca,'xtick',[min(x):100:max(x)],'ytick',[min(y):5:max(y)]) %控制刻度
grid on


for i=1:len
   d(i)=y(i)-(k*x(i)+b);            % 循环扫描有所曲线上的点与端点联系的差值
end
L=max(d)-min(d);                    % 计算曲线的直线度误差L=dmax-dmin
[d_max,max_index]=max(d);            % 找到最大偏差的点 （二者有正负，是相对的）
[d_min,min_index]=min(d);            % 找到最小偏差的点
hold on
plot([max_index,max_index],[y(max_index),k*max_index+b],'b--')          %绘制偏差线
plot([min_index,min_index],[y(min_index),k*min_index+b],'k--')
xlabel('x(测量点序号)')
ylabel('y(测量值)')
title({['理想直线方程为： ','y=',num2str(k),'x','+','(',num2str(b),')'];['最小二乘法求直线度值为：',num2str(L)]})
