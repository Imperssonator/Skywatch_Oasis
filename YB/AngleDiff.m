function out = AngleDiff(A1,A2)

% AngleDiff finds the absolute value of the "angular distance" between two
% angles in degrees. In this function, AngleDiff(-89, 270) = 1, for example.

if A1 < 0
    A1 = 360+A1;
end

if A2 < 0
    A2 = 360+A2;
end

out = abs(A1-A2);

end