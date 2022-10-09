clear
x = double(imread('../Pic/gray512/Village.gif'));
sz = size(x);
M = sz(1);
N = sz(2);
%show image
figure(1);
image(x);
colormap(gray(256));

title('original image');

% generate blurred image
L = 10;
k = zeros([2*L+1,2*L+1]);

% sum = 0;
% correction
gm = exp(-0.1*([-L:L].^2))';
gm = gm / sum(gm);
k = gm * gm';
% for m = (-1)*L:L
%     for n = (-1)*L:L
%         sum = sum + exp((-1)*0.1*(m^2+n^2));
%         k(m+L+1,n+L+1) = exp((-1)*0.1*(m^2+n^2));
%     end
% end
% s = 1/sum;
% k = k*s;

An = 10;
noise = An*(rand(M,N) - ones([M,N])*0.5);
y = conv2(x,k,'same') + noise;
Y = fft2(y);
%show image
figure(2);
image(y);
colormap(gray(256));
title('blurred image');


%equalizer
k1 = zeros([M,N]);

k1(1:L+1,1:L+1) = k(L+1:2*L+1,L+1:2*L+1);
k1(M-L+1:M,1:L+1) = k(1:L,L+1:2*L+1);
k1(1:L+1,N-L+1:N) = k(1+L:2*L+1,1:L);
k1(M-L+1:M,N-L+1:N) = k(1:L,1:L);

K = fft2(k1);
C = 0.01;

H = (C*((conj(K)).^(-1)) + K).^(-1);
x_hat = ifft2(Y.*H);

figure(3);
image(x_hat);
colormap(gray(256));
title('restored image');








