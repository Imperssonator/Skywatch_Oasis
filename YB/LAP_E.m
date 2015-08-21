function out = LAP_E(V,L,i,j)

[m,n] = size(V);
out = 0;

if i == 1

    for k = 0:1
        for l = -1:1
            out = out + ...
                  L(k+2,l+2) * V(i+k,j+l);
        end
    end

elseif i == m
    
    for k = -1:0
        for l = -1:1
            out = out + ...
                  L(k+2,l+2) * V(i+k,j+l);
        end
    end
    
elseif j == 1
    
    for k = -1:1
        for l = 0:1
            out = out + ...
                  L(k+2,l+2) * V(i+k,j+l);
        end
    end
    
else
    
    for k = -1:1
        for l = -1:0
            out = out + ...
                  L(k+2,l+2) * V(i+k,j+l);
        end
    end
    
end

end