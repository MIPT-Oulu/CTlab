function [rec,minI,maxI,h] = filteredBackprojection2(fig,text,I_logsum,mask_I,mask_water,mask_air,mask_luu,W,axis,axis2)

% h = waitbar(0,'Please wait...');
d = uiprogressdlg(fig,'Title','Please wait',...
    'Message','Calculation in progress...','Cancelable','on');
drawnow

rec=FBP_2D_opTomo(I_logsum,W);
rec1=mask_I.*rec;
rec2=mask_water.*rec;
rec3=mask_air.*rec;
rec4=mask_luu.*rec;

water=rec2(:);
water=water(water~=0);
water=abs(water);
water = mean(water);


% HU_iodine = 1000*((rec1-mean(water))/mean(water));
% HU_iodine = HU_iodine.*mask_I;
% HU_water = 1000*((rec2-mean(water))/mean(water));
% HU_water = HU_water.*mask_water;
% HU_air = 1000*((rec3-mean(water))/mean(water));
% HU_air = HU_air.*mask_air;
% HU_luu = 1000*((rec4-mean(water))/mean(water));
% HU_luu = HU_luu.*mask_luu;

% rec=HU_iodine+HU_water+HU_air+HU_luu;
% rec=1000*((rec-mean(water))/mean(water));
rec=1000*((rec-mean(water))/mean(water));
%             imshow(rec,[], 'Parent', axis);
drawnow
pause(1)
h = histogram(axis2, rec, 'FaceColor','Black','EdgeColor', 'none');
% h.EdgeColor = 'r'
h.FaceColor = [0.50,0.62,0.67];
h.FaceAlpha = 0.4;
% minI=min(h.BinEdges);
% maxI=max(h.BinEdges);
minI=h.BinLimits(1);
maxI=h.BinLimits(2);
I = imshow(rec,[minI-minI/2 maxI+maxI/2], 'Parent', axis, ...
    'XData', [0 axis.Position(3)], ...
    'YData', [0 axis.Position(4)]);
% Set limits of axes
axis.XLim = [0 I.XData(2)];
axis.YLim = [0 I.YData(2)];
%imshow(rec,[], 'Parent', axes);
d.Value = 1;
d.Message = sprintf(text);
pause(1);
close(d);
display(minI);
display(maxI);
% F = findall(0,'type','figure','tag','TMWWaitbar')

end