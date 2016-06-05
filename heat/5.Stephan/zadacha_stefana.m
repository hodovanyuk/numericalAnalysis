clear all
clc

X_left=0;
X_right=1;
n=150;
h=(X_right-X_left)/(n+1);
for i=1:n
    x(i)=i*h;
end

T_left=1;
T_right=-0.01;
T=ones(1,n)*T_right;

dt=0.00001;
time=0;

lambda_left=1;
k_left=4;
lambda_right=1;
k_right=1;
n_bound=1;

step_out=1;
n_out=0;

for step=1:2000
    time=time+dt;
    for i=1:n_bound-1
      a(i)=k_left/h^2;
      b(i)=2*k_left/h^2+1/dt;
      c(i)=k_left/h^2;
      d(i)=-T(i)/dt;
     end

    a(n_bound)=lambda_left/h; 
    c(n_bound)=lambda_right/h; 
    b(n_bound)=a(n_bound)+c(n_bound);
    d(n_bound)=0;

    for i=n_bound+1:n
      a(i)=k_right/h^2;
      b(i)=2*k_right/h^2+1/dt;
      c(i)=k_right/h^2;
      d(i)=-T(i)/dt;
     end
    d(1)=d(1)-a(1)*T_left;
    a(1)=0;
    d(n)=d(n)-c(n)*T_right;
    c(n)=0;
        
    T=progonka(a,b,c,d);
   
    j=n_bound;
    while (T(j+1)+T(j))/2 > 0 & j < n-1
        j=j+1;
    end;
    n_bound=j-1;
    n_out=n_out+1;
    time_out(n_out)=time;
    x_out(n_out)=x(n_bound);
end
%plot(T)
loglog(time_out,x_out,'r',time_out,6*time_out.^0.5,'b');