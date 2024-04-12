n = 10;
cnt = 0;

for i = 1:n
    for j = 2:n
        for k = 2*j-1 : n
            cnt = cnt + 1;
        end
    end
end
cnt
mycnt = n/4*(n-1)^2