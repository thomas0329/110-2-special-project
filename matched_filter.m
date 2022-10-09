n = -10:10;
pattern_0 = zeros([1,21]);
pattern_1 = ones([1,21]);
pattern_2 = n/10;
pattern_3 = (-1)*n/10;
n = linspace(0,2*pi,21);
pattern_4 = sin(n);
x = [pattern_0,pattern_1,pattern_0,pattern_2,pattern_0,pattern_3,pattern_0,pattern_4,pattern_0];
n = 0:length(x)-1;
figure(1);
plot(n,x);
title('x');
xlabel('n');

h = pattern_2;
%{
y = conv(x,h(end:-1:1),'full');
y = y(end-(length(x)-1):end);
%}
% correction
y = conv(x,h(end:-1:1),'same');

figure(2);
plot(n,y)
title('y');
xlabel('n');

% normalization form
%{

sum_h_square = sum(h.^2,'all');
sum_x_square = zeros([1,length(x)-1+tau2+1]);
sum_x = zeros([1,length(x)-1+tau2+1]);  % for normalization and offset form

for s = 1:tau2-tau1+1
    sum_x_square(s:s+length(x)-1) = sum_x_square(s:s+length(x)-1) + x.^2;
    sum_x(s:s+length(x)-1) = sum_x(s:s+length(x)-1) + x;
end
sum_x_square = sum_x_square(end-(length(x)-1):end);
denom = (sum_x_square*sum_h_square).^(1/2);
x0 = sum_x/(tau2-tau1+1);   % for normalization and offset form

for i = 1:length(y)
    if denom(i) ~= 0
        y(i) = y(i)/denom(i);
    else
        y(i) = 0;
    end
end
figure(3);
plot(n,y);
title('y (normalization form)');
xlabel('n');
%}
% correction
tau1 = 0;
tau2 = 20;

y = conv(x,h(end:-1:1),'same');

sum_x_square = conv(x.^2,ones(1,tau2-tau1+1),'same');
sum_h_square = sum(h.^2,'all');
denom = (sum_x_square*sum_h_square).^(1/2);
%x0 = sum_x/(tau2-tau1+1);   % for normalization and offset form

for i = 1:length(y)
    if denom(i) ~= 0
        y(i) = y(i)/denom(i);
    else
        y(i) = 0;
    end
end
figure(4);
plot(n,y);
title('y (normalization form with conv)');
xlabel('n');


% normalization and offset form
%{
sum_x1_square = zeros([1,length(x)-1+tau2+1]);

for s = 1:tau2-tau1+1
    extended_xs = zeros([1,length(x)-1+tau2+1]);
    extended_xs(s:s+length(x)-1) = x;
    sum_x1_square = sum_x1_square + (extended_xs-x0).^2;
end

sum_x1_square = sum_x1_square(end-(length(x)-1):end);
mean_h = sum(h,'all')/(tau2-tau1+1);
sum_h1_square = sum((h-mean_h*ones(length(h))).^2,'all');
denom = (sum_x1_square*sum_h1_square).^(1/2);

h1 = h - mean_h*ones([1,length(h)]);
y = conv(x,h1(end:-1:1),'full');
y = y(end-(length(x)-1):end);

for i = 1:length(y)
    if denom(i) ~= 0
        y(i) = y(i)/denom(i);
    else
        y(i) = 0;
    end
end
figure(5);
plot(n,y);
title('y (normalization offset form)');
xlabel('n');
%}
% correction
mean_h = sum(h,'all')/(tau2-tau1+1);
h1 = h - mean_h*ones([1,length(h)]);
y = conv(x,h1(end:-1:1),'same');
sum_x = conv(x,ones([1,tau2-tau1+1]),'same');
sum_h1_square = sum((h-mean_h*ones(length(h))).^2,'all');
sum_x1_square = sum_x_square - (tau2-tau1+1)*((sum_x/(tau2-tau1+1)).^2);
denom = (sum_x1_square*sum_h1_square).^(1/2);

for i = 1:length(y)
    if denom(i) ~= 0
        y(i) = y(i)/denom(i);
    else
        y(i) = 0;
    end
end
figure(6);
plot(n,y);
title('y (normalization offset form (conv))');
xlabel('n');







