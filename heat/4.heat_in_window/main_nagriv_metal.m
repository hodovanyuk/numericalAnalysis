%������ ������� �� ������
clc
clear all
n = 101;
x0 = 0;
x1 = 1;
h = (x1-x0)/(n + 1);
dt=0.01;
k1 = 10;
k2 = 30;
lam1 = 1;
lam2 = 5;


T=zeros(1,n);
time=0;

for i = 1 : n
    x(i) = x0 + i*h;
end

for s = 1 : 100
To=T;
for i = 1 : ((n+1)/2) - 1
    a(i) = k1/h^2 ; % ������� � () ��� �(�-1)
    b(i) = 2*k1/h^2 + 1/dt ;% ....() ��� �(�)
    c(i) = k1/h^2 ; % ....() ��� �(�+1)
    d(i) = -To(i)/dt ; % ������� ���� ������������ �� = "�"" +- �" +-� = ..."
end

for i = ((n+1)/2) + 1 : n
    a(i) = k2/h^2 ; % ������� � () ��� �(�-1)
    b(i) = 2*k2/h^2 + 1/dt ;% ....() ��� �(�)
    c(i) = k2/h^2 ; % ....() ��� �(�+1)
    d(i) = -To(i)/dt ; % ������� ���� ������������ �� = "�"" +- �" +-� = ..."
end
i = (n + 1)/2;
a(i) = lam1; % ������� � () ��� �(�-1)
b(i) = lam1 + lam2;% ....() ��� �(�)
c(i) = lam2; % ....() ��� �(�+1)
d(i) = 0 ; % ������� ���� ������������ �� = "�"" +- �" +-� = ..."


d(1) = d(1) - a(1)*0;% �������� ������� � ������� ������ ��������� �����
a(1) = 0;

d(n) = d(n) - c(n)*1;
c(n) = 0;

hold on
T = progonka(a, b, c, d);
time = time + dt;

plot(x,T,'r')
grid on
end
time
T(30)