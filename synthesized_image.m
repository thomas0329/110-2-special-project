im1 = double(imread('Pic/TIFFANY.BMP'));
im2 = double(imread('Pic/LENA.BMP'));

%show image
figure(1);
image(im1);
colormap(gray(256));

figure(2);
image(im2);
colormap(gray(256));

sz1 = size(im1)
sz2 = size(im2)
M = sz1(1);
N = sz1(2);

F1 = fft2(im1);
F2 = fft2(im2);

lowpass_fil = zeros([M,N]);
t = N/10;
for p = 0:M-1
    for q = 0:N-1
        if p+q <= t | p+q >= N+M-t | p-q <= t-N | p-q >= M-t
            lowpass_fil(p+1,q+1) = 1;
        else
            lowpass_fil(p+1,q+1) = 0;
        end
    end
end
highpass_fil = ~lowpass_fil;

F1 = F1.*lowpass_fil;
F2 = F2.*highpass_fil;
im1 = ifft2(F1);
im2 = ifft2(F2);

figure(4);
image(abs(im1));
colormap(gray(256));

figure(5);
image(abs(im2));
colormap(gray(256));

F = F1+F2;
im = ifft2(F);

%show image

figure(3);
image(abs(im));
colormap(gray(256));

title('synthesized image');




