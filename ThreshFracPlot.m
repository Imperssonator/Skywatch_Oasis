function [] = ThreshFracPlot(FP)

% FP = image file path string

IM = imread(FP);
[m,n,c] = size(IM);
IM = IM(:,:,1:3);
pix = m*n;

Fracs = zeros(100,1);

for i = 1:100
    BW = im2bw(IM,i/100);
    iFrac = sum(BW(:))/pix;
    Fracs(i) = iFrac;
end

figure
plot((1:100)./100,Fracs,'-b')

end
