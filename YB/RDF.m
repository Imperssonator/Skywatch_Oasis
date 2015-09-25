function out = RDF(BW,C,h)

% Given a black and white image and the point C (i,j) from which to calculate
% RDF... generate vector 'out' with step size h.
% Radii can only be tested up to the size of mask that will fit in the
% image.
[ih iw] = size(BW);
out = zeros(round(ih/h),1);
r = 0;
ci = C(1);
cj = C(2);
iter = 0;
while r<ih/2
    iter=iter+1;
    r = r+h;
    mask = RingMask(ci,cj,iw,ih,r);
    try
        out(iter,1) = sum(sum(double(BW).*double(mask)))/sum(sum(mask));
    catch
        return
    end
end
figure
plot((1:length(out)),out','-b')
xlabel('Radius (pixels)')
ylabel('Probability')
title('Radial Distribution Function')

end
