function [energyWindows, numBins, xl] = energySampling(maxEnergy, minEnergy, bin, ax3)

res=mod(maxEnergy-minEnergy, bin);

energyWindows = minEnergy:bin:maxEnergy;


if res ~= 0
    energyWindows = [energyWindows max(energyWindows)+res']
end

for k=1:length(energyWindows)
    xl=xline(energyWindows(k),':','Parent',ax3)
    xl.Color = 'w'
    hold on
end

   numBins = length(energyWindows);
   
   display(numBins)

close

end