% ����ʱ��һ����Э����֤
% �����̶����ˣ��ͷ�����һ����л�����

clear
clc

% �����������������£�
t0 = 0;
tfinal = 10;

X0 = [-7.50; 0.25; -7.50; 4.75; 3.00; 7.00];

[t_a, Xt_a] = ode45(@SunFun_a, [t0 tfinal], X0);
[t_b, Xt_b] = ode45(@SunFun_b, [t0 tfinal], X0);
[t_c, Xt_c] = ode45(@SunFun_c, [t0 tfinal], X0);
[t, Xt] = ode45(@SunFun, [t0 tfinal], X0);

% ���ƽ��ͼ
figure(1)
subplot(2,2,1)
plot(t_a,Xt_a(:,1), t_a,Xt_a(:,2), t_a,Xt_a(:,3), t_a,Xt_a(:,4), t_a,Xt_a(:,5), t_a,Xt_a(:,6), 'linewidth', 1.5)
legend('x_1', 'x_2', 'x_3', 'x_4', 'x_5', 'x_6');
xlabel('time(sec)'); ylabel('node values'); title('Fixed topology a'); grid

subplot(2,2,2)
plot(t_b,Xt_b(:,1), t_b,Xt_b(:,2), t_b,Xt_b(:,3), t_b,Xt_b(:,4), t_b,Xt_b(:,5), t_b,Xt_b(:,6), 'linewidth', 1.5)
legend('x_1', 'x_2', 'x_3', 'x_4', 'x_5', 'x_6');
xlabel('time(sec)'); ylabel('node values'); title('Fixed topology b'); grid

subplot(2,2,3)
plot(t_c,Xt_c(:,1), t_c,Xt_c(:,2), t_c,Xt_c(:,3), t_c,Xt_c(:,4), t_c,Xt_c(:,5), t_c,Xt_c(:,6), 'linewidth', 1.5)
legend('x_1', 'x_2', 'x_3', 'x_4', 'x_5', 'x_6');
xlabel('time(sec)'); ylabel('node values'); title('Fixed topology c'); grid

subplot(2,2,4)
plot(t,Xt(:,1), t,Xt(:,2), t,Xt(:,3), t,Xt(:,4), t,Xt(:,5), t,Xt(:,6), 'linewidth', 1.5)
legend('x_1', 'x_2', 'x_3', 'x_4', 'x_5', 'x_6');
xlabel('time(sec)'); ylabel('node values'); title('Switching topology a-->b-->c'); grid


% ΢�ַ��̺�����״̬����
function xdot = SunFun_a(t,x)
D_a = [1 0 0 0 0 0;0 1 0 0 0 0;0 0 1 0 0 0;0 0 0 1 0 0;0 0 0 0 1 0;0 0 0 0 0 1;];
A_a = [0 1 0 0 0 0;0 0 1 0 0 0;0 0 0 1 0 0;0 0 0 0 1 0;0 0 0 0 0 1;1 0 0 0 0 0;];
L_a = D_a - A_a;

L = L_a;
% ������ϵʽ
xdot = -L * x;

end
function xdot = SunFun_b(t,x)
D_b = [2 0 0 0 0 0;0 1 0 0 0 0;0 0 1 0 0 0;0 0 0 1 0 0;0 0 0 0 1 0;0 0 0 0 0 1;];
A_b = [0 1 0 1 0 0;0 0 1 0 0 0;0 0 0 1 0 0;0 0 0 0 1 0;0 0 0 0 0 1;1 0 0 0 0 0;];
L_b = D_b - A_b;

L = L_b;
% ������ϵʽ
xdot = -L * x;

end
function xdot = SunFun_c(t,x)
D_c = [2 0 0 0 0 0;0 2 0 0 0 0;0 0 2 0 0 0;0 0 0 1 0 0;0 0 0 0 1 0;0 0 0 0 0 1;];
A_c = [0 1 0 1 0 0;0 0 1 0 1 0;0 0 0 1 0 1;0 0 0 0 1 0;0 0 0 0 0 1;1 0 0 0 0 0;];
L_c = D_c - A_c;

L = L_c;
% ������ϵʽ
xdot = -L * x;

end
function xdot = SunFun(t,x)
D_a = [1 0 0 0 0 0;0 1 0 0 0 0;0 0 1 0 0 0;0 0 0 1 0 0;0 0 0 0 1 0;0 0 0 0 0 1;];
A_a = [0 1 0 0 0 0;0 0 1 0 0 0;0 0 0 1 0 0;0 0 0 0 1 0;0 0 0 0 0 1;1 0 0 0 0 0;];
L_a = D_a - A_a;

D_b = [2 0 0 0 0 0;0 1 0 0 0 0;0 0 1 0 0 0;0 0 0 1 0 0;0 0 0 0 1 0;0 0 0 0 0 1;];
A_b = [0 1 0 1 0 0;0 0 1 0 0 0;0 0 0 1 0 0;0 0 0 0 1 0;0 0 0 0 0 1;1 0 0 0 0 0;];
L_b = D_b - A_b;

D_c = [2 0 0 0 0 0;0 2 0 0 0 0;0 0 2 0 0 0;0 0 0 1 0 0;0 0 0 0 1 0;0 0 0 0 0 1;];
A_c = [0 1 0 1 0 0;0 0 1 0 1 0;0 0 0 1 0 1;0 0 0 0 1 0;0 0 0 0 0 1;1 0 0 0 0 0;];
L_c = D_c - A_c;

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
xdot = -L * x;

end