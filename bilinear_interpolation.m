x = double(imread('../Pic/FreshFruitVegetablegray.jpg'));

figure(1);
image(x);
colormap(gray(256));
title('original image');

sz = size(x);
M = sz(1);
N = sz(2);

y = zeros([round(1.5*M),round(1.6*N)]);
x = x([1,1:end,end],[1,1:end,end]);

for m = 1:round(1.5*M)
    for n = 1:round(1.6*N)
        % y[m, n] = x[m/1.5, n/1.6]
        m0 = floor(m/1.5);
        n0 = floor(n/1.6);
        a = m/1.5 - m0;
        b = n/1.6 - n0;
        y(m,n) = (1-a)*(1-b)*x(m0+1,n0+1) + a*(1-b)*x(m0+1+1,n0+1) + (1-a)*b*x(m0+1,n0+1+1) + a*b*x(m0+1+1,n0+1+1);
    end
end

figure(2);
image(y);
colormap(gray(256));
title('converted image');



