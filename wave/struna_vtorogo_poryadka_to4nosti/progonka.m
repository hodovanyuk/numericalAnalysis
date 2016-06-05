function x=progonka(a, b, c, d)
n=length(b);
p(1)=c(1)/b(1);
g(1)=-d(1)/b(1);
for i=2 : n
    p(i)=c(i)/(b(i)-a(i)*p(i-1));
    g(i)=(-d(i)+a(i)*g(i-1))/(b(i)-a(i)*p(i-1));
end
x(n)=g(n);
for i=n-1 : -1 : 1
    x(i)=p(i)*x(i+1)+g(i);
end