FL = zeros(18,1);

for i = 1:length(DEV)
    disp(i)
    load(DEV(i).Seg);
    disp('loaded')
    Fibers = MAXCONF~=0;
    REGS = regionprops(Fibers,'MajorAxisLength');
    Lengths = [REGS(:).MajorAxisLength];
    FL(i,1) = mean(Lengths);
end