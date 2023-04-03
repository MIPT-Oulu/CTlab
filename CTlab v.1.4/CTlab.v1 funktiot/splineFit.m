function [attI, attW, attA, attB] = splineFit(E,U,iodineD,waterD,boneD,airD)

%input
%output


% Use SplineFit to fit the attenuation curve to the data from NIST
splineFitIodine = fit(E.E(:,3), U.U(:,3), 'smoothingspline', 'SmoothingParam',1);
splineFitWater = fit(E.E(:,1), U.U(:,1), 'smoothingspline', 'SmoothingParam', 1);
splineFitAir = fit(E.E(:,4), U.U(:,4), 'smoothingspline', 'SmoothingParam', 1);
splineFitBone = fit(E.E(:,2), U.U(:,2), 'smoothingspline', 'SmoothingParam', 1);

%Attenuation coefficients for different energies:
attI=zeros(1,150);
attW=zeros(1,150);
attA=zeros(1,150);
attB=zeros(1,150);

i=0.001:0.001:0.150;
j=round(i*1000);
attI(j)=splineFitIodine(i)*iodineD; %attenuation coefficient for iodine
attW(j)=splineFitWater(i)*waterD;   %attenuation coefficient for water
attA(j)=splineFitAir(i)*airD;       %attenuation coeffisient for air
attB(j)=splineFitBone(i)*boneD;     %attenuation coefficient for bone

end