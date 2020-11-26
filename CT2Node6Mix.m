clear
clc

% �����������������£�
t0 = 0; tt = 3;

X0 = [-20.50, 30.25, -13.25, 24.75, -7.25, 16.00];

% ����ȫ�ֱ���
global A B L_a L_b L_c

% ���ѡȡ��ϵ�� T �� K ֵ
T1 = 0.81; T2 = 0.27; T3 = 0.95; T4 = 0.79; T5 = 0.67; T6 = 0.70;
K1 = 0.91; K2 = 0.55; K3 = 0.49; K4 = 0.96; K5 = 0.76; K6 = 0.03;

% ����ϵͳ״̬����
A =[-1/T1 0 0 0 0 0;0 -1/T2 0 0 0 0;0 0 -1/T3 0 0 0;0 0 0 -1/T4 0 0;0 0 0 0 -1/T5 0;0 0 0 0 0 -1/T6;];
B =[K1/T1 0 0 0 0 0;0 K2/T2 0 0 0 0;0 0 K3/T3 0 0 0;0 0 0 K4/T4 0 0;0 0 0 0 K5/T5 0;0 0 0 0 0 K6/T6;];

% ��������ͼ Ga �����Ͼ���
D_a = [1 0 0 0 0 0;0 1 0 0 0 0;0 0 1 0 0 0;0 0 0 1 0 0;0 0 0 0 1 0;0 0 0 0 0 1;];
A_a = [0 1 0 0 0 0;0 0 1 0 0 0;0 0 0 1 0 0;0 0 0 0 1 0;0 0 0 0 0 1;1 0 0 0 0 0;];
L_a = D_a - A_a;

% ��������ͼ Gb �����Ͼ���
D_b = [2 0 0 0 0 0;0 1 0 0 0 0;0 0 1 0 0 0;0 0 0 1 0 0;0 0 0 0 1 0;0 0 0 0 0 1;];
A_b = [0 1 0 1 0 0;0 0 1 0 0 0;0 0 0 1 0 0;0 0 0 0 1 0;0 0 0 0 0 1;1 0 0 0 0 0;];
L_b = D_b - A_b;

% ��������ͼ Gc �����Ͼ���
D_c = [2 0 0 0 0 0;0 2 0 0 0 0;0 0 2 0 0 0;0 0 0 1 0 0;0 0 0 0 1 0;0 0 0 0 0 1;];
A_c = [0 1 0 1 0 0;0 0 1 0 1 0;0 0 0 1 0 1;0 0 0 0 1 0;0 0 0 0 0 1;1 0 0 0 0 0;];
L_c = D_c - A_c;

% ������ϵͳ��΢�ַ��̽�
[t, Xt] = ode45(@SunFun, [t0 tt], X0);
[tUa, XtUa] = ode45(@SunFunUa, [t0 tt], X0);
[tUb, XtUb] = ode45(@SunFunUb, [t0 tt], X0);
[tUc, XtUc] = ode45(@SunFunUc, [t0 tt], X0);
[tS, XtS] = ode45(@SunFunS, [t0 tt], X0);

% ���ƽ��ͼ
subplot(2,3,1); 
plot(t,Xt(:,1), t,Xt(:,2), t,Xt(:,3), t,Xt(:,4), t,Xt(:,5), t,Xt(:,6), 'linewidth',1.5); 
xlabel('Time(sec)'); ylabel('Nodes States');
legend('x_1','x_2','x_3','x_4','x_5','x_6')
title('No U Control');
grid

subplot(2,3,2); 
plot(tUa,XtUa(:,1), tUa,XtUa(:,2), tUa,XtUa(:,3), tUa,XtUa(:,4), tUa,XtUa(:,5), tUa,XtUa(:,6), 'linewidth',1.5); 
xlabel('Time(sec)'); ylabel('Nodes States');
legend('x_1','x_2','x_3','x_4','x_5','x_6');
title('Fixed Topology G_a');
grid

subplot(2,3,3); 
plot(tUb,XtUb(:,1), tUb,XtUb(:,2), tUb,XtUb(:,3), tUb,XtUb(:,4), tUb,XtUb(:,5), tUb,XtUb(:,6), 'linewidth',1.5); 
xlabel('Time(sec)'); ylabel('Nodes States');
legend('x_1','x_2','x_3','x_4','x_5','x_6');
title('Fixed Topology G_b');
grid

subplot(2,3,4); 
plot(tUc,XtUc(:,1), tUc,XtUc(:,2), tUc,XtUc(:,3), tUc,XtUc(:,4), tUc,XtUc(:,5), tUc,XtUc(:,6), 'linewidth',1.5); 
xlabel('Time(sec)'); ylabel('Nodes States');
legend('x_1','x_2','x_3','x_4','x_5','x_6');
title('Fixed Topology G_c');
grid

subplot(2,3,5); 
plot(tS,XtS(:,1), tS,XtS(:,2), tS,XtS(:,3), tS,XtS(:,4), tS,XtS(:,5), tS,XtS(:,6), 'linewidth', 1.5)
legend('x_1', 'x_2', 'x_3', 'x_4', 'x_5', 'x_6');
xlabel('Time(sec)'); ylabel('Nodes States'); 
title('Switching Topology G_a -> G_b -> G_c'); 
grid


% �޿�������ϵͳ���
function xdot = SunFun(t,x)
% ����
global A

% ������ϵʽ
xdot = (A) * x;
end

% �̶����˽ṹ Ga ���
function xdot = SunFunUa(t,x)
% ����
global A B L_a

% ������ϵʽ
xdot = (A) * x + (B) * (-L_a) * x;
end

% �̶����˽ṹ Gb ���
function xdot = SunFunUb(t,x)
% ����
global A B L_b

% ������ϵʽ
xdot = (A) * x + (B) * (-L_b) * x;
end

% �̶����˽ṹ Gc ���
function xdot = SunFunUc(t,x)
% ����
global A B L_c

% ������ϵʽ
xdot = (A) * x + (B) * (-L_c) * x;
end

% �л�����ͼ���
function xdot = SunFunS(t,x)
% ����
global A B L_a L_b L_c
L = L_a;

% �л��ź�
% �л����ж�ʱ��� 3 ȡ����
% �������Ϊ 0 �Ǿ�ʹ�� L_a ���˽ṹ���Դ�����

st = mod(t,3);

if st>0 && st<=1
    L = L_a;
elseif st>1 && st<=2
    L = L_b;
elseif st>2 && st<=3
    L = L_c;
end

% ������ϵʽ
xdot = (A) * x + (B) * (-L) * x;

end