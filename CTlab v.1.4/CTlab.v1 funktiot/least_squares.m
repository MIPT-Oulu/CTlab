function [rec,minI,maxI,h]=least_squares(fig,W, I_logsum, mask_I,mask_water,mask_air,mask_luu, iterations,axis,axis2)

d = uiprogressdlg(fig,'Title','Please wait',...
    'Message','Calculation in progress...','Cancelable','on');
drawnow

y = lsqr(W, I_logsum(:), 1e-6, iterations);
rec = reshape(y, W.vol_size);

rec1=mask_I.*rec;
rec2=mask_water.*rec;
rec3=mask_air.*rec;
rec4=mask_luu.*rec;

water=rec2(:);
water=water(water~=0);
water=abs(water);
water = mean(water);

rec=1000*((rec-mean(water))/mean(water));

h = histogram(axis2, rec, 'FaceColor','Black','EdgeColor', 'none');
h.FaceColor = [0.50,0.62,0.67];
h.FaceAlpha = 0.4;
minI=min(h.BinEdges);
maxI=max(h.BinEdges);

I = imshow(rec,[minI-minI/2 maxI+maxI/2], 'Parent', axis, ...
    'XData', [0 axis.Position(3)], ...
    'YData', [0 axis.Position(4)]);

% Set limits of axes
axis.XLim = [0 I.XData(2)];
axis.YLim = [0 I.YData(2)];

drawnow
pause(1)

pause(2)
d.Value = 1;
d.Message = sprintf('Leasts Squares reconstruction calculated');
pause(1)
close(d)

end