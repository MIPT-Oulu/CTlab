function [rec,minI,maxI,h]=tikhonovReg(fig,W,N,I_logsum,mask_I,mask_water,mask_air,mask_luu,alpha,axis,axis2)

%% Tikhonov regularization:
% ||Ax-b||_2^2 +  alpha||x||_2^2
% https://www.fips.fi/slides/Bubba_SummerSchoolVFIP2019_2.pdf 

% alpha = 1; %säännöllistämisen voimakkuus

d = uiprogressdlg(fig,'Title','Please wait',...
    'Message','Calculation in progress...','Cancelable','on');
drawnow


mja =  opOnes([1,size(W, 2)]);
mja = sqrt(alpha)*mja;

A_tilde = vertcat(W, mja);

x = zeros([N,N]);
mja = zeros([prod(size(x)),1]);
b_tilde = cat(1,I_logsum(:),0);

x_PNStik = inv(A_tilde'*A_tilde)*A_tilde'*b_tilde;

rec=reshape(x_PNStik,[N,N]);

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

I = imshow(rec,[minI+minI/2 maxI+maxI/2], 'Parent', axis, ...
    'XData', [0 axis.Position(3)], ...
    'YData', [0 axis.Position(4)]);

% Set limits of axes
axis.XLim = [0 I.XData(2)];
axis.YLim = [0 I.YData(2)];

pause(2)
d.Value = 1;
d.Message = sprintf('Tikhonov Regularization reconstruction calculated');
pause(1)
close(d)

end