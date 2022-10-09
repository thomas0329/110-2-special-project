% an = 1,sigma = 0.1
% an = 10,sigma = 0.1
n = -50:100;
x = 0.1*n;
an = 1;
noise = an*(rand(1,151)-0.5);
x1 = x + noise;
figure(1);
plot(n,x1);
title("x1[n]");
xlabel("n");

L = 10;
n = (-1)*L:L;
sigma = 0.1;
h = exp((-1)*sigma*abs(n));
C = 1/sum(h,"all");
h = C*h;

y = conv(x1,h,"same");
n = -50:100;
figure(2);
plot(n,y);
title("y[n]");
xlabel("n");

