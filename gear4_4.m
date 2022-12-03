data=load('10.18互换性实验齿轮双面啮合检查\20221018-1.txt');
x=data(:,1);
plot(x,LineWidth=1.5);
xlabel('角度/°');
ylabel('中心距变动量/μm');
axis([0 840 -200 100]);
set(gca,'XTick',0:56:840);
set(gca,'XTickLabel',0:24:360);
%set(gca,'xtick',xtick,'xticklabel',xticklabel);

%求取径向综合总偏差
a=max(data)-min(data);      


%一齿径向综合偏差
number=length(data); 
N=30;%分组数
c=floor(number/N);%每组数据数
A=zeros(c,N);
B=zeros(1,N);%存储每一组的极差
for k=1:N
A(:,k)=data((k-1)*c+1:k*c);
end
for m=1:N
B(m)=max(A(:,m))-min(A(:,m));
end
b=max(B);      

title(gca,['径向综合总偏差F^"_i为: ',num2str(a),'μm  ','  齿径向综合偏差f^"_i为: ',num2str(b),'μm']);