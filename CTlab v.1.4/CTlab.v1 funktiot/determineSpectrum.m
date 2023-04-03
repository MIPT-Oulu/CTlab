function [kVp,mA,Cu,Al,E0,I0,maxE0,minE0] = determineSpectrum(q,tubeVoltage,tubeCurrent,copperFilter,aluminiumFilter,ax,recButtonState)
I0 = q;

%Energies in keV
E0=1:1:length(I0);

%Eliminate zero values from vector
E0=E0(I0~=0);

%Max/Min value of energy in the spectrum
maxE0 = max(E0);
minE0 = min(E0);

%String which is displayed in text box
stringforBox1='Min energy: %d keV';
stringforBox2='Max energy: %d keV';
stringforBox1 = sprintf(stringforBox1,minE0);
stringforBox2 = sprintf(stringforBox2,maxE0);

kVp=tubeVoltage;
mA=tubeCurrent;
Cu=copperFilter;
Al=aluminiumFilter;

%Plot spectrum in Spectrum figure
plot(I0,'LineWidth',2, 'Parent',ax);

limY = max(I0);
ax.YLim = [0 limY];

%Display min and max energies of the spectrum in text box
text(ax,70,limY-limY/10,stringforBox1,'Color','w','FontSize',11);
text(ax,70,limY-2*limY/10,stringforBox2,'Color','w','FontSize',11);

ax.XTickMode = 'auto';
ax.YTickMode = 'auto';
recButtonState.Enable = 'on';

end