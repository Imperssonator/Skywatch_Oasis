function out = ImVec2RealAng(V)

[out,~] = cart2pol(V(2),-V(1));     % Find that vector's angle
out = out*180/pi;                   % Convert to degrees

end