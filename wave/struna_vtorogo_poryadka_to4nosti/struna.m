%��������� ������ (��������� �� 1 ��) ���������� ��������� �����
%������� ������� ��������
clc
clear all
n = 100;
delta_tau = 0.1;
u_Left = 0;
u_Right = 0;
L = 1;
h = L /(n + 1);
alf = 1/2;

for i = 1 : n + 2
    x(i) = (i - 1)*h;
end

% ������� ����� ��������� ����� (��������� ��������� ������)
for i = 1 : n
   if i <= n*alf
        U00(i) = x(i + 1)/alf; % ��������� ��������� ������ (��� ������� ������ �� ��������)
    else
        U00(i) = (1-x(i+1))/(1-alf); % ��������� ��������� ������ (����� ������� ������ - ���� ��������)
    end
end

vel = zeros(1,n);  % ��������� �������� 
U0 = U00 + delta_tau*vel; 
time = 0;
hold on;

for i = 1 : 1
    time = time + delta_tau;
    
    for i = 1 : n
        a(i) = (1/2)*1/h^2;
        c(i) = (1/2)*1/h^2;
        b(i) = 1/2*(2/h^2) + 1/delta_tau^2;
    end
    
    for i = 2 : n-1
        d(i) = (-1/2)*((U00(i+1)-2*U00(i)+U00(i-1))/h^2)+(-2*U0(i)+U00(i))/delta_tau^2;
    end
    d(1) = -(1/2)*(U00(2)-2*U00(1)+u_Left)/h^2+(-2*U0(1)+U00(1))/delta_tau^2;
    d(n) = -(1/2)*(u_Right-2*U00(n)+U00(n-1))/h^2+(-2*U0(n)+U00(n))/delta_tau^2;

    a(1) = 0;
    c(n) = 1;

    U = progonka(a, b, c, d);

     plot(x,[u_Left U u_Right])
     grid on
     hold on
     U00 = U0;
     U0 = U;
end
time