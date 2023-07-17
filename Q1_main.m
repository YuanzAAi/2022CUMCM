clc;clear;
tspan=[0 180];%�ܲ�������
y0=[0 0 0 0];%��ֵ����
%%�Ľ����RK�����΢�ַ�����(����1������2)
[t_Q11,x_Q11]=ode45('odefun_Q11',tspan,y0);
[t_Q12,x_Q12]=ode45('odefun_Q12',tspan,y0);
w=1.4005;T=(2*pi)/w;Ttotal=40*T;%����ǰ40���������ڵ���ʱ��
n=Ttotal/0.2;nL=ceil(n);%���40������������ÿ���0.2s�����Ĵ���
x_Q11=[x_Q11,t_Q11];result1_1=zeros(nL,5);o=size(x_Q11,1);
x_Q12=[x_Q12,t_Q12];result1_2=zeros(nL,5);O=size(x_Q12,1);
%%������Ŀ1Ҫ������ÿ��0.2s�����ݣ��������������result����
for G=1:nL;%��ʼ��result1_1��result1_2����
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
%%��������/���ӵ�λ��/�ٶ�-ʱ��ͼ
figure(1)
lstr = { '���ӵ�λ��', '���ӵ��ٶ�', '���ӵ�λ��', '���ӵ��ٶ�' };
for i=1:length(lstr)
    subplot(2,2,i)
    plot(t_Q11, x_Q11(:,i));
    xlabel('ʱ��')
    ylabel( lstr{i} )
    title('����/���ӵ�λ��/�ٶ�-ʱ��ͼ{B=10000����}')
end
figure(2)
for U=1:length(lstr)
    subplot(2,2,U)
    plot(t_Q12, x_Q12(:,U));
    xlabel('ʱ��')
    ylabel( lstr{U} )
    title('����/���ӵ�λ��/�ٶ�-ʱ��ͼ{B=10000*((abs(x(2)-x(4))))^0.5;����}')
end