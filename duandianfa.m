a=importdata('mrq1110.txt');
aaa=mat2cell(a,[2000],[1 1]);
[x,y]=deal(aaa{:});

len=length(x);        %获取数据的长度 

x_start=x(1);        %获取x和y的端点值
x_end=x(end);
y_start=y(1);
y_end=y(end);

% 求直线方程：y=kx+b 方便后续计算
k=(y_end-y_start)/(x_end-x_start);
b=y_end-k*x_end;
%
xx=[x_start,x_end];  %获取x的首末点
yy=[y_start,y_end];  %获取y的首末点

plot(x,y,'linewidth',0.5,'Color','b')                                      %绘制原始数据图
hold on
plot(xx,yy,'-rs','MarkerFaceColor','r','linewidth',2)                      %绘制端点连线图

% str=['理想直线方程为： ','y=',num2str(k),'x','+','(',num2str(b),')'];
% 
% text(3,16,str,'color','red','fontsize',12)

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
title({['理想直线方程为： ','y=',num2str(k),'x','+','(',num2str(b),')'];['端点法求直线度值为：',num2str(L)]});