function [] = Fingerprint(SP)

load(SP)
G = IMS.Gray;
% M = mean(double(G(:)));
% Var = std(double(G(:)));
% GNorm = (G-M)/Var;
% G100 = GNorm*1+0;
% 
% imtool(G100)
[Gx, Gy] = imgradientxy(G,'prewitt');
[Gmag, Gdir] = imgradient(Gx, Gy);
IMS.Gx = Gx;
IMS.Gy = Gy;
IMS.Gdir = Gdir;
% imtool(Gmag/max(max(Gmag)))
% imtool((Gdir+180)/360)

Clean = IMS.Clean;
FibGrad = Gdir.*double(Clean);
OrientMap(Gdir,Clean)

save(SP,'IMS')

% L=40;W=8;
% Fibrility = FibrilityFilter(SP,L,W);

end
