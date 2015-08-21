function [] = Skeletonize(SP)

load(SP)
Clean = IMS.Clean;
Skel = bwmorph(Clean,'skel',Inf);
IMS.Skel = Skel;
% imtool(Skel)

save(SP,'IMS')

% RP = regionprops(BW,'Area','Eccentricity','Orientation','Solidity','EulerNumber');    % Run regionprops, RP is a structure

end