function [] = MakeTifs()

load('Nabil')

for i = 1:length(Nabil)
    load(Nabil{i,2})
    Name = IMS.Name;
    LS = FindLastSlash(Name);
    FD = FindFirstDot(Name);
    ActName = Name(LS+1:FD-1);
    TifName = [ActName '.tif'];
    TifPath = ['~/Dropbox/Nabil/' TifName];
    imwrite(IMS.IMG,TifPath)
    IMS.Tif = TifPath;
    save(Nabil{i,2},'IMS')
end