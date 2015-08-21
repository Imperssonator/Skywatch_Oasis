function [] = OrientHist(SP,MinLength)

load(SP)
w = IMS.Dim;    % width of image in nm
Segments = IMS.Segments;

[m,n] = size(Segments);
pixdim = w/m;                               % size of a pixel in nm
MinSegmentPix = floor(MinLength/pixdim);    % Minimum segment length in pixels

RP = regionprops(Segments,'Area','Orientation');
Areas = [RP(:).Area];
Orient = [RP(:).Orientation];
Fibers = Areas>MinSegmentPix;

CleanAreas = Areas(Fibers);
CleanOrient = Orient(Fibers);

PixOrient = [];
for i = 1:length(CleanAreas)
    PixOrient = [PixOrient; ones(CleanAreas(i),1)*CleanOrient(i)];
end

figure
hist(PixOrient,40)
% Create ylabel
ylabel('Number of pixels');
% Create xlabel
xlabel('Angle off the horizontal (degrees)');
title(IMS.Name)
set(gca,'fontsize',18);


save(SP,'IMS')

% RP = regionprops(BW,'Area','Eccentricity','Orientation','Solidity','EulerNumber');    % Run regionprops, RP is a structure

end

