function [] = Branches(SP)

load(SP)
Skel = IMS.Skel;
Branch = bwmorph(Skel,'branchpoints');
IMS.Branch = Branch;
% imtool(Branch)

save(SP,'IMS')

% RP = regionprops(BW,'Area','Eccentricity','Orientation','Solidity','EulerNumber');    % Run regionprops, RP is a structure

end