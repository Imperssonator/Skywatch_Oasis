function [] = YBClean(SP,MinArea)

load(SP)
w = IMS.Dim;                            % width of image in nm
BW = IMS.BW;
[m,n] = size(BW);
pixdim = w/m;                           % size of a pixel in nm
pixarea = pixdim^2;
MinFiberPix = floor(MinArea/pixarea);   % Minimum area of fiber in pixels  

Clean = bwareaopen(BW,MinFiberPix,4);
IMS.Clean = Clean;
% imtool(Clean)

save(SP,'IMS')

% RP = regionprops(BW,'Area','Eccentricity','Orientation','Solidity','EulerNumber');    % Run regionprops, RP is a structure

end