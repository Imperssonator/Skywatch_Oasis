function [] = AngleColorMapFull(SP)

load(SP)
load('JET')
figure
pcolor(IMS.AngMap); shading flat; axis equal; set(gca,'YDir','reverse'); colormap(jet_wrap);

end