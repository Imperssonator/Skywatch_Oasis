function Nabil = Driver_Nabil()

%% Driver

FolderName = 'NK Son and Age';
DirectoryPath = 'NK Son and Age/';
ImDim = 5000;

D = CompileImgs(DirectoryPath);
disp(D)

Files = D;  %{D(:).path}';

NumFiles = length(Files);
Nabil = {};
disp('Files:')
disp(NumFiles)
% return

for i = 1:NumFiles
    disp(i)
    File = Files{i,1};
    disp(File)
    Nabil{i,1} = File;
    disp('Segmenting...')
    Nabil{i,2} = YBSimpleSeg(File,ImDim);        % need a way to deal with this 5000
    disp('Calculating Structure Tensor...')
    Coherence(Nabil{i,2});
%     qTensorNils(Nabil{i,2},10);                  % this 10 needs to be calculated from the 5000.. size issues...
end

save('Nabil','Nabil')
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