figure(1)
imshow(whatever)
hold on
boxs=[7 7];
    jump=7;
    Y=1:jump:size(im,1)-boxs(1); %ROWS
    X=1:jump:size(im,2)-boxs(2); %COLS
    %Plot the director field.
    order=jump/2;
    for ii=1:(size(X,2)-1);
        for jj=1:(size(Y,2)-1);

            %finds the centers of each box (for plotting purposes.
            xc=(X(ii)+boxs(1)/2);
            yc=(Y(jj)+boxs(2)/2);
            if isin(round(yc),round(xc))==1
                theta=DirStack(round(yc),round(xc),i)*pi; %orientations here

                x1=xc+cos(theta)*order;
                y1=yc+sin(theta)*order;

                x2=xc-cos(theta)*order;
                y2=yc-sin(theta)*order;

                plot([x1 x2],[y1 y2],'LineWidth',1,'Color','b')
            end
        end
    end
    hold off