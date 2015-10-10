function [Coher, AngMap, JESort, JVSort] = CoherenceTEM(SP)

load(SP)
G = IMS.Gray;
BW = IMS.BW;
[m n] = size(G);
% InitGauss = m/1024*2;
GradGaussSig = 4;
Gauss = G;
% Gauss = imgaussfilt(G,InitGauss);
% imtool(Gauss)
% imtool(Gauss)
[GaussX, GaussY] = imgradientxy(G,'prewitt');
GaussGrad = zeros(m,n,2);
J = zeros(m,n,4);
J(:,:,1) = GaussX.*GaussX;
J(:,:,2) = GaussX.*GaussY;
J(:,:,3) = GaussX.*GaussY;
J(:,:,4) = GaussY.*GaussY;
JFilt = zeros(size(J));
for i = 1:4
    JFilt(:,:,i) = imgaussfilt(J(:,:,i),GradGaussSig);
end
JE = zeros(m,n,2);
JV = zeros(m,n,4);
for i = 1:m
    for j = 1:n
        [V,D] = eig(reshape(JFilt(i,j,:),[2 2]));
        JE(i,j,:) = diag(D);
        JV(i,j,:) = V(:);
    end
end
JESort = sort(JE,3,'descend');
JVSort = zeros(size(JV));
for i = 1:m
    for j = 1:n
        if JESort(i,j,1)~=JE(i,j,1)
            JVSort(i,j,:) = [JV(i,j,3) JV(i,j,4) JV(i,j,1) JV(i,j,2)];
        else
            JVSort(i,j,:) = JV(i,j,:);
        end
    end
end

% Coher = ((JESort(:,:,1)-JESort(:,:,2))./(JESort(:,:,1)+JESort(:,:,2))).^2;
AngMap = atan2d(-JVSort(:,:,1),JVSort(:,:,2));      % last evec is 'coherence orientation'
load('JET')
AngMapNaN = AngMap;
AngMapNaN(~BW)=NaN;
AngMapNaN(1,1) = 180; AngMapNaN(end,end) = -180;          % This is janky
AngMap(1,1) = 180; AngMap(end,end) = -180;          % This is janky
% figure
% pcolor(AngMapNaN); shading flat; axis equal; set(gca,'YDir','reverse'); colormap(jet_wrap);
% 
% imtool(mat2gray(Coher))

IMS.AngMap = AngMap;
IMS.AngMapNaN = AngMapNaN;
IMS.Gauss = Gauss;
IMS.J = J;
IMS.JFilt = JFilt;
IMS.JESort = JESort;
IMS.JVSort = JVSort;

save(SP,'IMS')

end