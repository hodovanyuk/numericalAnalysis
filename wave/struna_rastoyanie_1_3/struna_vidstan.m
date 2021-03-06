%��������� ������ (��������� �� 1 ��) � ��������� 1/3

clc
clear all
n = 100;
delta_tau = 0.02;
u_Left = 0;
u_Right = 0;
L = 1;
h = L /(n + 1);
alf = 1/3;

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


for i = 1 : 100
    time = time + delta_tau;
    
    for i = 1 : n
        a(i) = 1/h^2;
        b(i) = 2/h^2 + 1/delta_tau^2;
        c(i) = 1/h^2;
        d(i) = (-2*U0(i)+U00(i))/delta_tau^2;
    end


    d(1) = d(1) + a(1)*u_Left;
    a(1) = 0;
    d(n) = d(n) - c(n)*u_Right;
    c(n) = 1;

    U = progonka(a, b, c, d);

     plot(x,[u_Left U u_Right])
     grid on
     hold on
     U00 = U0;
     U0 = U;
end
time