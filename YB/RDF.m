function out = RDF(BW,h)

% Given a black and white image and the point C (i,j) from which to calculate
% RDF... generate vector 'out' with step size h.
% Radii can only be tested up to the size of mask that will fit in the
% image.
[ih iw] = size(BW);
out = zeros(round(ih/h),1);
r = 0;
C = find(BW(:)==1);              % linear indices of pixels that are black
NumSamps = 70;

iter = 0;
while r<ih/2
    iter=iter+1;
    r = r+h;
    Dr = zeros(NumSamps,1);
    CentCount = 0;
    for c = randperm(length(C),NumSamps); % We're not doing the RDF at every frickin pixel...
        CentCount = CentCount+1;
        [ci cj] = ind2sub([ih iw],C(c));
        mask = RingMask(ci,cj,iw,ih,r);
        try
            Dr(CentCount,1) = sum(sum(double(BW).*double(mask)))/sum(sum(mask));
        catch
            return
        end
    end
    out(iter,1) = mean(Dr);
end
figure
plot((1:length(out)),out','-b')
xlabel('Radius (pixels)')
ylabel('Probability')
title('Radial Distribution Function')

end
