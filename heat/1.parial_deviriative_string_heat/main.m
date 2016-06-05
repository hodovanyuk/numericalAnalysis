%
clc
clear all
n = 100;
x0 = 0;
x1 = 1;
h = (x1-x0)/(n + 1);
dt=0.01;

T=zeros(1,n)
time=0;

for i = 1 : n
    x(i) = x0 + i*h;
end

for s = 1 : 100
To=T;
for i = 1 : n
    a(i) = 1/h^2; % елемент в () біля у(і-1)
    b(i) = 2/h^2 + 1/dt ;% ....() біля у(і)
    c(i) = 1/h^2; % ....() біля у(і+1)
    d(i) = -To(i)/dt; % функція після перетворення за = "у"" +- у" +-у = ..."
end

a(30) = 0;
b(30) = -1;
c(30) = 0;
d(30) = 0.3;


d(1) = d(1) - a(1)*0;% значення функції в заданих точках початкової умови
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