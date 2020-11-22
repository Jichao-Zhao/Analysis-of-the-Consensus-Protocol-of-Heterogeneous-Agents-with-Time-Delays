clear
clc

% ����ʱ��һ����Э����֤



% �����������������£�
t0 = 0;
tfinal = 10;

X0 = [-7.50; 0.25; -7.50; 4.75; 3.00; 7.00];

[t, Xt] = ode45(@SunFun, [t0 tfinal], X0);

% ���ƽ��ͼ
plot(t,Xt(:,1), t,Xt(:,2), t,Xt(:,3), t,Xt(:,4), t,Xt(:,5), t,Xt(:,6), 'linewidth', 1.5)
legend('x_1', 'x_2', 'x_3', 'x_4', 'x_5', 'x_6')
xlabel('time(sec)')
ylabel('node values')
title('fixed topology convergence')
grid

% ΢�ַ��̺�����״̬����
function xdot = SunFun(t,x)
D = [
1 0 0 0 0 0;
0 1 0 0 0 0;
0 0 1 0 0 0;
0 0 0 1 0 0;
0 0 0 0 1 0;
0 0 0 0 0 1;];

A = [
0 1 0 0 0 0;
0 0 1 0 0 0;
0 0 0 1 0 0;
0 0 0 0 1 0;
0 0 0 0 0 1;
1 0 0 0 0 0;];
L = D - A;

% ������ϵʽ
xdot = -L * x;

end
