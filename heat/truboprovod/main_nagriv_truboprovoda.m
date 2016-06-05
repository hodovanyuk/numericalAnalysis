%����� �� ����� , ������� ������������
%�� ����� ��������� ����������� ���� ����� ������ ��������
clc
clear all
n = 101;
r0 = 24;
R = 25;
h = (R-r0)/(n + 1);
dt = 0.01;

v_v = 0.1;
T_stop = 50;

k1 = 1.554e-7; % 3.4*10^-7 ����
k2 = 1.2e-5; % 1.9*10^-5 �����

lam1 = 0.6;
lam2 = 40;

T = zeros(1,n)+90; %������ �����������
time = 0;

for i = 1 : n
    r(i) = r0 + i*h;
end

rs(1) = r0 + r(1)/2;
for i = 2 : n
    rs(i) = (r(i-1)+r(i))/2;
end
rs(n+1) = (r(n)+R)/2; 

while T(50) > T_stop
    To = T;
    for i = 1 : (n+1)/2 - 1
    a(i) = rs(i) / r(i) * (k1/h^2) ; % ������� � () ��� �(�-1)
    c(i) = rs(i+1)/ r(i) * (k1/h^2) ; % ....() ��� �(�+1)
    b(i) = a(i) + c(i) + 1/dt ;% ....() ��� �(�)
    d(i) = -To(i)/dt ; % ������� ���� ������������ �� = "�"" +- �" +-� = ..."
    end
    
    for i = (n+1)/2 + 1  : n
    a(i) = rs(i) / r(i) * (k2/h^2) ; % ������� � () ��� �(�-1)
    c(i) = rs(i+1)/ r(i) * (k2/h^2) ; % ....() ��� �(�+1)
    b(i) = a(i) + c(i) + 1/dt ;% ....() ��� �(�)
    d(i) = -To(i)/dt ; % ������� ���� ������������ �� = "�"" +- �" +-� = ..."
    end
    
i = (n+1)/2;
a(i) = lam1; % ������� � () ��� �(�-1)
b(i) = lam1 + lam2;% ....() ��� �(�)
c(i) = lam2; % ....() ��� �(�+1)
d(i) = 0 ; % ������� ���� ������������ �� = "�"" +- �" +-� = ..."

    
    b(1) = b(1) - a(1); 
    a(1) = 0;
    
    d(n) = d(n) + c(n)*1; %������� �����������
    c(n) = 0;
    
    T = progonka(a, b, c, d);
    time = time + dt;
    plot(r,T,'r')
    grid on
    time
    l = time * v_v
end

