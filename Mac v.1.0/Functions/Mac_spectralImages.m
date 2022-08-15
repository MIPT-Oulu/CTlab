function [spectralIm,spectLength,minInt1,maxInt2,kk]=Mac_spectralImages(fig,valAlg,minE,bins,maxE,I,I0,I_water,mask_I,mask_water,mask_air,mask_luu,energyWindows,minAngle,stepAngle,maxAngle,detWidth,imageVolume,detectorWidth,ax2,ax3,ax4)

d = uiprogressdlg(fig,'Title','Please wait',...
    'Message','Calculation in progress...','Cancelable','on');
drawnow

res=mod(maxE-minE, bins);

k = minE:bins:maxE;
kk=length(k)-1;

if res ~= 0
    k = [k max(k)+res];
    kk=length(k)-1;
end


for i=1:length(k)-1
    spectralImages(:,:,i) = sum(I(:,:,k(i):k(i+1)),3);
    water(:,:,i) = sum(I_water(:,:,k(i):k(i+1)),3);
end

spectLength=size(spectralImages);
spectLength=spectLength(3);

F=115/81;
X=imageVolume-detectorWidth;
X=F*X;

for j=1:spectLength
    
    spectralImages_logsum(:,:,j) = -log(spectralImages(:,:,j)/sum(I0(k(j):k(j+1))))/0.1;
    water_logsum(:,:,j) = -log(water(:,:,j)/sum(I0(k(j):k(j+1))))/0.1;
    E_logsum=spectralImages_logsum(:,:,j);
    E_logsum(isnan(E_logsum))=0;
    
end

if imageVolume > detectorWidth
    spectralImages_logsum = spectralImages_logsum(X/2:end-X/2,:,:);
    water_logsum = water_logsum(X/2:end-X/2,:,:);
end

if (strcmp(valAlg,'Filtered backprojection (FBP)')==1)
    for j=1:spectLength
        ax2.Title.String = sprintf('Spectral Reconstruction %d, Energy range: %d keV - %d keV',j,energyWindows(j),energyWindows(j+1));
        I_logsum = spectralImages_logsum(:,:,j)';
        I_water_logsum=water_logsum(:,:,j)';
        text=sprintf('Spectral Reconstruction %d, Energy range: %d keV - %d keV',j,energyWindows(j),energyWindows(j+1))

        [rec,minI,maxI] = Mac_iRadon(fig,text,I_logsum,I_water_logsum,mask_I,mask_water,mask_air,mask_luu,minAngle,stepAngle,maxAngle,detWidth,imageVolume,ax2,ax4)
        minInt1(j) = minI;
        maxInt2(j) = maxI;
        spectralIm(:,:,j)=rec;
        
        R=rectangle('Position', [energyWindows(j), 0, energyWindows(j+1)-energyWindows(j), 1000000000000],'FaceColor', [0, 0.5, 0.5, 0.7], 'EdgeColor', [0, 0.5, 0.5, 0.7],'LineWidth', 1.5,'Parent',ax3);
        
        for k=1:length(energyWindows)
            
            xl=xline(energyWindows(k),':','Parent',ax3);
            xl.Color = [1,1,1];
            
            hold on
        end
 
        d.Value = i/length(I0);
        d.Message = sprintf('Reconstruction for energy %d keV Calculated',i);

        close
        
    end

close(d)
end
