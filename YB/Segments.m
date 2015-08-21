function [] = Segments(SP)

load(SP)
Skel = IMS.Skel;
Branch = IMS.Branch;
BranchDil = imdilate(Branch,ones(3));
Seg = Skel.*(BranchDil==0);
Seg = Seg==1;
IMS.BranchDil = BranchDil;
IMS.Segments = Seg;
% imtool(Seg)

save(SP,'IMS')

% RP = regionprops(BW,'Area','Eccentricity','Orientation','Solidity','EulerNumber');    % Run regionprops, RP is a structure

end