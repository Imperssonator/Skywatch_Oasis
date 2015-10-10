function SP = YBSeg(File,Dim)

%YBSeg Yanowitz-Bruckstein image segmentation with fiber unentanglement
%   SP is the structure path
%   File is the file path from current active dir
%   Dim is the image dimension in nm

%% Preprocessing

DotInd = FindLastDot(File);         % Last dot in filename before extension
SP = [File(1:DotInd-1) '.mat'];     % For example, '5um.tif' -> '5um'

IMS = struct();                     % Image structure
IMS.File = File;                    % Save filename in structure
IMS.Name = SP;                      % Save image name in structure
IMS.Dim = Dim;                      % Save image edge size      

IM = imread(File);
if ndims(IM)>2
    IMG = IM(:,:,1:3);              % Remove any alpha channels from tifs
else
    IMG = IM;
end
IMS.IMG = IMG;                      % save actual image in structure
imtool(IMG)

if ndims(IM)>2
    G = rgb2gray(IMG);              % If it's still color, make it grey
else
    G = IM;                         % Otherwise Gray = the image
end
IMS.Gray = G;                       % Store in structure

%% Segmentation

E = edge(G,'canny');                % Apply a Canny edge finder - 1's at the edges, 0's elsewhere
Gd = double(G);                     % Turn the grey image into double prec.
Ed = double(E);                     % Turn the edge image into double prec.
V0 = Gd.*Ed;                        % Fill in the grey values of the edge pixels in a new image file
IMS.Edge = E;                       

Vf = YBiter(V0);                    % Perform Yanowitz-Bruckstein surface interpolation to create threshold surface from edge gray values
IMS.ThreshSurf = uint8(Vf);         % Save the threshold surface

BW = G>Vf;                          % Segment the image; pixels above threshold surface are white, if not, black
IMS.BW = BW;

save(SP,'IMS')

MinLength = 150;                    % Minimum length of skeleton segment to be considered fibrilar (in nm)
MinArea = 2000;                     % Minimum area of connected component to be considered a fiber (in nm^2)

%% Cleaning and Skeletonizing

% YBClean(SP,MinArea);                % Remove 'fibers' whose area is less than 6E-5 * total image area
% Skeletonize(SP);                    % Generate a skeleton image
% Branches(SP);                       % Find branch points
% Segments(SP);                       % Dilate branch points and remove them from skeleton
%OrientHist(SP,MinLength);           % Generate histogram of skeleton pixel orientations

%% Finding Fiber Lengths

% FiberLengths(SP);                   % Generate a structure array, IMS.F, describing all of the fibers in the image
% FiberPlot(SP);
%LengthHist(SP);
% FirstFiberAngles(SP);               % Estimate angles off horizontal of segmented fiber pixels
% FillAmorphousAngles(SP);            % Interpolate angles between existing fibers


end