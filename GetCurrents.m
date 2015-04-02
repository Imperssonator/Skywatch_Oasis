clear all

numsims = 11;

C = zeros(numsims,3);

for i = 1:numsims
    filename = ['First/' num2str(i-1) '.out'];
    disp(filename)
    buffer = fileread(filename);
%     disp(buffer)
    pattern = 'CURRENT';
    Cloc = regexp(buffer,pattern);
    Current = buffer(Cloc+14:Cloc+25);
    disp(Current)
    Cclean = regexprep(Current,'[^e0-9\.\-]','');
    disp(Cclean)
    Cnum = str2num(Cclean);
    disp(Cnum)
    C(i,1) = Cnum;
    
    pattern = 'Vds';
    Vdsloc = regexp(buffer,pattern);
    Vdsstr = buffer(Vdsloc+4:Vdsloc+6);
    Vdsclean = regexprep(Vdsstr,'[^0-9\-\.]','');
    Vdsnum = str2num(Vdsclean);
    disp(Vdsnum)
    C(i,2) = Vdsnum;
    
    pattern = 'Vg';
    Vgloc = regexp(buffer,pattern);
    Vgstr = buffer(Vgloc+3:Vgloc+5);
    Vgclean = regexprep(Vgstr,'[^0-9\-\.]','');
    Vgnum = str2num(Vgclean);
    disp(Vgnum)
    C(i,3) = Vgnum;
    
end

figure

plot(C(:,2),C(:,1),'ob')


