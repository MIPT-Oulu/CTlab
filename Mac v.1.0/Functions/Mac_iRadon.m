function [rec,minI,maxI] = Mac_iRadon(fig,text,I_logsum,I_logsum_w,mask_I,mask_water,mask_air,mask_luu,minStep,step,maxStep,detWidth,imageVolume,axis,axis2)

d = uiprogressdlg(fig,'Title','Please wait',...
    'Message','Calculation in progress...','Cancelable','on');
drawnow

rec = iradon(I_logsum',minStep+1:step:maxStep+1,imageVolume);
p=phantom(imageVolume);
Wmask = p < 0.21 & p > 0.19;

I_w = radon(Wmask,minStep:step:maxStep,imageVolume);
I_w = iradon(I_w,minStep:step:maxStep,imageVolume);
I_w = I_w < 2.5 & I_w > 1.5;

rec2=I_w.*rec;
water=rec2(:);
water=water(water~=0);
water=abs(water);
water = mean(water);

rec=1000*((rec-mean(water))/mean(water));

drawnow
pause(1)

h = histogram(axis2, rec, 'FaceColor','Black','EdgeColor', 'none');
h.FaceColor = [0.50,0.62,0.67];
h.FaceAlpha = 0.4;

minI=h.BinLimits(1);
maxI=h.BinLimits(2);

I = imshow(rec,[-3000 3000], 'Parent', axis, ...
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

end