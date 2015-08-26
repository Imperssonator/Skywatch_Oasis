function [] = FiberPlot(SP)

load(SP)

F = IMS.Fibers;
EndLookup = IMS.EndLookup;
EndLib = IMS.EndLib;
Labeled = IMS.SLabel;
[m n] = size(Labeled);
Labels = [];

for i = 1:length(F)
    disp(i)
    if length(F(i).Fiber)>17
        Fiber = F(i).Fiber;
        disp(length(Fiber))
        FirstEnds = Fiber(1:2:end);
        disp(FirstEnds)
        for e = FirstEnds
            LibInd = EndLookup(e,:);
            Labels = [Labels EndLib(LibInd(1),LibInd(2)).Label];
        end
        disp(Labels)
        disp(length(Labels))
        break
    end
end

Stitched = zeros(m, n);

for l = Labels
    Stitched = Stitched + double(Labeled==l);
end

imtool(Stitched)
save('FP')
end
            
        
        