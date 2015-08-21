function out = LAP_C(V,L,i,j)

out = 0;

if i == 1 && j == 1

    for k = 0:1
        for l = 0:1
            out = out + ...
                  L(k+2,l+2) * V(i+k,j+l);
        end
    end

elseif i == 1 && j ~= 1
    
    for k = 0:1
        for l = -1:0
            out = out + ...
                  L(k+2,l+2) * V(i+k,j+l);
        end
    end
    
elseif i ~= 1 && j == 1
    
    for k = -1:0
        for l = 0:1
            out = out + ...
                  L(k+2,l+2) * V(i+k,j+l);
        end
    end
    
else
    
    for k = -1:0
        for l = -1:0
            out = out + ...
                  L(k+2,l+2) * V(i+k,j+l);
        end
    end
    
end

end