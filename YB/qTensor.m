function [S,Dir]=qTensor(st,sz)
% [S,Dir]=qTensor(st,sz)
% This function takes in the structure tensor orientation and disk filter radius. It
% then constructs the tensor order paramter by averaging over the disk
% filter. The determinent for each pixel is returned in S and the
% orientation of the order paramter is returned in Dir.
%
% INPUTS
% st - structure tensor orientation. double image where the range [0,1] in
%   intensity is mapped to [0,pi] in orientation.
% sz - radius in px of the disk filter used to average over in creating the
%   tensor oder parameter.
%
% OUTPUTS
% S - scalar alignment parameter. For 2D this is <cos^2(theta)-1/2>, where
%   theta is the angle between the director and a nematogen. This is the max
%   eigenvalue of the tensor order parameter
% Dir - the director. This is the orientation of the eigenvector associated
%   with S over the range [0, pi].

filt = fspecial('disk',sz); %create the filter
D11 = imfilter(cos(st*pi).^2,filt,'conv'); %construct the tensor order parameter for every pixel
D12 = imfilter(cos(st*pi).*sin(st*pi),filt,'conv');
D22 = imfilter(sin(st*pi).^2,filt,'conv');

S = zeros(size(st)); %array to hold the value of S
Dir = zeros(size(st)); %array to hold the director orientation

for ind = 1:(size(st,1)*size(st,2))
    [evecs,evals] = eig([D11(ind)-1/2,D12(ind);D12(ind),D22(ind)-1/2]); %find evals/evecs of tensor order parameter
    if evals(1)>evals(4)
        S(ind) = evals(1); %place 
        Dir(ind) = atan2(evecs(2),evecs(1)); %place director orientation 
    else
        S(ind) = evals(4); %place S
        Dir(ind) = atan2(evecs(4),evecs(3));
    end  
end
Dir(Dir<=0)=Dir(Dir<=0)+pi; %fold the orientation values from[-pi,pi] to (0,pi]
Dir = Dir/pi; %map the orientation from (0,pi] to (0,1].



end