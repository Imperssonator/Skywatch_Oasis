for i = 33:38
    
    load(Nabil{i,2})
    AngleColorMap(Nabil{i,2})
    figurei = figure;
    axes1 = axes('Parent',figurei,'FontSize',16);
%% Uncomment the following line to preserve the Y-limits of the axes
    ylim(axes1,[0 1]);
    box(axes1,'on');
    hold(axes1,'on');
    plot(IMS.D,IMS.Sd,'ob')
    xlabel('Radius (nm)')
    ylabel('2-D Nematic Order Parameter')
    title(Nabil{i,1})
    
end