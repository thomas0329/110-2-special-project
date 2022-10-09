%correction: use "sum", "mean"
x = double(imread('Pic/BABOON.BMP'));
y = double(imread('Pic/peppers256.bmp'));

disp("size of im1:");
disp(size(x));
disp("size of im2:");
disp(size(y));

%NRMSE_error = NRMSE(x,y)
%PSNR_error = PSNR(x,y)

NRMSE_error = (sum((y-x).^2,  'all')/sum(x.^2, 'all'))^0.5
PSNR_error = 10*log10(255.^2/mean((y-x).^2, 'all'))

function error = NRMSE(x,y)

    sz_x = size(x);
    sz_y = size(y);
    if size(sz_x,2) ~= 2 | size(sz_y,2) ~=2 | sz_x(1) ~= sz_y(1) | sz_x(2) ~= sz_y(2)
        disp('error: signal sizes are not compatible for NRMSE');
        error = NaN;
        return 
    end
    sz = size(x);
    M = sz(1);
    N = sz(2);
    num = 0;
    denom = 0;
    for m = 1:M
        for n = 1:N
            num = num + abs(y(m,n)-x(m,n))^2;
            denom = denom + abs(x(m,n))^2;
        end
    end
    error = (num/denom)^(1/2);
end

function error = PSNR(x,y)

    sz_x = size(x);
    sz_y = size(y);
    if size(sz_x,2) ~= size(sz_y,2) | sz_x(1) ~= sz_y(1) | sz_x(2) ~= sz_y(2)
        disp('error: image sizes are not compatible for PSNR');
        error = NaN;
        return
    end

    Xmax = 255;
    denom = 0;
    M = sz_x(1);
    N = sz_x(2);
    for m = 1:M
        for n = 1:N
            if size(sz_x,2) == 2
                denom = denom + abs(y(m,n)-x(m,n))^2;
            elseif size(sz_x,2) == 3
                for i = 1:3
                    denom = denom + abs(y(m,n,i)-x(m,n,i))^2;
                end
            end
        end
    end
    if size(sz_x,2) == 2
        denom = denom/(M*N);
    elseif size(sz_x,2) == 3
        denom = denom/(3*M*N);
    end
    error = 10*log10(Xmax^2/denom);
end