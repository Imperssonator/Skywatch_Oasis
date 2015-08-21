function out = LAP(V,L,i,j)

out = 0;

for k = -1:1
    for l = -1:1
        out = out +...
              L(k+2,l+2) * V(i+k,j+l);
    end
end

end