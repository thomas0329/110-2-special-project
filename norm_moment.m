% let the size of the image be 512 x 512
x0 = 256;
y0 = 256;
rx = 200;
ry = 100;

%ellipse = zeros([512,512]);

[nx, ny] = meshgrid([0:511],[0:511]);
ellipse = ((nx-x0).^2/rx^2 + (ny-y0).^2/ry^2 <= 1)*256;

L0_norm = sum((nx-x0).^2/rx^2 + (ny-y0).^2/ry^2 <= 1, "all");
%numertor_nx_bar = 0;
%numertor_ny_bar = 0;

%{
for nx = 1:512
    for ny = 1:512
        if (nx-x0)^2/rx^2 + (ny-y0)^2/ry^2 <= 1
            ellipse(nx,ny) = 256;
            L0_norm = L0_norm + 1;
            numertor_nx_bar = numertor_nx_bar + (nx-1)*ellipse(nx,ny);
            numertor_ny_bar = numertor_ny_bar + (ny-1)*ellipse(nx,ny);
        end
    end
end
%}

figure(1);
image(ellipse);
colormap(gray(256));
title("ellipse")

numerator_nx_bar = sum(ellipse.*nx,'all');
numerator_ny_bar = sum(ellipse.*ny,'all');

disp('L0_norm = ');
disp(L0_norm);
L1_norm = sum(abs(ellipse),'all')
L2_norm = (sum(ellipse.^2,'all'))^(1/2)
L_infinity_norm = max(abs(ellipse),[],'all')

nx_bar = numerator_nx_bar/(sum(ellipse,'all'));
ny_bar = numerator_ny_bar/(sum(ellipse,'all'));

m20 = sum(ellipse.*(nx-nx_bar).^2,'all')
m11 = sum(ellipse.*(nx-nx_bar).*(ny-ny_bar),'all')
m02 = sum(ellipse.*(ny-ny_bar).^2,'all')
%{
disp("m20 = ");
disp(m20);
disp("m11 = ");
disp(m11);
disp("m02 = ");
disp(m02);
%}
