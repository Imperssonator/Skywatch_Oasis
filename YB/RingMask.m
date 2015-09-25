function c_mask = RingMask(ci,cj,iw,ih,r)

[x,y]=meshgrid(-(cj-1):(iw-cj),-(ci-1):(ih-ci));
% disp(size(x))
% disp(size(y))
c_mask=((x.^2+y.^2)<=(r+0.5)^2 & (x.^2+y.^2)>=(r-0.5)^2);
% c_mask=c_mask';
% disp(size(c_mask))
% imagesc(c_mask)

end