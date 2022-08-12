function [rec,minI,maxI]=spinner(spin,spectralIm,minIntensity,maxIntensity,energyWindows,I0,bin,minE0,maxE0,ax2,ax3,ax4)

rec=imshow(spectralIm(:,:,spin),[minIntensity(spin)-minIntensity(spin)/2 maxIntensity(spin)+maxIntensity(spin)/2],'Parent',ax2, 'XData', [0 ax2.Position(3)],'YData', [0 ax2.Position(4)])
ax2.Title.String = sprintf('Spectral Reconstruction %d, Energy range: %d keV - %d keV',spin,energyWindows(spin),energyWindows(spin+1))
h=histogram(ax4, spectralIm(:,:,spin), 'FaceColor','Black','EdgeColor', 'none');
h.FaceColor = [0.50,0.62,0.67];
h.FaceAlpha = 0.4;

ax2.XLim = [0 rec.XData(2)];
ax2.YLim = [0 rec.YData(2)];
minI=h.BinLimits(1);
maxI=h.BinLimits(2);

plot(I0,'LineWidth',2, 'Parent',ax3);

R=rectangle('Position', [energyWindows(spin), 0, energyWindows(spin+1)-energyWindows(spin), 10000000],'FaceColor', [0, 0.5, 0.5, 0.7], 'EdgeColor', [0, 0.5, 0.5, 0.7],'LineWidth', 1.5,'Parent',ax3)


for k=1:length(energyWindows)
    
    xline(energyWindows(k),':','Parent',ax3,'Color','w')
    
    hold on
    
end

axis([0 length(energyWindows) 0 10000])


close

end