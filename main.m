clc;clear;close all
%% 任务数设置
step = 50;          %任务数间隔
Num = 1:1:20;        %局点个数
testT = Num*step;   %任务数集合
%% 参数设置
floc=1  ;      %1Ghz
fser=100 ;     %100 Ghz
Pcpu = 0.5 ;      %0.5W
Ptu = 2 ;         %2W
Rptu = 5 ;        %Mbps
rt = 0.5;         %时间权重
re = 0.5;         %能耗权重
Gnum = 200;       %迭代次数***
%K = 0;            %负载K
%% 保存路径
now = datestr(now,30); %获取系统时间按20190101T1200的格式输出
Path = '/Users/Johnny/Documents/06Workplace/MATLAB/moblie-edge-computing/Results/';
path = strcat(Path,now,'/');
mkdir(path); %创建存放数据的文件夹
pathdata = strcat(path,'data/');
mkdir(pathdata);
Tasks = load('Task1000');
%% 数据计算
counter = 1 ;%计数器
resulte = zeros(max(Num),5);
resultk = zeros(max(Num),5);
resulttime = zeros(max(Num),5);
resultq = zeros(max(Num),5);
for i = testT
Tnum = i;              %任务数量 
%[T] = initTfunc(Tnum,floc,fser,Rptu); %初始化任务集T
[T] =  initnewT(Tasks,Tnum,floc,fser,Rptu);

Qrand = T(:,2);             %生成控制序列Q
Qloc = zeros(Tnum,1);     %生成控制序列Q0
Qser = zeros(Tnum,1)+1;   %生成控制序列Q1


[K0,t0,e0]=KK(T,Tnum,Qloc,Ptu,Pcpu,rt,re);
[K,t,e]=KK(T,Tnum,Qrand,Ptu,Pcpu,rt,re);
[K1,t1,e1]=KK(T,Tnum,Qser,Ptu,Pcpu,rt,re);
[Kbest,Qbest,tbest,ebest] = BPSO(T,Tnum,Qrand,Ptu,Pcpu,rt,re,Gnum);



%result = [Tnum,K,K0,K1];
%dlmwrite('result1.txt',result,'-append');

resulte(counter,:) = [Tnum,e,e0,e1,ebest];
%resultename = strcat(now,'能耗');
%dlmwrite(strcat(pathdata,resultename),resulte,'-append');

resultk(counter,:) = [Tnum,K,K0,K1,Kbest];
%resultkname = strcat(now,'负载'); 
%dlmwrite(strcat(pathdata,resultkname),resultk,'-append');

resulttime(counter,:)  = [Tnum,t,t0,t1,tbest];
%resulttimename = strcat(now,'延时');
%dlmwrite(strcat(pathdata,resulttimename),resulttime,'-append');

resultq(counter,:) = [Tnum,sum(Qrand),sum(Qloc),sum(Qser),sum(Qbest)];
%resultqname = strcat(now,'任务迁移个数');
%dlmwrite(strcat(pathdata,resultqname),resultq,'-append');
counter = counter + 1;
end

resultename = strcat(now,'能耗');
dlmwrite(strcat(pathdata,resultename),resulte,'-append');

resultkname = strcat(now,'负载'); 
dlmwrite(strcat(pathdata,resultkname),resultk,'-append');

resulttimename = strcat(now,'延时');
dlmwrite(strcat(pathdata,resulttimename),resulttime,'-append');

resultcountname = strcat(now,'任务迁移个数');
dlmwrite(strcat(pathdata,resultcountname),resultq,'-append');

%% 绘图
resulte = load(strcat(pathdata,resultename));
figure(1);set(gcf, 'position', [0 0 1000 500]);eplot(resulte);
saveas(1,strcat(path,resultename),'png');

resultk = load(strcat(pathdata,resultkname));
figure(2);set(gcf, 'position', [0 0 1000 500]);kplot(resultk);
saveas(2,strcat(path,resultkname),'png');

resulttime = load(strcat(pathdata,resulttimename));
figure(3);set(gcf, 'position', [0 0 1000 500]);tplot(resulttime);
saveas(3,strcat(path,resulttimename),'png');

resultcount = load(strcat(pathdata,resultcountname));
figure(4);set(gcf, 'position', [0 0 1000 500]);cplot(resultcount);
saveas(4,strcat(path,resultcountname),'png');
