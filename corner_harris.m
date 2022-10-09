I = double(imread('../Pic/1.gif'));

figure(1);
image(I);
colormap(gray(256));
title('original image');

X = conv2(I,[-1,0,1],'same');
Y = conv2(I,[-1,0,1]','same');

sigma = 2;
temp = exp([-3:3].^2)';
w = (temp*temp').^((-1)/(2*sigma^2));

% why elementwise mutiplication?
A = conv2(X.^2,w,'same');
B = conv2(Y.^2,w,'same');
C = conv2(X.*Y,w,'same');

k = 0.05;
R = A.*B - C.^2 - k*(A+B).^2;

% 最外圈將偵測不到corner
R = R([1,1:end,end],[1,1:end,end]);
sz = size(R);
M = sz(1);
N = sz(2);

for m = 2:M-1
    for n = 2:N-1

        if (R(m,n) > max(R,[],'all')*0.01) && (R(m,n) > R(m,n-1)) && R(m,n) > R(m,n+1) && R(m,n) > R(m-1,n) && R(m,n) > R(m+1,n) && R(m,n) > R(m-1,n-1) && R(m,n) > R(m-1,n+1) && R(m,n) > R(m+1,n-1) && R(m,n) > R(m+1,n+1)
            % corner
            I(m-1,n-1) = 256;
        elseif R(m,n) < 0
            % edge
            %I(m-1,n-1) = 0;
        else
            % flat
        end
        
    end
end

%show image
figure(2);
image(I);
colormap(gray(256));
title('corner detection');










