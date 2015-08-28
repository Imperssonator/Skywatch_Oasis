function [] = whist(Data)
% Weighted Histogram

HData = [];

for i = 1:length(Data)
    HData = [HData; ones(round(Data(i)),1)*Data(i)];
end

figure
hist(HData,50)

end