clc;clear;
tspan=[0 160];%总步长设置
y0=[0 0 0 0];%初值设置
B=10000;%直线阻尼器的阻尼系数
Bx=1000;%旋转阻尼器的阻尼系数
w=1.7152;T=(2*pi)/w;Ttotal=40*T;%计算前40个波浪周期的总时间
n=Ttotal/0.2;nL=ceil(n);%求出40个波浪周期内每间隔0.2s计数的次数
%%四阶五阶RK法求解微分方程组(垂荡和纵摇)
[t_Q3chuidang,x_Q3chuidang]=ode45(@(t,x)odefun_Q3chuidang(t,x,B),0:0.2:ceil(Ttotal),y0);
[t_Q3zongyao,J_Q3zongyao]=ode113(@(t,x)odefun_Q3zongyao(t,x,Bx),0:0.2:ceil(Ttotal),y0);
x_Q3chuidang=[t_Q3chuidang,x_Q3chuidang];
J_Q3zongyao=[t_Q3zongyao,J_Q3zongyao];
%%根据题目1要求，搜索每隔0.2s的数据，并将他们整理成result_3矩阵
result3_1=x_Q3chuidang(1:734,1:5);
result3_1(:,[2,4])=result3_1(:,[4,2]);
result3_1(:,[3,5])=result3_1(:,[5,3]);
result3_2=J_Q3zongyao(1:734,1:5);
result_3=[result3_1(:,1),result3_1(:,2),result3_1(:,3),result3_2(:,2),result3_2(:,3),result3_1(:,4),result3_1(:,5),result3_2(:,4),result3_2(:,5)];
%%绘制振子/浮子的位移/速度-时间图
figure(1)
lstr = { '浮子的位移', '浮子的速度', '振子的位移', '振子的速度' };
for i=1:length(lstr)
    subplot(2,2,i)
    plot(result3_1(:,1), result3_1(:,i+1));
    xlabel('时间')
    ylabel( lstr{i} )
    title('题目三垂荡情况振子/浮子的位移/速度-时间图{B=10000情形}')
end
figure(2)
lstr = { '浮子的位移', '浮子的速度', '振子的位移', '振子的速度' };
for i=1:length(lstr)
    subplot(2,2,i)
    plot(J_Q3zongyao(:,1), J_Q3zongyao(:,i+1));
    xlabel('时间')
    ylabel( lstr{i} )
    title('题目三纵摇情况振子/浮子的位移/速度-时间图{Bx=1000情形}')
end