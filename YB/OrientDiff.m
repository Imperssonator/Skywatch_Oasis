function out = OrientDiff(A1,A2)

% AngleDiff finds the absolute value of the "angular distance" between two
% angles in degrees. These angles are orientations from regionprops and so
% vary between -90 and 90. The goal is to make 89-(-90) = 1

out = min(abs(A1-A2),AngleDiff(A1+180,A2));

end