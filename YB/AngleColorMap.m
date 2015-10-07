function [] = AngleColorMap(SP)

load(SP)
load('JET')
figure
pcolor(IMS.AngMapNaN); shading flat; axis equal; set(gca,'YDir','reverse'); colormap(jet_wrap);

end