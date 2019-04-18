function efplot(resulte)
%f = @(x) x;

%x = result1(:,1); 
%A = 
%Xn = size(resulte(:,1));
n = size(resulte,1);
Xjg(1,1) = resulte(2,1)-resulte(1,1);

x=resulte(1,1):Xjg(1,1):n*Xjg;  %x轴上的数据，第一个值代表数据开始，第二个值代表间隔，第三个值代表终止
e=resulte(:,2)/100;                %K数据y值
e0=resulte(:,3)/100;                %K0数据y值
e1 = resulte(:,4)/100;              %K1数据y值
ebest = resulte(:,5)/100;
plot(x,e,'-*b',x,e0,'-or',x,e1,'-dk',x,ebest,'-+g'); title('能耗-任务')     %线性，颜色，标记
axis([0,n*Xjg+Xjg,0,0.4])  %确定x轴与y轴框图大小
set(gca,'XTick',0:Xjg(1,1):n*Xjg+Xjg); %x轴范围，间隔1
set(gca,'YTick',0:0.02:0.4); %y轴范围0-100，间隔5
legend('随机迁移策略','本地执行','云上执行','Union迁移策略');   %右上角标注
xlabel('任务数量')  %x轴坐标描述
ylabel('能耗') %y轴坐标描述
end

