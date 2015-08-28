function [] = LengthHist(SP)

load(SP)

F = IMS.Fibers;
figure
whist([F(:).Length])

end