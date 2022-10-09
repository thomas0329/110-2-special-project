N = 5;

f = zeros([N,11]);
for i = 1:5
    f(i,:) = [0:10].^(i-1);
end

phi = zeros([N,11]);
phi(1,:) = f(1,:)/sum(f(1,:).*f(1,:))^(1/2);

for a = 2:5
    sigma = zeros([1,11]);
    for m = 1:a-1
        sigma = sigma + sum(f(a,:).*phi(m,:))*phi(m,:);
    end
    g = f(a,:) - sigma;
    %phi(a,:) = g/((sum(g.*g))^(1/2));
    phi(a,:) = g/norm(g);
end

disp("phi = ");
disp(phi);






