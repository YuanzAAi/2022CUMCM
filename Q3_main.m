clc;clear;
tspan=[0 160];%�ܲ�������
y0=[0 0 0 0];%��ֵ����
B=10000;%ֱ��������������ϵ��
Bx=1000;%��ת������������ϵ��
w=1.7152;T=(2*pi)/w;Ttotal=40*T;%����ǰ40���������ڵ���ʱ��
n=Ttotal/0.2;nL=ceil(n);%���40������������ÿ���0.2s�����Ĵ���
%%�Ľ����RK�����΢�ַ�����(��������ҡ)
[t_Q3chuidang,x_Q3chuidang]=ode45(@(t,x)odefun_Q3chuidang(t,x,B),0:0.2:ceil(Ttotal),y0);
[t_Q3zongyao,J_Q3zongyao]=ode113(@(t,x)odefun_Q3zongyao(t,x,Bx),0:0.2:ceil(Ttotal),y0);
x_Q3chuidang=[t_Q3chuidang,x_Q3chuidang];
J_Q3zongyao=[t_Q3zongyao,J_Q3zongyao];
%%������Ŀ1Ҫ������ÿ��0.2s�����ݣ��������������result_3����
result3_1=x_Q3chuidang(1:734,1:5);
result3_1(:,[2,4])=result3_1(:,[4,2]);
result3_1(:,[3,5])=result3_1(:,[5,3]);
result3_2=J_Q3zongyao(1:734,1:5);
result_3=[result3_1(:,1),result3_1(:,2),result3_1(:,3),result3_2(:,2),result3_2(:,3),result3_1(:,4),result3_1(:,5),result3_2(:,4),result3_2(:,5)];
%%��������/���ӵ�λ��/�ٶ�-ʱ��ͼ
figure(1)
lstr = { '���ӵ�λ��', '���ӵ��ٶ�', '���ӵ�λ��', '���ӵ��ٶ�' };
for i=1:length(lstr)
    subplot(2,2,i)
    plot(result3_1(:,1), result3_1(:,i+1));
    xlabel('ʱ��')
    ylabel( lstr{i} )
    title('��Ŀ�������������/���ӵ�λ��/�ٶ�-ʱ��ͼ{B=10000����}')
end
figure(2)
lstr = { '���ӵ�λ��', '���ӵ��ٶ�', '���ӵ�λ��', '���ӵ��ٶ�' };
for i=1:length(lstr)
    subplot(2,2,i)
    plot(J_Q3zongyao(:,1), J_Q3zongyao(:,i+1));
    xlabel('ʱ��')
    ylabel( lstr{i} )
    title('��Ŀ����ҡ�������/���ӵ�λ��/�ٶ�-ʱ��ͼ{Bx=1000����}')
end