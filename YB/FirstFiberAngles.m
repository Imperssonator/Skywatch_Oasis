function [] = FirstFiberAngles(SP)

load(SP)

Clean = IMS.Clean;
R = 7;              % Kernel radius
W = 1;              % Gaussian kernel width

Angles = AngleKernel(Clean,R,W);

IMS.Angles = Angles;

save(SP,'IMS')
disp('saved')

figure
pcolor(Angles.*180/pi + (Clean==0).*-120);
hc=colorbar; shading flat; axis equal; set(gca,'YDir','reverse');
colormap Jet;

end

function ANG = AngleKernel(Clean,R,W)
disp('running kernel')

[X, Y] = meshgrid(-R:R,-R:R);
Y = flip(Y,1);
% KG = (1 / 2*pi*W^2) * exp(-(X.^+Y.^2)./(2*W^2));    % Gaussian Kernel width W
KG = ones(2*R+1); KG(R+1,R+1) = 0;                  % Flat count kernel
KA = atan(Y./X);                                    % Angle Kernel
KA(R+1,R+1) = 0;

KAG = KA.*KG;                                       % Weighted Angle Kernel

AngleFilter = filter2(KAG,Clean);
WeightFilter = filter2(KG,Clean);

ANG = AngleFilter./WeightFilter;
ANG = ANG.*Clean;

end