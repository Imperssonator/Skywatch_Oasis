function FBY = FibrilityFilter(SP,L,W);

% L and W are integers please, the half length and half width of the filter

load(SP)

Gxu = IMS.Gx;
Gyu = IMS.Gy;
Gx = zeros(size(Gxu));
Gy = zeros(size(Gyu));
Gdir = IMS.Gdir;
dim = IMS.Dim;
[m n] = size(Gx);
lpix = ceil(L*m/dim);
wpix = ceil(W*m/dim);
disp('Normalizing Gradient...')
for i = 1:m
    for j = 1:n
        Gx(i,j) = Gxu(i,j)/sqrt(Gxu(i,j)^2+Gyu(i,j)^2);
        Gy(i,j) = Gyu(i,j)/sqrt(Gxu(i,j)^2+Gyu(i,j)^2);
    end
end

X = (0-wpix:0+wpix);
XG = normpdf(X,0,2);        % the third arg here may need to be changed, it's the variance
GFilt = repmat(XG,lpix*2,1);

FBY = zeros(m,n);

disp('Filtering...')

for i = 100:200
    for j = 275:375
%         tic
        GFiltRot = imrotate(GFilt,Gdir(i,j)+90);

        [GxSub,SubFilt] = PullSubIm(Gx,GFiltRot,i,j);
        [GySub,~] = PullSubIm(Gy,GFiltRot,i,j);

        [Fm Fn] = size(GxSub);

        GXij = ones(Fm,Fn).*Gx(i,j);
        GYij = ones(Fm,Fn).*Gy(i,j);
        FBY(i,j) = sum(sum(abs(SubFilt.*(GXij.*GxSub+GYij.*GySub))));
%         toc
%         [GdirSub,~] = PullSubIm(Gdir,GFiltRot,i,j);
%         [IMSub,~] = PullSubIm(IMS.IMG,GFiltRot,i,j);
%         imtool(IMSub)
%         imtool((GdirSub+180)/360)
%         disp(Gdir(i,j)+90)
%         
%         save('FDebug')

    end
end

IMG = IMS.IMG;
imtool(IMG(100:200,275:375,:))
imtool(FBY/max(max(FBY)))
IMS.Fibrility = FBY;
save(SP,'IMS')

end

function [SubImg,SubKern] = PullSubIm(FullIm,RotKern,EPi,EPj)

% This function basically has to take a rotated kernel, its starting point,
% and overlay it correctly with the right portion of the image, while
% accounting for the edges of the image. I have the details written on a
% piece of paper but it would be quite difficult to document this here. It
% works.

% It returns a list of indices of points that fall within the "field of
% view" of the end of a segment

[Km,Kn] = size(RotKern);
[Im,In] = size(FullIm);
RK = floor(([Km Kn]+1)/2);       % center of the filter
RKi = RK(1); RKj = RK(2);

Dt = RKi-1; Db = Km-RKi;
Dl = RKj-1; Dr = Kn-RKj;

IMt = max(1,EPi-Dt);
IMb = min(Im,EPi+Db);
IMl = max(1,EPj-Dl);
IMr = min(In,EPj+Dr);

Kt = RKi-(EPi-IMt);
Kb = RKi+(IMb-EPi);
Kl = RKj-(EPj-IMl);
Kr = RKj+(IMr-EPj);

SubKern = RotKern(Kt:Kb,Kl:Kr);
SubImg = FullIm(IMt:IMb,IMl:IMr);

end
        