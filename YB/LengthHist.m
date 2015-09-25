function [] = LengthHist(SP)

load(SP)

F = IMS.Fibers;
figure
whist([F(:).Length])
xlabel('Fiber length (nm)')
ylabel('Total length of fibers of length x')

end