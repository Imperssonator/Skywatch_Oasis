function out = AngleDiff(A1,A2)

% AngleDiff finds the absolute value of the "angular distance" between two
% angles in degrees. In this function, AngleDiff(-89, 270) = 1, for example.

Reps = [abs(A1-A2),...
        abs(A1+360-A2),...
        abs(A1-(A2+360))];
    
out = min(Reps);

end