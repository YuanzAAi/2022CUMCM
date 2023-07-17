function dx=odefun_Q217W(t,x)
B=70000;%直线阻尼器的阻尼系数
m1=2433;%振子质量
m2=4866;%浮子质量
k=80000;%弹簧刚度
p=1165.992;%垂荡附加质量
q=167.8395;%垂荡兴波阻尼系数
C=1025*9.8*pi*1^2;%恢复刚度系数
f=4890;%垂荡激励力振幅
w=2.2143;%入射波浪频率
%定义x（1）=z（1），x（2）=z（1）'，x（3）=z（2），x（4）=z（2）'
dx=zeros(4,1);
dx(1)=x(2);
dx(2)=(-B*(x(2)-x(4))-k*(x(1)-x(3)))/m1;
dx(3)=x(4);
dx(4)=(f*cos(w*t)-C*x(3)-k*(x(3)-x(1))-B*(x(4)-x(2))-q*x(4))/(m2+p);
end