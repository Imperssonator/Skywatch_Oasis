function [] = ThreshSeries(FP)

LastSlash = FindLastSlash(FP);
LastDot = FindLastDot(FP);
FileName = FP(LastSlash+1:LastDot-1);   % '5um'
Folder = [pwd '/' FP(1:LastDot-1) '/']; % Directory.... /My AFM/5um/
mkdir(Folder);
IM = imread(FP);
IM = IM(:,:,1:3);


for i = 0:0.1:0.9
    iBW = im2bw(IM,i);
    thresh = num2str(i);    % '0.1'
    BWname = [FileName ' ' thresh];
    imwrite(iBW,[Folder BWname '.tif'])
end

end