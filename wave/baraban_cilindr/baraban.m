%барабан удар один по мембране
clc
clear all
n = 101;
r0 = 0;
R = 1;
h = (R - r0)/(n + 1);
dt = 0.1;
u_Left = 0;
u_Right = 0;
alf = 0.5;

T = zeros(1,n)+1;
time = 0;

for i = 1 : n
    r(i) = r0 + i*h;
end

rs(1) = r(1)/2;
for i = 2 : n
    rs(i) = (r(i-1)+r(i))/2;
end
rs(n+1) = (r(n)+R)/2;

% задаємио першу початкову умову (початкове положення мембрани барабана)
for i = 1 : n
     U00(i) = (1-r(i))*alf; % початкове положення мембрани (права частина мембрани - після перегину)
end

vel = zeros(1,n);  % початкова швидкість 
U0 = 1 - r;
U00 = U0;
time = 0; 

for step = 0 : 1000
    time = time + dt;
    for i = 1 : n
        a(i) = rs(i)  / r(i) * (1 / h^2); % y(i-1)
        c(i) = rs(i+1)/ r(i) * (1 / h^2); % y(i+1)
        b(i) = a(i) + c(i) + 1/dt^2  ;% y(i) 
    end
    
    for i = 1 : n
         d(i) = (-2*U0(i)+U00(i))/dt^2;
    end
    
    b(1) = b(1) - a(1);
    a(1) = 0;
    d(n) = d(n) - c(n)*u_Right;
    c(n) = 0;

    if mod(step,10)==0
    
    U = progonka(a, b, c, d);
    time = time + dt;
    U00 = U0;
    U0 = U;
    
    u_Left = U(1);
    plot(r,U)
    axis([0 1 -0.9 0.9]) % закрыплюэмо координати для "графіки" зображення
    pause(.001)          % затримка по часу виконання
    end 
end