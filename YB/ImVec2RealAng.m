function out = ImVec2RealAng(V)

out = atand(-V(1)/V(2));  % Find that vector's angle
        
if V(2)<0
    out = out+180;              % correct it if it's in quadrant 3 or 4
end

end