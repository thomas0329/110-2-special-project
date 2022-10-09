% operation to perform
erode = 0;
dilate = 0;
opening = 1;
closing = 0;

%read image
if closing == 1 | dilate == 1
    im = double(imread('Pic/binary_img/binary (23).gif'));
elseif opening == 1 | erode == 1
    im = double(imread('Pic/binary_img/binary (2)-2.bmp'));
end

%show image
figure(1);
image(im);
colormap(gray(256));

if erode == 1
    im = erosion(im);
    im = erosion(im);
    im = erosion(im);
end

if dilate == 1
    im = dilation(im);
    im = dilation(im);
    im = dilation(im);
end

if opening == 1
    im = erosion(im);
    im = erosion(im);
    im = erosion(im);
    im = dilation(im);
    im = dilation(im);
    im = dilation(im);
end

if closing == 1
    im = dilation(im);
    im = dilation(im);
    im = dilation(im);
    im = erosion(im);
    im = erosion(im);
    im = erosion(im);
end
%show image

figure(2);
image(im);
colormap(gray(256));

function im_out = erosion(im_in)
    im_in = im_in([1,1:end,end],[1,1:end,end]);
    sz = size(im_in)
    M = sz(1);
    N = sz(2);
    im_out = zeros([M,N]);

    for i = 2:M-1
        for j = 2:N-1
            %{
            if i ~= 1
                im(i,j) = im(i,j) & im(i-1,j);
            end
            if i ~= M
                im(i,j) = im(i,j) & im(i+1,j);
            end
            if j ~= 1
                im(i,j) = im(i,j) & im(i,j-1);
            end
            if j ~= N
                im(i,j) = im(i,j) & im(i,j+1);
            end
            %}
            
            im_out(i,j) = min([im_in(i,j),im_in(i-1,j),im_in(i,j-1),im_in(i+1,j),im_in(i,j+1)]);
            
        end
    end
    im_out=im_out([2:end-1],[2:end-1]);
    
end

function im_out = dilation(im_in)
    im_in=im_in([1,1:end,end],[1,1:end,end]);
    sz = size(im_in);
    M = sz(1);
    N = sz(2);
    im_out = zeros([M,N]);

    for i = 2:M-1
        for j = 2:N-1
            im_out(i,j) = max([im_in(i,j),im_in(i-1,j),im_in(i,j-1),im_in(i+1,j),im_in(i,j+1)]);
        end
    end
    im_out=im_out([2:end-1],[2:end-1]);
end
