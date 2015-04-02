function out = AFM2Bin(Dir,ImName,ImType,ImDim)
% Dir is the directory where the AFM folders are located
% StartPix is a 1x2 vector of integers where the simulation box should
% start
% Size is the size of the box edges in pixels

% Dir should be 'Tofet Files/'
% ImName should be '15%_2min'
% ImType '.tif' or '.jpg' or '.png'
% ImDim 2000 nm or 5000 nm... some number in nm
out = 0;

%% Generate File Locations
SubDir = [Dir ImName '/'];                  % Tofet Files/15%_2min/
ImFile = [SubDir ImName ImType];            % Tofet Files/15%_2min/15%_2min.tif
Binfile = [SubDir ImName '_Bin'];           % Tofet Files/15%_2min/15%_2min_Bin
% PixStr = mat2str(StartPix);                 % '[10 10]'
% PixStr = PixStr(2:end-1);                   % '10 10'
% SizeStr = mat2str(BoxSize);                    % '50'
% SizeName = [ImName '_' PixStr '_' SizeStr]; % '15%_2min_10 10_50'
% SizeDir = [SubDir SizeName '/']; % 'Tofet Files/15%_2min/15%_2min_10 10_50/'
% mkdir(SizeDir)

%% Cut the original bin to the specified size

disp('Segmenting')
disp(ImFile)
[SEGfile,ORIENT,MAXCONF] = Full_Seg2(ImFile);

disp('Binning')
bins=4;
[Binfile, MS] = Bin_Angles(SEGfile,bins);
[h,w,b] = size(MS);



end