function Nabil = Driver_Nabil()

%% Driver

FolderName = 'NK Son and Age/48hr 10um';
DirectoryPath = 'NK Son and Age/48hr 10um/';

D = CompileImgs(DirectoryPath);
disp(D)

Files = D;  %{D(:).path}';

NumFiles = length(Files);
Nabil = {};

% return

for i = 1:NumFiles
    File = Files{i,1};
    disp(File)
    Nabil{i,1} = File;
    Nabil{i,2} = YBSeg(File,10000);
end

save('Nabil48hr','Nabil')
load(File)

end

function out = CompileImgs(FolderPath)
disp(FolderPath)

ad = pwd;

% First compile any images from the folderpath
cd(FolderPath)

PNG = dir('*.png');
JPG = dir('*.jpg');
JPEG = dir('*.jpeg');
CurIms = [PNG; JPG; JPEG]; % Generate directory structure of images in FolderPath
cd(ad)

CurImsCell = {};
for p = 1:length(CurIms)
    CurImsCell{p,1} = [FolderPath CurIms(p).name];   % prepend the folder path to the image names
end
out = CurImsCell;
disp(CurImsCell)

% Now search subdirectories further
cd(FolderPath)
SubDirs = FindAllSubDirs();     % Generate list of subdirectories
cd(ad)
if not(isempty(SubDirs))
    for j = 1:length(SubDirs)
        out = [out; CompileImgs([FolderPath SubDirs{j} '/'])];   % If not empty, also run for all subdirectories
    end
end
disp(out)

end

function out = FindAllSubDirs()

% Generate a cell array of the names of all subdirectories in the current
% directory

D = dir;

Names = {D(:).name};

out = {};

for i = 1:length(Names)
    if D(i).isdir
        Name = Names{i};
        if Name(1) ~= '.'
            out = [out; Name];
        end
    end
end

end