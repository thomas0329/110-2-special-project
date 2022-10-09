%畫x的頻譜
[x, fs] = audioread("BOING.WAV");

sz = size(x);
N = sz(1);
X = abs(fft(x));    %magnitude
m = [0:N-1];
figure(1);
plot(m,X);
title('DFT of x[n]')
xlabel('m');
ylabel('|X[m]|');

%disp(fs)
max_idx = floor(N/2);
f = [max_idx+1-N:max_idx]*fs/N;
Y = X*1/fs  %magnitude
temp1 = Y(1:max_idx+1);
temp2 = Y(max_idx+1+1:end);
Y = [temp2;temp1];
figure(2);
plot(f,Y);
title('FT of y(t)')
xlabel('f');
ylabel('|Y(f)|');







