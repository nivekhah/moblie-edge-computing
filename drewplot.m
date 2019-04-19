clc;clear;close all
testT = [5,10,15,20,25,30,35,40,45,50]*4;
now = datestr(now,30);
Path = '/Users/Johnny/Documents/06Workplace/MATLAB/moblie-edge-computing/Results/';
path = strcat(Path,now,'/');
mkdir (path);
for i = testT
floc=1  ;      %1Ghz
fser=100 ;     %100 Ghz
Tnum = i;        %任务数量 
Pcpu = 0.5 ;      %0.5W
Ptu = 2 ;         %2W
Rptu = 5 ;        %Mbps
rt = 0.5;         %时间权重
re = 0.5;         %能耗权重
%K = 0;            %负载K
[T] = initTfunc(Tnum,floc,fser,Rptu); %初始化任务集T
Q = T(:,2);             %生成控制序列Q
Q0 = zeros(Tnum,1);     %生成控制序列Q0
Q1 = zeros(Tnum,1)+1;   %生成控制序列Q1


[K0,t0,e0]=KK(T,Tnum,Q0,Ptu,Pcpu,rt,re);
[K,t,e]=KK(T,Tnum,Q,Ptu,Pcpu,rt,re);
[K1,t1,e1]=KK(T,Tnum,Q1,Ptu,Pcpu,rt,re);
[Kbest,Qbest,tbest,ebest] = BPSO(T,Tnum,Q1,Ptu,Pcpu,rt,re);


%result = [Tnum,K,K0,K1];
%dlmwrite('result1.txt',result,'-append');

resulte = [Tnum,e,e0,e1,ebest];
resultename = strcat(now,'能耗');
dlmwrite(strcat(path,resultename),resulte,'-append');

resultk = [Tnum,K,K0,K1,Kbest];
resultkname = strcat(now,'负载'); 
dlmwrite(strcat(path,resultkname),resultk,'-append');

resulttime = [Tnum,t,t0,t1,tbest];
resulttimename = strcat(now,'延时');
dlmwrite(strcat(path,resulttimename),resulttime,'-append');

end

resulte = load(strcat(path,resultename));
figure(1);efplot(resulte);
saveas(1,strcat(path,resultename),'png');

resultk = load(strcat(path,resultkname));
figure(2);kfplot(resultk);
saveas(2,strcat(path,resultkname),'png');

resulttime = load(strcat(path,resulttimename));
figure(3);tfplot(resulttime);
saveas(3,strcat(path,resulttimename),'png');
