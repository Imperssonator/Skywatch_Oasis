function out = FillHoles(original,size)

% Fill all holes using imfill

filled = imfill(original, 'holes');

% Identify filled pixels using logical operators:

holes = filled & ~original;

% Use bwareaopen to eliminate connected components in the holes image 
% smaller than your threshold.

bigholes = bwareaopen(holes, size);

% Use logical operators to identify small holes:

smallholes = holes & ~bigholes;

% Use logical operator to fill in identified small holes:

out = original | smallholes;
end