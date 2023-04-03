function [I0, E0, minE0, maxE0,kVp,mA,aluminiumFilter,copperFilter] = polySpectra(ax,name1,name2)
%Reads a previously defined X-ray spectrum file and visualizes it on the program screen

load(name2)

info{1,1}=spectra{151,2};

for ii=1:4
    info{1,ii} = spectra{150+ii,2}
end

info=string(info);

I0 = spectra;
I0(154,:)=[];
I0(153,:)=[];
I0(152,:)=[];
I0(151,:)=[];
I0=I0(:,2);
I0 = cell2mat(I0);
I0(isnan(I0)) = [];
I0 = round(I0,1);

E0=1:1:length(I0);
E0=E0';

E0=E0(I0~=0);

maxE0 = max(E0);
minE0 = min(E0);

stringforBox1='Min energy: %d keV';
stringforBox2='Max energy: %d keV';
stringforbox3 ='Peak kilovoltage: %d kV';
stringforBox1 = sprintf(stringforBox1,minE0);
stringforBox2 = sprintf(stringforBox2,maxE0);

kVp=str2num(info(1));
stringforBox3 = sprintf(stringforbox3,kVp);
mA=str2num(info(2));
aluminiumFilter = str2num(info(3));
copperFilter = str2num(info(4));

plot(I0,'LineWidth',2, 'Parent',ax);

limY = max(I0);
ax.YLim = [0 limY];

text(ax,70,limY-limY/10,stringforBox1,'Color','w','FontSize',11);
text(ax,70,limY-2*limY/10,stringforBox2,'Color','w','FontSize',11);

ax.XTickMode = 'auto';
ax.YTickMode = 'auto';

end
