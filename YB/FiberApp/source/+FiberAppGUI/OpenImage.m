% Copyright (c) 2014, ETH Zurich (Switzerland)
% All rights reserved.
function OpenImage(hObject, eventdata)
FA = guidata(hObject);
% Open dialog for image selection
[fileName, filePath] = uigetfile({'*.*', 'NanoScope File (*.*)'; ...
    '*.tif; *.tiff', 'Image file (*.tif, *.tiff)'});
if isequal(fileName, 0); return; end % Cancel button pressed

% Read image data according to its extension
switch utility.getFileExtension(fileName)
    case {'tif', 'tiff'} % *.tif or *.tiff
        % Read an image and store it in memory
        im = int16(imread(fullfile(filePath, fileName)));
        % In case of 3 channels (rgb), convert into grayscale
        if size(im, 3) == 3
            im = int16(rgb2gray(im));
        end
        
        % Information about image with default values
        [sizeY, sizeX] = size(im);
        sizeX_nm = sizeX;
        sizeY_nm = sizeY;
        scaleXY = 1;
        scaleZ = 1;
        
    otherwise % NanoScope
        [im, sizeX, sizeY, sizeX_nm, sizeY_nm, scaleXY, scaleZ] = ...
            utility.readNanoScopeImage(filePath, fileName);
end

% Check the image reading process
if isempty(im); return; end

% Save image information
FA.name = fileName;
FA.path = filePath;
FA.im = im;
FA.sizeX = sizeX;
FA.sizeY = sizeY;
FA.sizeX_nm = sizeX_nm;
FA.sizeY_nm = sizeY_nm;
FA.scaleXY = scaleXY;
FA.scaleZ = scaleZ;

% Calculate suggested proper step for tracking algorithm
FA.step_nm = utility.round2n(3*FA.scaleXY);
FA.step = FA.step_nm/FA.scaleXY;

% Show image
set(gcf, 'Name', ['FiberApp - ' fullfile(filePath, fileName)]);
FA.updateImage();

FA.checkAccordance();

% Change a current folder
cd(filePath);

% Put main window in a focus
figure(gcf);

% FiberApp tutorial
switch utility.getFileExtension(fileName)
    case {'tif', 'tiff'} % *.tif or *.tiff
        FA.tutorial('open_tif_image');
        
    otherwise
        FA.tutorial('open_afm_image');
end

