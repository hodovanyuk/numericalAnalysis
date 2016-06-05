% уравнение ѕуасона з условием Ќеимана с производнои
% теплопров≥дн≥сть(не готова прога)
clc
clear all
nx = 100;
ny = nx;
eps = 1.0e-5;
x_max = 2;
y_max = 1;
hx = x_max/nx;
hy = y_max/ny;
dt = 1.0e-5;

for i = 1:nx+1
    xx(i) = hx*(i-1); %дл€ построени€ рисунка координаты
end

for i = 1:ny+1
    yy(i) = hy*(i-1); %дл€ построени€ рисунка координаты
end

for i=2:nx+1
    for j=2:ny+1
        ax(i,j) = 1/hx^2;
        ay(i,j) = 1/hy^2;
        cx(i,j) = 1/hx^2;
        cy(i,j) = 1/hy^2;
        b(i,j) = -2*(1/hy^2)-2*(1/hx^2);
        d(i,j) = 1; % задает прогиб резины относительно рамки
    end
end

b(2,:) = b(2,:) + ax(2,:);  % производна€ по х = 0
d(2,:) = d(2,:) + ax(2,:)*hx; %производна€ по х = 1, если добавл€етс€ эта строка
ax(2,:) = 0;                % производна€ по х = 0

% for i = 10:10:nx+10
%     for j=10:10:ny+1
%         d(i,j) = 1;   % подн€ть на каждои 10 10 точке
%     end
% end

iter = 0;
max_iter = 1000;
err = 100;

U = zeros(nx+1,ny+1);
Ut = U(1,1);
while (iter < max_iter) && (err > eps)
    err = 0;
    for i = 2 : nx
        for j = 2 : ny
            U(i,j) = (d(i,j) - (ax(i,j)*U(i-1,j)+cx(i,j)*U(i+1,j)+ay(i,j)*U(i,j-1)+cy(i,j)*U(i,j+1)))/b(i,j);
            dev = abs(Ut - U(i,j))/(abs(U(i,j) + 1.0e-8));
            if dev > err
                err = dev;
            end
            Ut = U(i,j);
        end
    end
    iter = iter + 1;
end

U(1,:) = U(2,:); % обрезаем значени€ стенки (1,:), что бы не было стенки
    
figure;
%surf(U'); % если без введени€ осей
surf(xx,yy,U');