nIter = 10000;
S = zeros(1,nIter);
for n = 2:nIter
    S(n) = S(n-1) + 10*randn;
end
n = 1:nIter;
comet(n,S);title('S');pause(3)
comet(n,S./n);title('S/n');pause(3)
comet(n,S./sqrt(n));title('S/sqrt(n)');pause(3)

