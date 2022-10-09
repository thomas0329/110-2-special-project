x = [ones(1,51),zeros(1,50)];
n = 0:100;
figure(1);
plot(n,x);
title("x");

an = 0.2;
noise = an*(rand(1,101)-0.5);
y = x + noise;
figure(2);
plot(n,y);
title("y");

L = 15;
k1 = 0.1;
k2 = 5;
C = zeros(1,100+L-(-L)+1);  %C[n]
sigma = zeros(1,100+L-(-L)+1);

% i = n - m
for i = L:-1:-L
    left_endpoint = min(0,i);
    right_endpoint = max(100,100+i);
    difference_C = zeros(1,right_endpoint-left_endpoint+1);  %y[n] - y[m] while calculating C
    if i >= 0
        difference_C(1:101) = y;
        difference_C(end-100:end) = difference_C(end-100:end) + (-1)*y;
        difference_sigma = difference_C(end-100:end);   %y[n] - y[m] while calculating sigma
    else
        difference_C(end-100:end) = difference_C(end-100:end) + y;
        difference_C(1:101) = difference_C(1:101) + (-1)*y;
        difference_sigma = difference_C(1:101);
    end
    C(left_endpoint+1+L:right_endpoint+1+L) = C(left_endpoint+1+L:right_endpoint+1+L) + exp(-k1*i^2)*exp(-k2*(difference_C.^2));
    sigma(i+L+1:i+L+1+100) = sigma(i+L+1:i+L+1+100) + exp(-k1*i^2)*exp(-k2*(difference_sigma.^2)).*y;
end

C = C(1+L:1+L+100); %C[0:100]
C = C.^(-1);
sigma = sigma(1+L:1+L+100); %sigma[0:100]

x0 = C.*sigma;
figure(3);
plot(n,x0);
title("x0");

