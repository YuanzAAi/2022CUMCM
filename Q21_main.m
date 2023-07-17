clc;clear;
tspan=[0 180];%总步长设置
y0=[0 0 0 0];%初值设置
%%四阶五阶RK法求解微分方程组(情形1）
[t_Q211W,x_Q211W]=ode45('odefun_Q211W',tspan,y0);
[t_Q213W,x_Q213W]=ode45('odefun_Q213W',tspan,y0);
[t_Q215W,x_Q215W]=ode45('odefun_Q215W',tspan,y0);
[t_Q217W,x_Q217W]=ode45('odefun_Q217W',tspan,y0);
[t_Q219W,x_Q219W]=ode45('odefun_Q219W',tspan,y0);
[t_Q2110W,x_Q2110W]=ode45('odefun_Q2110W',tspan,y0);
%%计算PTO系统平均输出功率
S=pi*1^2;%浮子入水横截面积
m2=4866;%浮子质量
p=1165.992;%垂荡附加质量
density=1025;%海水的密度
g=9.8;%重力加速度
w=2.2143;%入射波浪频率
k1=length(x_Q211W);k2=length(x_Q213W);k3=length(x_Q215W);
k4=length(x_Q217W);k5=length(x_Q219W);k6=length(x_Q2110W);
for i0=8;i1=1:k1;i2=1:k2;i3=1:k3;i4=1:k4;
    i5=1:k5;i6=1:k6;
    vd1W=zeros(size(x_Q211W,1),1);vd3W=zeros(size(x_Q213W,1),1);vd5W=zeros(size(x_Q215W,1),1);
    vd7W=zeros(size(x_Q217W,1),1);vd9W=zeros(size(x_Q219W,1),1);vd10W=zeros(size(x_Q2110W,1),1);
    vd1W(i1,1)=(x_Q211W(i1,4)-x_Q211W(i1,2)).^2;vd3W(i2,1)=(x_Q213W(i2,4)-x_Q213W(i2,2)).^2;
    vd5W(i3,1)=(x_Q215W(i3,4)-x_Q215W(i3,2)).^2;vd7W(i4,1)=(x_Q217W(i4,4)-x_Q217W(i4,2)).^2;
    vd9W(i5,1)=(x_Q219W(i5,4)-x_Q219W(i5,2)).^2;vd10W(i6,1)=(x_Q2110W(i6,4)-x_Q2110W(i6,2)).^2;
end

vd1W=sum(vd1W,1);vd3W=sum(vd3W,1);vd5W=sum(vd5W,1);vd7W=sum(vd7W,1);
vd9W=sum(vd9W,1);vd10W=sum(vd10W,1);
vdtotal=[vd1W;vd3W;vd5W;vd7W;vd9W;vd10W];
vdtotal(1,1)=vdtotal(1,1)/k1;vdtotal(2,1)=vdtotal(2,1)/k2;vdtotal(3,1)=vdtotal(3,1)/k3;
vdtotal(4,1)=vdtotal(4,1)/k4;vdtotal(5,1)=vdtotal(5,1)/k5;vdtotal(6,1)=vdtotal(6,1)/k6;
B=[10000;30000;50000;70000;90000;100000];
for i7=1:size(vdtotal,1)
    Pt(i7,1)=0.5*B(i7,1)*vdtotal(i7,1);
end
figure(1)
plot(B(:,1),Pt(:,1));
xlabel('B')
ylabel('Pt')
title('Pt-B图(情形1)')