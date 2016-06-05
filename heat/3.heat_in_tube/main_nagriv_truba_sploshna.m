%сплошна труба , прогрев трубы равномерный
clc
clear all
n = 100;
r0 = 0;
R = 1;
h = (R-r0)/(n + 1);
dt = 0.01;

T = zeros(1,n)+0; % +1 -- це додатня температура всередині
time = 0;

for i = 1 : n
    r(i) = r0 + i*h;
end

rs(1) = r(1)/2;
for i = 2 : n
    rs(i) = (r(i-1)+r(i))/2;
end
rs(n+1) = (r(n)+R)/2; 

for step = 0 : 100
    To = T;
    for i = 1 : n
        a(i) = rs(i)  / r(i) * (1 / h^2); % y(i-1)
        c(i) = rs(i+1)/ r(i) * (1 / h^2); % y(i+1)
        b(i) = a(i) + c(i)+ 1/dt  ;% y(i)
        d(i) = - To(i) / dt; 
    end
    
    %b(1) = b(1) - a(1);  % це додатня температура всередині
    %a(1) = 0;
    
    d(1) = d(1) + a(1)*0; %внутри температура
    a(1) = 0;
    d(n) = d(n) - c(n)*1; %снаружи температура
    
    %d(n) = d(n); це додатня температура всередині
    c(n) = 0;
    if mod(step,10)==0
    hold on
    T = progonka(a, b, c, d);
    time = time + dt;
    plot(r,T,'r')
    grid on
    end 
end
