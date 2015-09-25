function [] = OrientMap(Gdir,Clean)

figure

pcolor(Gdir.*double(Clean) + double(~Clean).*-400);
hc=colorbar; shading flat; axis equal; set(gca,'YDir','reverse');

end