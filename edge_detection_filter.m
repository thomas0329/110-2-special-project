% an = 0.1, sigma = 100
% an = 1, sigma = 0.01
x = [zeros([1,20]),ones([1,31]),zeros([1,29]),ones([1,31]),zeros([1,20])];
an = 0.1;
noise = an*(rand(1,131)-0.5);
x1 = x + noise;
n = -30:100;
figure(1);
plot(n,x1);
title("x1[n]");
xlabel("n");

L = 10;
sigma = 100;
n = (-1)*L:L;
h = exp((-1)*sigma*abs(n));
sgn = [(-1)*ones([1,L]),zeros([1,1]),ones([1,L])];
h = sgn.*h;
C = 1/sum(h(end-(L-1):end),"all");
h = C*h;

y = conv(x1,h,"same");
n = -30:100;
figure(2);
plot(n,y);
title("y[n]");
xlabel("n");







