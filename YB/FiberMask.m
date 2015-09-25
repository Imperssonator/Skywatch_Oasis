function Mask = FiberMask(SP,W)

load(SP)

dim = IMS.Dim;
[m n] = size(IMS.Gray);
pixdim = dim/m;

FW = ceil(W/pixdim);

Mask = ones(FW*2,FW);

Mask = [zeros(FW*2,round(FW/2)) Mask zeros(FW*2,round(FW/2))];

[mm nn] = size(Mask);

Cen = floor(([mm nn]+1)/2); 

disp(Mask)

end