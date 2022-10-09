im = double(imread('Pic/Penguin.jpg'));

%show image
figure(1);
image(im/255);
title('original image');

Y = 0.299*im(:,:,1) + 0.587*im(:,:,2) + 0.114*im(:,:,3);
Cb = -0.169*im(:,:,1) - 0.331*im(:,:,2) + 0.5*im(:,:,3);
Cr = 0.5*im(:,:,1) - 0.419*im(:,:,2) - 0.081*im(:,:,3);
alpha = 0.5;    % α<1: lighten, α>1: darken
Y0 = 255*((Y/255).^alpha);

%inverse transform
M = [0.299 0.587 0.114; -0.169 -0.331 0.5; 0.5 -0.419 -0.081];
inv_M = inv(M);
im(:,:,1) = Y0*inv_M(1,1) + Cb*inv_M(1,2) + Cr*inv_M(1,3);
im(:,:,2) = Y0*inv_M(2,1) + Cb*inv_M(2,2) + Cr*inv_M(2,3);
im(:,:,3) = Y0*inv_M(3,1) + Cb*inv_M(3,2) + Cr*inv_M(3,3);

%show image
figure(2);
image(im/255);
title('lighten/darken image');

