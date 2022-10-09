x = double(imread('../Pic/FreshFruitVegetablegray.jpg'));

figure(1);
image(x);
colormap(gray(256));
title('original image');

theta = pi/6;
rotation_matrix = [cos(theta),sin(theta);(-1)*sin(theta),cos(theta)];
shearing_matrix = [1 0;0.3 1];

y = affine_transformation(x,rotation_matrix);

figure(2);
image(y);
colormap(gray(256));
title('rotation');

y = affine_transformation(x,shearing_matrix);

figure(3);
image(y);
colormap(gray(256));
title('shearing');

function y = affine_transformation(x,matrix)

    sz = size(x);
    M = sz(1);
    N = sz(2);
    [n2, m2] = meshgrid([1:N],[1:M]);
    cm = ceil(M/2);
    cn = ceil(N/2);
    m1 = zeros(M,N);
    n1 = zeros(M,N);
    
    for m = 1:M
        for n = 1:N
            m1_n1 = (inv(matrix))*[m2(m,n)-cm,n2(m,n)-cn].' + [cm,cn].';
            m1(m,n) = m1_n1(1);
            n1(m,n) = m1_n1(2);
        end
    end

    y = zeros(M,N);
    for m = 1:M
        for n = 1:N
            % y[m2, n2] = x[m1, n1]
            m0 = floor(m1(m,n));
            n0 = floor(n1(m,n));
            a = m1(m,n) - m0;
            b = n1(m,n) - n0;
            if 1 <= n1(m,n) && n1(m,n) <= N && 1 <= m1(m,n) && m1(m,n) <= M
                if m0+1 == M+1 && n0 < N
                    y(m,n) = (1-a)*(1-b)*x(m0,n0) + a*(1-b)*x(m0,n0) + (1-a)*b*x(m0,n0+1) + a*b*x(m0,n0+1);
                elseif n0+1 == N+1 && m0 < M
                    y(m,n) = (1-a)*(1-b)*x(m0,n0) + a*(1-b)*x(m0+1,n0) + (1-a)*b*x(m0,n0) + a*b*x(m0+1,n0);
                elseif m0+1 == M+1 && n0+1 == N+1
                    y(m,n) = (1-a)*(1-b)*x(m0,n0) + a*(1-b)*x(m0,n0) + (1-a)*b*x(m0,n0) + a*b*x(m0,n0);
                else
                    y(m,n) = (1-a)*(1-b)*x(m0,n0) + a*(1-b)*x(m0+1,n0) + (1-a)*b*x(m0,n0+1) + a*b*x(m0+1,n0+1);
                end
            else
                y(m,n) = 0;
            end
        end
    end

end






