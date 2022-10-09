g1 = [2 -1 3];
g2 = [-1 3 5];
g3 = [0 2 4];
g4 = [4 -2 -1];
g5 = [1 0 4];
g6 = [-2 5 5];

A = [g1;g2;g3;g4;g5;g6];
f = mean(A,1);
mean_mat = repmat(f,6,1);


A = A - mean_mat;
[U1,S1,V1] = svd(A);
[U2,S2,V2] = my_svd(A);

% h = 2

A = S1(1,1)*U1(:,1)*V1(:,1).' + S1(2,2)*U1(:,2)*V1(:,2).' + mean_mat
A = S2(1,1)*U2(:,1)*V2(:,1).' + S2(2,2)*U2(:,2)*V2(:,2).' + mean_mat

function [U,S,V] = my_svd(A)

    B = A'*A;
    C = A*A';
    [V,D] = eig(B);
    [U,L] = eig(C);

    U = U(:,end:(-1):1);
    V = V(:,end:(-1):1);
    %[VB,DB,V] = eig(B)
    %[VC,DC,U] = eig(C)
    S1 = U'*A*V;
    for i = 1:min(size(S1))
        if S1(i,i) < 0
            U(:,i) = (-1)*U(:,i);
        end
    end
    S = abs(S1);
end


