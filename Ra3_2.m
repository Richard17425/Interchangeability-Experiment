%% 原始轮廓图
a=importdata('四个工件的原始高度数据采样长度0.8\1-1t.txt');
x=a.data(1:800,1);
plot(x,LineWidth=1.2);
title(gca,'原始轮廓图');
axis([0 800 -6 8]);
set(gca,'XTick',0:100:800);
set(gca,'XTickLabel',0:0.05:4);
xlabel(gca,'轮廓宽度（mm）');
ylabel(gca,'轮廓高度（μm）');
%% 表面轮廓图
%二维采样长度为：0.800000 mm；采样间隔为：0.005000 mm；采样段数为：5；数据点数为：800。
%实际采样长度应为4mm？
a=importdata('四个工件的原始高度数据采样长度0.8\1-1t.txt');
x=a.data(1:800,1);
plot(x,LineWidth=1.5);
axis([0 800 -6 8]);
set(gca,'XTick',0:100:800);
set(gca,'XTickLabel',0:0.05:4);
xlabel('轮廓宽度（mm）');
ylabel('轮廓高度（μm）');
l=5*0.8*1000;
n=800;  %采样点数
Ra=sum(abs(x))/n;
Rz=max(x)-min(x);
%Rsm计算
k_1=1;
mark1_zero=ones(80,1);
for i=1:n
    if (x(i)>0 && x(i+1)<0)
        mark1_zero(k_1)=i;
        k_1=k_1+1;
    end
end
sigma=0;
for m=1:k_1
sigma=sigma+abs(x(mark1_zero(m+1))-x(mark1_zero(m)))*1000/5; 
 %乘以1000是单位换算，除以5是为了将采样点转换成采样间隔 
end
Rsm=sigma/(k_1-1);

%Rmr(c)计算
c_1=0.5;
c=max(x)-c_1*Rz;
sigma_mlc=0;
for i=1:n
    if  x(i)>c
     sigma_mlc=sigma_mlc+1;
    end
end
Rmrc=100*sigma_mlc/n;

title(['Ra=',num2str(Ra),'μm','   Rz=',num2str(Rz), ...
    'μm','   Rsm=',num2str(Rsm),'μm','    Rmr(c)=',num2str(Rmrc),'%',' c=',num2str(c_1)]);

%% 支承长度率曲线
a=importdata('四个工件的原始高度数据采样长度0.8\1-1t.txt');
x=a.data(1:800,1);
n=800;
Rz=max(x)-min(x);
rmrc=linspace(0,1,n);
max_x=max(x);
sigma_mlc=zeros(n,1);
Rmrc=zeros(n,1);
for j=1:n
c=max_x-rmrc(j)*Rz;
for i=1:n
    if  x(i)>c
     sigma_mlc(j)=sigma_mlc(j)+1;
    end
end
Rmrc(j)=100*sigma_mlc(j)/n;
end
plot(rmrc,Rmrc,LineWidth=1.5);
title('支撑长度率曲线图');
xlabel(gca,'c');
ylabel(gca,'Rmr(c)/%');