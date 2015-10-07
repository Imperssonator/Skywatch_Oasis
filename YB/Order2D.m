function [D Sd] = Order2D(SP)

load(SP)
dim = IMS.Dim;
AM = IMS.AngMap;
[m n] = size(AM);
% We would like to calculate the 2D local orientational order parameter
% (LOOP) at a series of wider length scales, so that we can fit its decay.
% So we will calculate S from 1 nm to 2000 nm using a log scale (more
% points towards the low lengths)

D = 2.^[0 1 2 3 4 5 6 7 8 9 10];
Dpix = D*m/dim;
Sd = zeros(length(Dpix),1);

count = 0;
for d = Dpix
    count = count+1
    [Si, Dir] = qTensorEmbed(AM,d);
    Sd(count) = sum(sum(Si))/(m*n);
end

IMS.D = D;
IMS.Sd = Sd;
save(SP,'IMS')

figure
plot(D,Sd,'ob')

end


function [S,Dir]=qTensorEmbed(AM,sz)
% [S,Dir]=qTensor(st,sz)
% This function takes in the structure tensor orientation and gaussian filter sigma. It
% then constructs the tensor order paramter by averaging over the disk
% filter. The determinent for each pixel is returned in S and the
% orientation of the order paramter is returned in Dir.
%
% INPUTS
% st - structure tensor orientation. double image of angles anywhere from
% -90 to +360
% sz - sigma of gaussian filter to be applied.
%
% OUTPUTS
% S - scalar alignment parameter. For 2D this is <cos^2(theta)-1/2>, where
%   theta is the angle between the director and a nematogen. This is the max
%   eigenvalue of the tensor order parameter
% Dir - the director. This is the orientation of the eigenvector associated
%   with S over the range [0, pi].

st = AM;

st(st<=0)=st(st<=0)+180;
st(st>180)=st(st>180)-180;
st = st*pi/180;


filt = fspecial('disk',sz); %create the filter
D11 = imfilter(cos(st).^2,filt,'conv'); %construct the tensor order parameter for every pixel
D12 = imfilter(cos(st).*sin(st),filt,'conv');
D22 = imfilter(sin(st).^2,filt,'conv');

% Use gaussian?
% D11 = imgaussfilt(cos(st).^2,sz); %construct the tensor order parameter for every pixel
% D12 = imgaussfilt(cos(st).*sin(st),sz);
% D22 = imgaussfilt(sin(st).^2,sz);

S = zeros(size(st)); %array to hold the value of S
Dir = zeros(size(st)); %array to hold the director orientation

for ind = 1:(size(st,1)*size(st,2))
    [evecs,evals] = eig([D11(ind)-1/2,D12(ind);D12(ind),D22(ind)-1/2]); %find evals/evecs of tensor order parameter
    if evals(1)>evals(4)
        S(ind) = 2*evals(1); %place 
        Dir(ind) = atan2(evecs(2),evecs(1)); %place director orientation 
    else
        S(ind) = 2*evals(4); %place S
        Dir(ind) = atan2(evecs(4),evecs(3));
    end  
end
Dir(Dir<=0)=Dir(Dir<=0)+pi; %fold the orientation values from[-pi,pi] to (0,pi]
Dir = Dir/pi; %map the orientation from (0,pi] to (0,1].

end