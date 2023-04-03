function [p,W,I_logsum,I,maskIodine, maskWater, maskAir, maskBone] = calculateProjections(fig,minAngle,stepAngle,maxAngle,imageVolume,...
                                                                     detectorElementsize,detectorWidth,I0,imageNoise,minE0,maxE0,time,...
                                                                     geom, SOD, ODD,mA)
          
d = uiprogressdlg(fig,'Title','Please wait',...
    'Message','Calculation in progress...','Cancelable','on');
drawnow

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                      1.Attenuation data for different energies                       %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Example densities (g/cm^3) for different materials in Shepp-Logan phantom
boneDensity = 0.96;
waterDensity = 0.5;
iodineDensity =0.037;
airDensity = 0.001225;

[attenuationMatrix,energyMatrix]=loadAttenuationData()
p=loadPhantom(imageVolume);


%Mass attenuation coefficients data of iodine, water, air & bone: NIST
%(https://www.nist.gov/pml/x-ray-mass-attenuation-coefficients)
%Import data from a spreadsheet

[u_iodine_E, u_water_E, u_air_E, u_bone_E] = splineFit(energyMatrix,attenuationMatrix,iodineDensity,waterDensity,boneDensity,airDensity);

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%              2.Parameters for volume & projection geometry and also for noise:                 %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

W = systemMatrix(minAngle,stepAngle,maxAngle,geom,imageVolume,detectorElementsize,detectorWidth);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                           3.Masks for different tissues and materials:                            %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[maskIodine,maskWater,maskAir,maskBone]=calculateMasks(p);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                  4.Forward project basis materials:                               %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[projIodine,projWater,projAir,projBone]=forwardprojectPhantomMaterials(W,maskIodine,maskWater,maskAir,maskBone);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                   5.Forward projections (Beer-Lambert law) for different energies:                 %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

I=forwardprojectBeerLambert(minE0,maxE0,u_air_E,u_water_E,u_iodine_E,u_bone_E,projAir,...
                            projWater,projIodine,projBone,imageNoise,mA,time,I0,d);


I_logsum = -log(sum(I,3)/sum(I0))/0.1;

close(d)
findall(0,'type','figure','tag','TMWWaitbar')

end