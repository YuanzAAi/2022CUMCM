clc;clear;
tspan=[0 180];%总步长设置
y0=[0 0 0 0];%初值设置
%%四阶五阶RK法求解微分方程组(情形1和情形2)
[t_Q11,x_Q11]=ode45('odefun_Q11',tspan,y0);
[t_Q12,x_Q12]=ode45('odefun_Q12',tspan,y0);
w=1.4005;T=(2*pi)/w;Ttotal=40*T;%计算前40个波浪周期的总时间
n=Ttotal/0.2;nL=ceil(n);%求出40个波浪周期内每间隔0.2s计数的次数
x_Q11=[x_Q11,t_Q11];result1_1=zeros(nL,5);o=size(x_Q11,1);
x_Q12=[x_Q12,t_Q12];result1_2=zeros(nL,5);O=size(x_Q12,1);
%%根据题目1要求，搜索每隔0.2s的数据，并将他们整理成result矩阵
for G=1:nL;%初始化result1_1和result1_2矩阵
    result1_1(G,5)=x_Q11(1,5)+G*0.2;
    result1_2(G,5)=result1_1(G,5);
end
 resultfirst=result1_1;
for G=1:nL
    for p=1:o
        for Q=0.001:0.001:0.05
    if abs(result1_1(G,5)-x_Q11(p,5))<=Q
        for m=1:5    
        result1_1(G,m)=x_Q11(p,m);
        end
    end
        end
    end
end
result1_1(:,[1,5])=result1_1(:,[5,1]);
result1_1(:,[2,4])=result1_1(:,[4,2]);
result1_1(:,[3,2])=result1_1(:,[2,3]);
result1_1(:,[4,5])=result1_1(:,[5,4]);
for G=1:nL
    for p=1:O
        for Q=0.001:0.001:0.05
    if abs(result1_2(G,5)-x_Q12(p,5))<=Q
        for M=1:5    
        result1_2(G,M)=x_Q12(p,M);
        end
    end
        end
    end
end
result1_2(:,[1,5])=result1_2(:,[5,1]);
result1_2(:,[2,4])=result1_2(:,[4,2]);
result1_2(:,[3,2])=result1_2(:,[2,3]);
result1_2(:,[4,5])=result1_2(:,[5,4]);
%%绘制振子/浮子的位移/速度-时间图
figure(1)
lstr = { '振子的位移', '振子的速度', '浮子的位移', '浮子的速度' };
for i=1:length(lstr)
    subplot(2,2,i)
    plot(t_Q11, x_Q11(:,i));
    xlabel('时间')
    ylabel( lstr{i} )
    title('振子/浮子的位移/速度-时间图{B=10000情形}')
end
figure(2)
for U=1:length(lstr)
    subplot(2,2,U)
    plot(t_Q12, x_Q12(:,U));
    xlabel('时间')
    ylabel( lstr{U} )
    title('振子/浮子的位移/速度-时间图{B=10000*((abs(x(2)-x(4))))^0.5;情形}')
end