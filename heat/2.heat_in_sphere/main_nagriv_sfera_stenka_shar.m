%стена от сферы , прогрев сфер равномерный(воздушный шар)
clc
clear all
n = 100;
r0 = 0.8;
R = 1;
h = (R-r0)/(n + 1);
dt = 0.01;

T = zeros(1,n)+1;
time = 0;

for i = 1 : n
    r(i) = r0 + i*h;
end

rs(1) = r0 + r(1)/2;
for i = 2 : n
    rs(i) = (r(i-1)+r(i))/2;
end
rs(n+1) = (r(n)+R)/2; 

for step = 0 : 100
    To = T;
    for i = 1 : n
        a(i) = ((rs(i))^2) / (r(i))^2 * (1 / h^2); % y(i-1)
        c(i) = ((rs(i+1))^2) / (r(i))^2 * (1 / h^2); % y(i+1)
        b(i) = a(i) + c(i)+ 1/dt  ;% y(i)
        d(i) = - To(i) / dt; 
    end
    
    d(1) = d(1) + a(1)*0; %внутри температура
    a(1) = 0;
    
    d(n) = d(n) - c(n)*1; %снаружи температура
    c(n) = 0;
    
    T = progonka(a, b, c, d);
    time = time + dt;
    plot(r,T,'r')
    grid on
end