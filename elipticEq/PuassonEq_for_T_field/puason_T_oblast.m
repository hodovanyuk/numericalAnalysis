%рівняння Пуассона загальний випадок квадрат з умовами Діріхле

clc
clear all
nx = 40; % розмірність сітки по осі x
ny = 40; % розмірність сітки по осі y
eps = 0.0001;
x_max = 1;  % розмірність області по осі x
y_max = 1;  % розмірність області по осі y
hx = x_max/nx;   % крок по x
hy = y_max/ny;   % крок по y

for i = 1 : nx + 1
    xx(i) = hx*(i-1);   % координати xx для побудови графіка 
end
   
for i = 1 : ny + 1
   yy(i) = hy*(i-1);   % координати yy для побудови графіка 
end

% початкові умови для ax, cx, ay, cy, b, d
for i = 1 : nx
    for j = 1 : ny
        ax(i,j) = 1/hx^2;    
        cx(i,j) = 1/hx^2;
        ay(i,j) = 1/hy^2;
        cy(i,j) = 1/hy^2;
        b(i,j) = -(2/hx^2 + 2/hy^2);
        d(i,j) = 1;  % площина і в одній точці прогин
    end
end
% в яких точках робимо прогини чи випуклості
for i = 8*nx/10 : nx
    for j = 8*ny/10 : ny
        ax(i,j) = 0;    
        cx(i,j) = 0;
        ay(i,j) = 0;
        cy(i,j) = 0;
        b(i,j) = 1;
        d(i,j) = 0;  % площина і в одній точці прогин
    end
end
for i = 4*nx/10 : 7*nx/10
    for j = 3*ny/10 : 6*ny/10
        ax(i,j) = 0;    
        cx(i,j) = 0;
        ay(i,j) = 0;
        cy(i,j) = 0;
        b(i,j) = 1;
        d(i,j) = 0;  % площина і в одній точці прогин
    end
end
for i = 1 : 3*nx/10
    for j = 8*ny/10 : 10*ny/10
        ax(i,j) = 0;    
        cx(i,j) = 0;
        ay(i,j) = 0;
        cy(i,j) = 0;
        b(i,j) = 1;
        d(i,j) = 0;  % площина і в одній точці прогин
    end
end

U = zeros(nx + 1, ny +1);
x_t = U(1,1);
err = 100;
iter = 0;
max_iter = 100;

while (iter < max_iter) & (err > eps)
   iter = iter + 1;
   err = 0;
   dev = 0;
   for i = 2 : nx
      for j = 2 : ny
           % різницева схема
           x_t = ax(i,j)*U(i - 1,j) + cx(i,j)*U(i+1,j) + ay(i,j)*U(i,j-1) + cy(i,j)*U(i,j+1) - d(i,j);
           x_t = -x_t/b(i,j);
           dev = abs((U(i,j) - x_t)/(abs(x_t) + 1.0e-8)); % норма
           if dev > err
              err = dev;
           end
           U(i,j) = x_t; % U = x(i)
       end  
    end  
end
surf(xx,yy,U')   % побудова тривимірного графіка 